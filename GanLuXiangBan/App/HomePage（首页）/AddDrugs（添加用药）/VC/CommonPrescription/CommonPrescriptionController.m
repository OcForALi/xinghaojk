//
//  CommonPrescriptionController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CommonPrescriptionController.h"

#import "ContinueModel.h"
#import "PrescriptionView.h"
#import "SearchView.h"
#import "PrescriptionRequest.h"

@interface CommonPrescriptionController ()
@property (nonatomic, strong) PrescriptionView *tableView;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, copy) NSString *keyString;
@end

@implementation CommonPrescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setupUI];
    self.pageNo = 1;
    [self requestDatas];
}

- (void)requestDatas {
    WS(weakSelf)
    [[PrescriptionRequest new] getCommonRecipelist:self.pageNo key:self.keyString complete:^(HttpGeneralBackModel * _Nonnull model) {
        [weakSelf resetRefresh];
        if (model && model.data) {
            NSArray *array = model.data;
            NSMutableArray *dataArray = [NSMutableArray array];
            if (weakSelf.pageNo > 1) {
                [dataArray addObjectsFromArray:weakSelf.tableView.dataSources];
            }
            for (NSDictionary *dict in array) {
                PrescriptionModel *drugModel = [PrescriptionModel new];
                [drugModel setValuesForKeysWithDictionary:dict];
                [dataArray addObject:drugModel];
            }
            BOOL hidden = 10 * weakSelf.pageNo > dataArray.count;
            weakSelf.tableView.mj_footer.hidden = hidden;
            weakSelf.tableView.dataSources = dataArray;
        }
    }];
}

- (void)resetRefresh {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)setupUI {
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.tableView = [[PrescriptionView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.topSpaceToView(self.searchView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(ScreenHeight-90-64-kNavbarSafeHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabbarSafeBottomMargin, 0);
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestDatas];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf requestDatas];
    }];
    
    self.tableView.SelectedPrescriptionBlock = ^(PrescriptionModel * _Nonnull model) {
        if (model) {
            NSString *recipeId = [NSString stringWithFormat:@"%@",@(model.recipelist_id)];
            [[PrescriptionRequest new] getCommonRecipeDetail:recipeId complete:^(HttpGeneralBackModel *model) {
                [weakSelf hideHudAnimated];
                if (model && model.data) {
                    PrescriptionDetailModel *detail = [PrescriptionDetailModel new];
                    [detail setValuesForKeysWithDictionary:model.data];
                    if (detail) {
                        BOOL flag = YES;
                        if (detail.drugs && detail.drugs.count > 0) {
                            NSMutableArray *list = [[NSMutableArray alloc] init];
                            for (NSDictionary *dict in detail.drugs) {
                                if ([dict valueForKey:@"status"]) {
                                    NSInteger status = [dict[@"status"] integerValue];
                                    if (status != 1) {
                                        NSString *string = [NSString stringWithFormat:@"%@",dict[@"drug_name"]];
                                        [list addObject:string];
                                    }
                                }
                            }
                            if (list.count > 0) {
                                NSString *title = [list componentsJoinedByString:@"、"];
                                title = [NSString stringWithFormat:@"%@，没有上架，可能没有库存，不能进行续方", title];
                                [weakSelf.view makeToast:title];
                                flag = NO;
                            }
                        }
                        if (flag) {
                            [weakSelf handleSelected:detail];
                        }
                    }
                }
            }];
        }
    };
    
    self.searchView.searchConfirm = ^(NSString *key) {
        weakSelf.pageNo = 1;
        weakSelf.keyString = key;
        weakSelf.tableView.dataSources = @[];
        [weakSelf.tableView reloadData];
        [weakSelf requestDatas];
    };
}

- (void)handleSelected:(PrescriptionDetailModel *)obj {
    if (obj.drugs) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSNumber numberWithInteger:obj.check_id] forKey:@"check_id"];
        [dic setObject:obj.check_result forKey:@"check_result"];
        [dic setObject:[NSNumber numberWithInteger:obj.recipe_id] forKey:@"code"];
        [dic setObject:obj.drugs forKey:@"druguse_items"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveCommonPrescription" object:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
