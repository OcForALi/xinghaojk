//
//  FamousDoctorViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousDoctorViewController.h"

#import "FamousView.h"
#import "FamousRequest.h"

@interface FamousDoctorViewController ()
@property (nonatomic, strong) FamousView *tableView;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation FamousDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self refreshTableView];
    self.pageNo = 1;
    [self loadDoctorDatas];
}

- (void)loadDoctorDatas {
    WS(weakSelf)
    [[FamousRequest new] list:self.pageNo complete:^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        if (weakSelf.pageNo > 1) {
            [array addObjectsFromArray:weakSelf.tableView.dataSources];
        }
        
        for (NSDictionary *dict in generalBackModel.data) {
            FamousModel *model = [FamousModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
        }
        weakSelf.tableView.dataSources = array;
        
        NSInteger total = 10 * weakSelf.pageNo;
        NSDictionary *pageinfo = (NSDictionary *)(generalBackModel.pageinfo);
        if (pageinfo && pageinfo[@"total"]) {
            total = [pageinfo[@"total"] integerValue];
        }
        BOOL flag = weakSelf.tableView.dataSources.count >= total;
        if (flag) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
}

- (void)setupViews {
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    headerView.sd_layout.topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(36);
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"温馨提示:排名不分先后，以下根据医生姓名拼音首字母顺序排列";
    tip.textColor = kSixColor;
    tip.adjustsFontSizeToFitWidth = YES;
    tip.numberOfLines = 0;
    [headerView addSubview:tip];
    tip.sd_layout.topSpaceToView(headerView, 10).leftSpaceToView(headerView, 14).rightSpaceToView(headerView, 14).heightIs(16);
    
    self.tableView = [[FamousView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.topSpaceToView(headerView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    self.tableView.dataSources = @[];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    WS(weakSelf)
    self.tableView.pushBlock = ^(UIViewController *vc) {
        if (vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
}

-(void)refreshTableView {
    
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.pageNo = 1;
        weakSelf.tableView.dataSources = @[];
        [weakSelf loadDoctorDatas];
        
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageNo++;
        [weakSelf loadDoctorDatas];
        
    }];
    self.tableView.mj_footer = footer;
    
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
}

@end
