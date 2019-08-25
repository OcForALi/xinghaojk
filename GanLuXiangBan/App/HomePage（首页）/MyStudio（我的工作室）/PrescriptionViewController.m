//
//  PrescriptionViewController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "PrescriptionViewController.h"

#import "PrescriptionRequest.h"
#import "PrescriptionView.h"
#import "PrescriptionAddViewController.h"

@interface PrescriptionViewController ()
@property (nonatomic, strong) PrescriptionView *tableView;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation PrescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常用处方";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.pageNo = 1;
    [self requestDatas];
}

- (void)touchAddPrescription {
    PrescriptionAddViewController *add = [PrescriptionAddViewController new];
    [self.navigationController pushViewController:add animated:YES];
}

- (void)requestDatas {
    WS(weakSelf)
    [[PrescriptionRequest new] getCommonRecipelist:self.pageNo key:@"" complete:^(HttpGeneralBackModel * _Nonnull model) {
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

#pragma mark - UI

- (void)setupUI {
    UIButton *bottom = [self setupBottomButton:@"添加"];
    [bottom addTarget:self action:@selector(touchAddPrescription) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[PrescriptionView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(bottom, 0);
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestDatas];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf requestDatas];
    }];
}

@end
