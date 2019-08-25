//
//  ScheduleViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleView.h"
#import "ScheduleModel.h"
#import "ScheduleRequest.h"
#import "SubscribeDetailsViewController.h"

@interface ScheduleViewController ()

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) ScheduleView *scheduleView;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的日程";

    [self initUI];
    
    [self block];
    
    [self refresh];
    
    self.page = 1;
    [self.scheduleView.dataSource removeAllObjects];
    [self.scheduleView.myTable reloadData];
    
    [self request];
}

-(void)initUI{
    
    self.scheduleView = [ScheduleView new];
    self.scheduleView.noMessageLabel.text = @"您暂时没有新日程";
    [self.view addSubview:self.scheduleView];
    
    self.scheduleView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)block{
    WS(weakSelf);
    self.scheduleView.pushBlock = ^(NSString *pushString) {
        
        SubscribeDetailsViewController *subsribeDetailsView = [[SubscribeDetailsViewController alloc] init];
        subsribeDetailsView.idString = pushString;
        subsribeDetailsView.visitId = pushString;
        [weakSelf.navigationController pushViewController:subsribeDetailsView animated:YES];
        
    };
    
}

-(void)request{
    
    WS(weakSelf);
    [[ScheduleRequest new] getPreOrderListPageindex:self.page :^(HttpGeneralBackModel *genneralBackModel) {
        [weakSelf.scheduleView.myTable.mj_header endRefreshing];
        [weakSelf.scheduleView.myTable.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            ScheduleModel *model = [ScheduleModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.scheduleView addData:array];
        
        if (array.count != 0) {
            
            [weakSelf.scheduleView.NoMessageView removeFromSuperview];
            
        }
        
        NSInteger total = 10 * weakSelf.page;
        NSDictionary *pageinfo = (NSDictionary *)(genneralBackModel.pageinfo);
        if (pageinfo && pageinfo[@"total"]) {
            total = [pageinfo[@"total"] integerValue];
        }
        BOOL flag = weakSelf.scheduleView.dataSource.count >= total;
        if (flag) {
            [weakSelf.scheduleView.myTable.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.scheduleView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.scheduleView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request];
        
    }];
    self.scheduleView.myTable.mj_footer = footer;
    
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
}

@end
