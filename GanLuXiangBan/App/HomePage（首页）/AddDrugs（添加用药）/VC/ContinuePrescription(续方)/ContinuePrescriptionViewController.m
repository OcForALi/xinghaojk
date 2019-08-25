//
//  ContinuePrescriptionViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/6.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ContinuePrescriptionViewController.h"
#import "RecDrugsRequest.h"
#import "ContinueModel.h"
#import "SearchView.h"
#import "ContinuePrescriptionView.h"

@interface ContinuePrescriptionViewController ()
@property (nonatomic ,strong) ContinuePrescriptionView *continuePrescriptionView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, copy) NSString *keyString;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation ContinuePrescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNo = 1;
    [self initUI];
    
    [self request];
    
}

-(void)initUI{
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.continuePrescriptionView = [ContinuePrescriptionView new];
    [self.view addSubview:self.continuePrescriptionView];
    self.continuePrescriptionView.noMessageLabel.text = @"没有续方数据";
    
    WS(weakSelf)
    self.continuePrescriptionView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.pageNo = 1;
        [weakSelf.continuePrescriptionView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    MJRefreshAutoNormalFooter *footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageNo++;
        [weakSelf request];
        
    }];
    self.continuePrescriptionView.myTable.mj_footer = footer;
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    
//
//    self.continuePrescriptionView.sd_layout
//    .leftSpaceToView(self.view, 0)
//    .rightSpaceToView(self.view, 0)
//    .topSpaceToView(self.searchView, 0)
    self.continuePrescriptionView.sd_layout.topSpaceToView(self.searchView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(ScreenHeight-90-64-kNavbarSafeHeight);
//    self.continuePrescriptionView.myTable.contentInset = UIEdgeInsetsMake(0, 0, kTabbarSafeBottomMargin, 0);
    
    self.searchView.searchConfirm = ^(NSString *key) {
        weakSelf.keyString = key;
        [weakSelf.continuePrescriptionView.dataSource removeAllObjects];
        [weakSelf.continuePrescriptionView.myTable reloadData];
        weakSelf.pageNo = 1;
        [weakSelf request];
    };
}

- (void)request{
    NSString *mid = self.mid;
    if (!mid || mid.length == 0) {
        mid = @"0";
    }
    WS(weakSelf)
    [[RecDrugsRequest new] getXufangItemsMid:mid key:self.keyString paegNo:self.pageNo complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        [weakSelf.continuePrescriptionView.myTable.mj_header endRefreshing];
        [weakSelf.continuePrescriptionView.myTable.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            ContinueModel *model = [ContinueModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.continuePrescriptionView addData:array];
        
        NSInteger total = 20 * weakSelf.pageNo;
        NSDictionary *pageinfo = (NSDictionary *)(genneralBackModel.pageinfo);
        if (pageinfo && pageinfo[@"total"]) {
            total = [pageinfo[@"total"] integerValue];
        }
        BOOL flag = weakSelf.continuePrescriptionView.dataSource.count >= total;
        if (flag) {
            [weakSelf.continuePrescriptionView.myTable.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.continuePrescriptionView.dataSource.count > 0) {
            weakSelf.continuePrescriptionView.NoMessageView.hidden = YES;
        }
        else {
            weakSelf.continuePrescriptionView.myTable.mj_footer.hidden = YES;
            weakSelf.continuePrescriptionView.NoMessageView.hidden = NO;
        }
        
    }];
    
}

@end
