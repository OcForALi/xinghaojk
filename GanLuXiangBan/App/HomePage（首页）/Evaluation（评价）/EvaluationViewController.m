//
//  EvaluationViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationRequest.h"
#import "EvaluationModel.h"
#import "EvaluationView.h"

@interface EvaluationViewController ()

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) EvaluationView *evaluationView;

@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"患者评价";
    
    self.page = 1;
    
    [self initUI];
    
    [self request];
    
    [self refresh];
    
}

-(void)initUI{
    
    self.evaluationView = [EvaluationView new];
    [self.view addSubview:self.evaluationView];
    
    self.evaluationView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)request{
    
    WS(weakSelf);
    [[EvaluationRequest new] getEvaluatesPageindex:self.page complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        [weakSelf.evaluationView.myTable.mj_header endRefreshing];
        [weakSelf.evaluationView.myTable.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            EvaluationModel *model = [EvaluationModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.evaluationView addData:array];
        NSInteger total = 10 * weakSelf.page;
        NSDictionary *pageinfo = (NSDictionary *)(genneralBackModel.pageinfo);
        if (pageinfo && pageinfo[@"total"]) {
            total = [pageinfo[@"total"] integerValue];
        }
        BOOL flag = weakSelf.evaluationView.dataSource.count >= total;
        if (flag) {
            [weakSelf.evaluationView.myTable.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.evaluationView.dataSource.count > 0) {
            [weakSelf.evaluationView.NoMessageView removeFromSuperview];
        }
        else {
            weakSelf.evaluationView.myTable.mj_footer.hidden = YES;
        }
//        weakSelf.evaluationView.myTable.mj_footer.hidden = flag;
        //flag ? MJRefreshStateNoMoreData : MJRefreshStateIdle;
        
    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.evaluationView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.evaluationView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    MJRefreshAutoNormalFooter *footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request];
        
    }];
    self.evaluationView.myTable.mj_footer = footer;
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
}

@end
