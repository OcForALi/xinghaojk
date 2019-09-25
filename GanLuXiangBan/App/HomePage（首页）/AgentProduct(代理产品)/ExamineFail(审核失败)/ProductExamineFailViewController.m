//
//  ProductExamineFailViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ProductExamineFailViewController.h"
#import "AgentProductRequest.h"
#import "ProductExamineFailView.h"
#import "ProductModel.h"
#import "ReApplicationViewController.h"

@interface ProductExamineFailViewController ()

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) ProductExamineFailView *productExamineFailView;

@end

@implementation ProductExamineFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];

    [self refresh];

    [self block];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.page = 1;
    [self request];

}

- (void)initUI{
    
    self.productExamineFailView = [ProductExamineFailView new];
    [self.view addSubview:self.productExamineFailView];
    self.productExamineFailView.backgroundColor = kPageBgColor;
    self.productExamineFailView.noMessageLabel.text = @"暂无数据";
    [self.productExamineFailView bringSubviewToFront:self.productExamineFailView.NoMessageView];
    
    self.productExamineFailView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, kTabbarSafeBottomMargin + NavHeight);
    
}

- (void)block{
    WS(weakSelf)
    [self.productExamineFailView setPushBlock:^(ProductModel * _Nonnull model) {
        
    }];
    
    [self.productExamineFailView setReconsiderBlock:^(ProductModel * _Nonnull model) {
        
        ReApplicationViewController *reApplicationVC = [[ReApplicationViewController alloc] init];
        reApplicationVC.appID = model.appId;
        reApplicationVC.type = 1;
        reApplicationVC.noPassModel = model;
        [weakSelf.navigationController pushViewController:reApplicationVC animated:YES];
        
    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.productExamineFailView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.productExamineFailView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    self.productExamineFailView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request];
        
    }];
}

- (void)request{
    
    AgentProductRequest *agentRequest = [AgentProductRequest new];
    
    WS(weakSelf)
    [agentRequest getAgDrugLstStart:2 Page:self.page size:10 :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in generalBackModel.data[@"items"]) {
            
            weakSelf.productExamineFailView.NoMessageView.hidden = YES;
            
            ProductModel *model = [ProductModel new];
            [model setValuesForKeysWithDictionary:dict];
            model.noPassBool = YES;
            [array addObject:model];
            
        }
        
        [weakSelf.productExamineFailView addData:array];
        
        [weakSelf.productExamineFailView.myTable.mj_header endRefreshing];
        [weakSelf.productExamineFailView.myTable.mj_footer endRefreshing];
        
    } ];
    
}


@end
