//
//  ToApplyWithdrawalsViewController.m
//  GanLuXiangBan
//
//  Created by 黎智愿 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ToApplyWithdrawalsViewController.h"
#import "CheckAchievementRequest.h"

@interface ToApplyWithdrawalsViewController ()

@property (nonatomic ,strong) UIView *grayView;
///积分块
@property (nonatomic ,strong) UIView *integralView;
///兑换块
@property (nonatomic ,strong) UIView *exchangeView;
///可兑换积分
@property (nonatomic ,strong) UILabel *convertiblePointsLabel;
//总积分
@property (nonatomic ,strong) UILabel *totalScoreLabel;

@end

@implementation ToApplyWithdrawalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请提现";
    
    [self initUI];
    
    [self request];
    
}

- (void)request{
    
    CheckAchievementRequest *request = [CheckAchievementRequest new];
    [request postPointInfoRecord_type:0 Page:1 size:10 Point_date:@"" :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if (generalBackModel.data != nil) {
            
            self.convertiblePointsLabel.text = [NSString stringWithFormat:@"最多可兑换%@",generalBackModel.data[@"presentIntegral"]];
            self.totalScoreLabel.text = generalBackModel.data[@"integralBalancep"];
            
        }
        
    }];
    
}

- (void)initUI{
    
    self.grayView = [UIView new];
    self.grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.grayView];
    
    self.grayView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 50)
    .heightIs(2);
    
    self.integralView = [UIView new];
    [self.view addSubview:self.integralView];
    
    self.integralView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.grayView, 0)
    .heightIs(60);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.integralView, 0)
    .heightIs(1);
    
    self.exchangeView = [UIView new];
    [self.view addSubview:self.exchangeView];
    
    self.exchangeView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(lineView, 0)
    .bottomSpaceToView(self.view, 0);
    
    
    [self initegral];
    
    [self exchange];
    
}

- (void)initegral{
    
    UILabel *label = [UILabel new];
    label.text = @"目前总积分";
    label.font = [UIFont systemFontOfSize:14];
    [self.integralView addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.integralView, 30)
    .topSpaceToView(self.integralView, 10)
    .heightIs(14);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    self.convertiblePointsLabel = [UILabel new];
    self.convertiblePointsLabel.text = @"最多可兑换XX";
    self.convertiblePointsLabel.font = [UIFont systemFontOfSize:12];
    [self.integralView addSubview:self.convertiblePointsLabel];
    
    self.convertiblePointsLabel.sd_layout
    .leftSpaceToView(self.integralView, 30)
    .bottomSpaceToView(self.integralView, 10)
    .heightIs(14);
    [self.convertiblePointsLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.totalScoreLabel = [UILabel new];
    self.totalScoreLabel.text = @"XX";
    self.totalScoreLabel.font = [UIFont systemFontOfSize:20];
    [self.integralView addSubview:self.totalScoreLabel];
    
    self.totalScoreLabel.sd_layout
    .rightSpaceToView(self.integralView, 50)
    .topSpaceToView(self.integralView, 10)
    .heightIs(20);
    [self.totalScoreLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

- (void)exchange{
    
}

@end
