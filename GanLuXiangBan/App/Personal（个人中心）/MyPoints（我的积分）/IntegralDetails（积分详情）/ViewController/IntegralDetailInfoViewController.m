//
//  IntegralDetailInfoViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/16.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "IntegralDetailInfoViewController.h"

#import "IntegralInfoView.h"
#import "MyPointsViewModel.h"

@interface IntegralDetailInfoViewController ()
@property (nonatomic, strong) IntegralInfoView *tableView;
@end

@implementation IntegralDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分详情";
    
    self.tableView = [[IntegralInfoView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    [self loadIntegralDetailDatas];
}

- (void)loadIntegralDetailDatas {
    if (self.prescriptionId) {
        WS(weakSelf)
        [[MyPointsViewModel new] pointDetail:self.prescriptionId complete:^(id object) {
            weakSelf.tableView.model = object;
        }];
    }
}

@end
