//
//  MyPointsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyPointsView.h"
// Controller
#import "WithdrawalsViewController.h"

#import "IntegralDetailsViewController.h"

#define HeaderHeight 140

@implementation MyPointsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    [self createHeaderView];
    [self createRulesView];
}

- (void)createHeaderView {
    
    UIButton *bgButton;
    NSInteger count = 3;
    for (int i = 0; i < count; i++) {
        
        // 背景
        bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(ScreenWidth / count * i, 0, ScreenWidth / count, HeaderHeight);
        bgButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgButton];
        
        WS(weakSelf)
        [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (weakSelf.goViewControllerBlock && i <= 1) {
                IntegralDetailsViewController *vc = [IntegralDetailsViewController new];
                vc.showZTPoint = i == 1;
                weakSelf.goViewControllerBlock(vc);
            }
        }];
        
        // 可用积分
        UILabel *integralTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, bgButton.width, 15)];
        integralTitleLabel.text = i == 0 ? @"总积分" : (i == 1 ? @"在途积分" : @"已提取积分");
        integralTitleLabel.font = [UIFont systemFontOfSize:13];
        integralTitleLabel.textColor = kMainColor;
        integralTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:integralTitleLabel];
        
        // 积分
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(integralTitleLabel.frame) + 10, bgButton.width, 40)];
        numberLabel.tag = i + 666;
        numberLabel.text = @"0";
        numberLabel.font = [UIFont boldSystemFontOfSize:24];
        numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:numberLabel];
        
        if (i < count - 1) {
            // 查看明细
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numberLabel.frame) + 10, bgButton.width, 15)];
            detailLabel.text = @"查看明细";
            detailLabel.font = [UIFont systemFontOfSize:13];
            detailLabel.textColor = [UIColor colorWithHexString:@"0xc6c6c6"];
            detailLabel.textAlignment = NSTextAlignmentCenter;
            [bgButton addSubview:detailLabel];
        }
    }
    
    for (NSInteger i = 1; i < count; i++) {
        // 线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / count * i, 15, 0.5, bgButton.height - 30)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [self addSubview:lineView];
    }
    
    // 底部线条
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, bgButton.height - 0.5, ScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [self addSubview:bottomLineView];
}

- (void)createRulesView {
    
    // 背景
    UIView *rulesView = [[UIView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, self.height - HeaderHeight)];
    rulesView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rulesView];
    
    // 兑换
    UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exchangeBtn.frame = CGRectMake(0, rulesView.height - 50, ScreenWidth, 50);
    exchangeBtn.backgroundColor = kMainColor;
    exchangeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [exchangeBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rulesView addSubview:exchangeBtn];
    [[exchangeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        if (self.goViewControllerBlock) {
            
            WithdrawalsViewController *vc = [WithdrawalsViewController new];
            vc.pointString = self.model.AvailableIntegral;
            self.goViewControllerBlock(vc);
        }
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, 0)];
    titleLabel.text = @"积分规则 :";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.height = [titleLabel getTextHeight];
    [rulesView addSubview:titleLabel];
    
    // 内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 10, ScreenWidth - 30, 0)];
    contentLabel.text = @"1、积分来源：用户可通过服务患者获得积分奖励；\n2、积分兑换：\n• 兑换比例：10积分=1元，最低兑换单位为10积分；\n• 兑换条件：积分达到1000积分或以上，且通过医生实名认证和绑定银行卡，方可申请兑换；\n• 兑换日期：医生可在APP中自主申请兑换，T+2（工作日）到账；\n• 其他兑换事项：如遇不可抗因素，如自然灾害、节假日、银行系统问题、账户问题等，兑换日期则可能顺延，具体日期视实际情况而定，敬请谅解！\n3、如医生所获积分非通过正常手段获取，一经发现将对违规积分进行清零；\n4、积分最终解释权归“幸好健康”所有；";
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    contentLabel.height = [contentLabel getTextHeight];
    [rulesView addSubview:contentLabel];
}

- (void)setModel:(MyPointModel *)model {
    
    _model = model;
    for (int i = 0; i < 3; i++) {
        
        UILabel *numberLabel = [self viewWithTag:i + 666];
        numberLabel.text = i == 0 ? model.integralBalancep : (i == 1 ? model.ztIntegral : model.presentIntegral);
    }
}

@end
