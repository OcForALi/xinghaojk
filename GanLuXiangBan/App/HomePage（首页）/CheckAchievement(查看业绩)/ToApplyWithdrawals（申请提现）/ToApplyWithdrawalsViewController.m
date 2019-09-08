//
//  ToApplyWithdrawalsViewController.m
//  GanLuXiangBan
//
//  Created by 黎智愿 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ToApplyWithdrawalsViewController.h"
#import "CheckAchievementRequest.h"
#import "BaseTextField.h"
#import "MyCardViewController.h"
#import "MyCardViewModel.h"

@interface ToApplyWithdrawalsViewController ()
///银行卡模块
@property (nonatomic ,strong) UIView *bankCardView;
///银行卡号&银行
@property (nonatomic ,strong) UILabel *cardLabel;

@property (nonatomic ,strong) UIView *grayView;
///积分块
@property (nonatomic ,strong) UIView *integralView;
///兑换块
@property (nonatomic ,strong) UIView *exchangeView;
///可兑换积分Label
@property (nonatomic ,strong) UILabel *convertiblePointsLabel;
///总积分
@property (nonatomic ,strong) UILabel *totalScoreLabel;
///兑换积分
@property (nonatomic ,strong) BaseTextField *toRedeemTextField;
///可兑换积分
@property (nonatomic ,assign) NSInteger convertiblePointsIneteger;
///银行卡ID
@property (nonatomic ,assign) NSInteger cardID;

@property (nonatomic ,copy) CheckAchievementRequest *checkAchievementRequest;

@end

@implementation ToApplyWithdrawalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请提现";
    
    [self initUI];
    
    [self request];
    
}

- (CheckAchievementRequest *)checkAchievementRequest {
    
    if (!_checkAchievementRequest) {
        
        _checkAchievementRequest = [CheckAchievementRequest new];
    }
    
    return _checkAchievementRequest;
}

- (void)request{
    WS(weakSelf);
    
    [self.checkAchievementRequest postPointInfoRecord_type:0 Page:1 size:10 Point_date:@"" :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if (generalBackModel.data != nil) {
            NSString *string = generalBackModel.data[@"presentIntegral"];
            weakSelf.convertiblePointsLabel.text = [NSString stringWithFormat:@"最多可兑换%@",string];
            weakSelf.totalScoreLabel.text = generalBackModel.data[@"integralBalancep"];
            weakSelf.convertiblePointsIneteger = [string integerValue];
        }
        
    }];
    
    MyCardViewModel *cardModel = [MyCardViewModel new];
    [cardModel getUserBankListComplete:^(id object) {
        
        for (MyCardModel *myCardModel in object) {
            
            if ([myCardModel.is_default boolValue] == YES) {
                
                weakSelf.cardLabel.text = [NSString stringWithFormat:@"%@(%@)",myCardModel.card_no,myCardModel.bank];
                weakSelf.cardID = [myCardModel.pkid integerValue];
            }
            
        }
        
    }];
    
}

- (void)initUI{
    
    self.bankCardView = [UIView new];
    self.bankCardView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bankCardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankCardTap:)];
    [self.bankCardView addGestureRecognizer:bankCardTap];
    [self.view addSubview:self.bankCardView];
    
    self.bankCardView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.grayView = [UIView new];
    self.grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.grayView];
    
    self.grayView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.bankCardView, 0)
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
    
    [self bankCard];
    
    [self initegral];
    
    [self exchange];
    
}

- (void)bankCard{
    
    UILabel *label = [UILabel new];
    label.text = @"银行卡";
    [self.bankCardView addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.bankCardView, 30)
    .centerYEqualToView(self.bankCardView)
    .heightIs(16);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    self.cardLabel = [UILabel new];
    self.cardLabel.text = @"尾号XXXX （XX 银行）";
    self.cardLabel.font = [UIFont systemFontOfSize:14];
    [self.bankCardView addSubview:self.cardLabel];
    
    self.cardLabel.sd_layout
    .rightSpaceToView(self.bankCardView, 30)
    .centerYEqualToView(self.bankCardView)
    .heightIs(14);
    [self.cardLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

- (void)initegral{
    
    UILabel *label = [UILabel new];
    label.text = @"目前总积分";
    label.font = [UIFont systemFontOfSize:16];
    [self.integralView addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.integralView, 30)
    .topSpaceToView(self.integralView, 10)
    .heightIs(16);
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
    self.totalScoreLabel.text = @"0";
    self.totalScoreLabel.font = [UIFont systemFontOfSize:20];
    [self.integralView addSubview:self.totalScoreLabel];
    
    self.totalScoreLabel.sd_layout
    .rightSpaceToView(self.integralView, 50)
    .topSpaceToView(self.integralView, 10)
    .heightIs(20);
    [self.totalScoreLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

- (void)exchange{
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [button setTitle:@"确认兑换" forState:UIControlStateNormal];
    [button setTitleColor:kMainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(exchangeRedeem:) forControlEvents:UIControlEventTouchUpInside];
    [self.exchangeView addSubview:button];
    
    button.sd_layout
    .rightSpaceToView(self.exchangeView, 30)
    .topSpaceToView(self.exchangeView, 10)
    .widthIs(100)
    .heightIs(40);
    
    self.toRedeemTextField = [BaseTextField textFieldWithPlaceHolder:@"请填写需要兑换的积分数量" headerViewText:nil];
    self.toRedeemTextField.backgroundColor = [UIColor whiteColor];
    self.toRedeemTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.toRedeemTextField.font = [UIFont systemFontOfSize:14];
    [self.exchangeView addSubview:self.toRedeemTextField];
    
    self.toRedeemTextField.sd_layout
    .centerYEqualToView(button)
    .heightIs(30)
    .leftSpaceToView(self.exchangeView, 30)
    .rightSpaceToView(button, 10);
    
    UILabel *label = [UILabel new];
    label.text = @"温馨提示：\n1、积分申请兑换后，T+2（工作日）到账；\n2、如积分兑换遇不可抗因素，如自然灾害、节假日、银行系统问题、账户问题等，兑换日期则可能顺延，具体日期视实际情况而定，敬请谅解！";
    label.font = [UIFont systemFontOfSize:14];
    [self.exchangeView addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.exchangeView, 30)
    .rightSpaceToView(self.exchangeView, 30)
    .topSpaceToView(self.toRedeemTextField, 20)
    .autoHeightRatio(0);
    
}

- (void)exchangeRedeem:(UIButton *)sender{
    
    if ([self.toRedeemTextField.text integerValue] > self.convertiblePointsIneteger) {
        [self.view makeToast:@"兑换积分超过最多可兑换积分"];
        return;
    }
    if (self.cardID == 0) {
        [self.view makeToast:@"请选择默认银行卡"];
        return;
    }
    
    [self.checkAchievementRequest postPointExchangeBank_id:self.cardID point_num:[self.toRedeemTextField.text integerValue] :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if (generalBackModel.retcode == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
}

- (void)bankCardTap:(UITapGestureRecognizer *)sender{
    
    MyCardViewController *myCardVC = [[MyCardViewController alloc] init];
    [self.navigationController pushViewController:myCardVC animated:YES];
    
}

@end
