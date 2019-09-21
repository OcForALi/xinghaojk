//
//  CheckAchievementViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CheckAchievementViewController.h"
#import "ToApplyWithdrawalsViewController.h"
#import "CheckAchievementRequest.h"
#import "IntegralDetailsViewController.h"

@interface CheckAchievementViewController ()

@property (nonatomic ,strong) UIView *lineView;

@end

@implementation CheckAchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"业绩查看";
    
    [self initUI];
    	
    [self request];
    
}

- (void)initUI{
    
    [self integralBar];
    
    UIView *gayView = [UIView new];
    gayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gayView];
    
    gayView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.lineView, 15)
    .heightIs(2);
    
    UILabel *label = [UILabel new];
    label.text = @"积分规则\n1、积分来源：用户可通过幸好健康获得积分奖励；\n\n2、积分兑换：\n• 兑换比例：10积分=1元，最低兑换单位为10积分；\n• 兑换条件：积分达到1000积分或以上，幸好健康实名认证和绑定银行卡，访客申请兑换；\n• 兑换日期：人员在APP中自主申请兑换，T+2（工作日）到账；\n• 其他兑换事项：如遇不可抗因素，如自然灾害、节假日、银行系统问题、账户问题等，兑换日期则可能顺延，具体日期视实际情况而定，敬请谅解！\n\n3、幸好健康获积分非通过正常手段获取，一经发现将对违规积分进行清零；\n\n4、积分最终解释权归“幸好健康”所有；";
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .centerXEqualToView(self.view)
    .topSpaceToView(gayView, 20)
    .autoHeightRatio(0);
    
    UIButton *button = [UIButton new];
    button.backgroundColor = kMainColor;
    button.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [button setTitle:@"申请提现" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(withdrawal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(40);
    
}

- (void)integralBar{
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.lineView];
    
    self.lineView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 15)
    .widthIs(1)
    .heightIs(100);
    
    UIView *leftView = [UIView new];
    leftView.userInteractionEnabled = YES;
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
    [leftView addGestureRecognizer:leftTap];
    [self.view addSubview:leftView];
    
    leftView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.lineView, 0)
    .centerYEqualToView(self.lineView)
    .heightIs(130);
    
    
    
    UIView *rightView = [UIView new];
    [self.view addSubview:rightView];
    
    rightView.sd_layout
    .rightSpaceToView(self.view, 0)
    .widthRatioToView(leftView, 1)
    .centerYEqualToView(self.lineView)
    .heightIs(130);
    
    NSArray *array = @[
                       @[@"可用积分",@"0",@"查看明细"],
                       @[@"已提现积分",@"0"]
                       ];
    
    NSInteger integer = 0;
    
    for (int i = 0; i < array.count; i++) {
        
        NSArray *itemArray = array[i];
        
        for (int j = 0; j < itemArray.count; j++) {
            
            UILabel *label = [UILabel new];
            label.text = itemArray[j];
            label.tag = j + 1000 + integer;
            switch (j) {
                case 0:
                    label.font = [UIFont systemFontOfSize:14];
                    label.textColor = kMainColor;
                    break;
                case 1:
                    label.font = [UIFont systemFontOfSize:30];
                    label.textColor = [UIColor blackColor];
                    break;
                case 2:
                    label.font = [UIFont systemFontOfSize:12];
                   label.textColor = [UIColor blackColor];
                    break;
                    
                default:
                    break;
            }
            
            switch (i) {
                case 0:
                    [leftView addSubview:label];
                    label.sd_layout
                    .centerXEqualToView(leftView)
                    .topSpaceToView(leftView, 20 + j * 35)
                    .heightIs(30);
                    break;
                case 1:
                    [rightView addSubview:label];
                    label.sd_layout
                    .centerXEqualToView(rightView)
                    .topSpaceToView(rightView, 20 + j * 35)
                    .heightIs(30);
                    break;
                default:
                    break;
            }
            [label setSingleLineAutoResizeWithMaxWidth:200];
        }
        integer = integer + itemArray.count;
    }
    
}

- (void)request{
    
    CheckAchievementRequest *request = [CheckAchievementRequest new];
    
    [request postPointInfoRecord_type:0 Page:1 size:10 Point_date:@"" :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if ([generalBackModel.data isKindOfClass:[NSNull class]] || generalBackModel.data == nil || [generalBackModel.data isKindOfClass:[NSString class]]) {
            return ;
        }
        
        UILabel *label = [self.view viewWithTag:1001];
        
        UILabel *label1 = [self.view viewWithTag:1004];
        
        if (generalBackModel.data != nil) {
            
            label.text = generalBackModel.data[@"integralBalancep"];
            label1.text = generalBackModel.data[@"presentIntegral"];
        }
        
    }];
    
}

- (void)leftTap:(UITapGestureRecognizer *)sender{
    
    IntegralDetailsViewController *integralDetailsVC = [IntegralDetailsViewController new];
    [self.navigationController pushViewController:integralDetailsVC animated:YES];
    
}

- (void)withdrawal:(UIButton *)sender{
    
    ToApplyWithdrawalsViewController *toApplyWithdrawalsVC = [[ToApplyWithdrawalsViewController alloc] init];
    
    [self.navigationController pushViewController:toApplyWithdrawalsVC animated:YES];
    
}

@end
