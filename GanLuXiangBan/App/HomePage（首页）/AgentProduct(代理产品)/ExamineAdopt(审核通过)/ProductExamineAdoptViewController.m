//
//  ProductExamineAdoptViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ProductExamineAdoptViewController.h"
#import "AgentProductRequest.h"
#import "ProductExamineFailView.h"
#import "ProductModel.h"
#import "AddProductViewController.h"

@interface ProductExamineAdoptViewController ()

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) ProductExamineFailView *productExamineFailView;

@end

@implementation ProductExamineAdoptViewController

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
    self.productExamineFailView.backgroundColor = kPageBgColor;
    self.productExamineFailView.NoMessageView.hidden = NO;
    [self.view addSubview:self.productExamineFailView];
    
    self.productExamineFailView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,NavHeight + 40);
    
    self.productExamineFailView.noMessageLabel.text = @"暂无数据";
    [self.productExamineFailView bringSubviewToFront:self.productExamineFailView.NoMessageView];
    
    UIButton *button = [UIButton new];
    button.backgroundColor = kMainColor;
    [button setTitle:@"添加代理产品" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addProduct:) forControlEvents:UIControlEventTouchUpInside];
    [self.productExamineFailView addSubview:button];
    
    button.sd_layout
    .leftSpaceToView(self.productExamineFailView, 0)
    .rightSpaceToView(self.productExamineFailView, 0)
    .bottomSpaceToView(self.productExamineFailView, 0)
    .heightIs(40);
    
    
}

- (void)addProduct:(UIButton *)sender{
    
    AddProductViewController *addVC = [AddProductViewController new];
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}

- (void)block{
    
    [self.productExamineFailView setPushBlock:^(ProductModel * _Nonnull model) {
        
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
    [agentRequest getAgDrugLstStart:1 Page:self.page size:10 :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in generalBackModel.data[@"items"]) {
            
            weakSelf.productExamineFailView.NoMessageView.hidden = YES;
            
            ProductModel *model = [ProductModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.productExamineFailView addData:array];
        
        [weakSelf.productExamineFailView.myTable.mj_header endRefreshing];
        [weakSelf.productExamineFailView.myTable.mj_footer endRefreshing];
        
    } ];
    
}

@end
