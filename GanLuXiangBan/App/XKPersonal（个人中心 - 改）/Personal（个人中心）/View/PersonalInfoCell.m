//
//  PersonalInfoCell.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/8/28.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PersonalInfoCell.h"

@interface PersonalInfoCell ()

@property (nonatomic, strong) UIView *integralView;
@property (nonatomic, strong) UIView *userInfoView;

@end

@implementation PersonalInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    NSArray *texts = @[@"总积分", @"可用积分"];
    NSArray *units = @[@"", @""];
    self.integralView = [self setInfoWithTexts:texts units:units];
    [self.contentView addSubview:self.integralView];
    
    // 底部线条
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.integralView.height - 0.5, ScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [self.contentView addSubview:bottomLineView];
    
    texts = @[@"医生", @"代理品种", @"处方数", @"订单金额"];
    units = @[@"人", @"个", @"张", @"元"];
    self.userInfoView = [self setInfoWithTexts:texts units:units];
    self.userInfoView.y = self.integralView.maxY;
    [self.contentView addSubview:self.userInfoView];
    
    self.cellHeight = self.userInfoView.maxY;
    
}

- (UIView *)setInfoWithTexts:(NSArray *)texts units:(NSArray *)units {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    for (int i = 0; i < texts.count; i++) {
        
        // 背景
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(ScreenWidth / texts.count * i, 0, ScreenWidth / texts.count, 0);
        bgButton.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:bgButton];
        
        // 积分
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, bgButton.width, 18)];
        numberLabel.tag = i + 100;
        numberLabel.text = [NSString stringWithFormat:@"0%@", units[i]];
        numberLabel.font = [UIFont boldSystemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:numberLabel];
        
        // 可用积分
        UILabel *integralTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, numberLabel.maxY + 10, bgButton.width, 15)];
        integralTitleLabel.text = texts[i];
        integralTitleLabel.font = [UIFont systemFontOfSize:13];
        integralTitleLabel.textColor = kMainColor;
        integralTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:integralTitleLabel];
        
        bgView.height = bgButton.height = integralTitleLabel.maxY + numberLabel.y;
        [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self goViewController:integralTitleLabel.text];
        }];
    }
    
    for (NSInteger i = 1; i < texts.count; i++) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / texts.count * i, 15, 0.5, bgView.height - 30)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [bgView addSubview:lineView];
    }

    return bgView;
}

- (void)goViewController:(NSString *)text {
    
    NSString *vcName = @"";
    
    if ([text isEqualToString:@"总积分"]) {
        
        vcName = @"IntegralDetailsViewController";
    }
    else if ([text isEqualToString:@"可用积分"]) {
        
        vcName = @"CheckAchievementViewController";
    }
    else if ([text isEqualToString:@"医生"]) {
        
        vcName = @"DoctorsListViewController";
    }
    else if ([text isEqualToString:@"代理品种"]) {
        
        vcName = @"AgentVarietyViewController";
    }
    else if ([text isEqualToString:@"处方数"]) {
        
        vcName = @"PrescriptionNumViewController";
    }
    else if ([text isEqualToString:@"订单金额"]) {
        
        
    }
    
    if (vcName.length == 0) {
        return;
    }
    
    if (self.goViewControllerBlock) {
        self.goViewControllerBlock([NSClassFromString(vcName) new]);
    }
}

- (void)setModel:(PersonalModel *)model {
    
    _model = model;
    
    if (model) {
        
        for (int i = 0; i < 2; i++) {
            
            NSArray *units = @[@"人", @"个", @"张", @"元"];
            NSArray *texts = @[model.dr_num, model.drug_num, model.recipe_num, model.order_amount];
            UIView *subview = self.userInfoView;
            
            if (i == 1) {
                
                units = @[@"", @""];
                texts = @[model.totalIntegral, model.integral];
                subview = self.integralView;
            }
            
            for (UIButton *button in subview.subviews) {
                
                if ([button isKindOfClass:[UIButton class]]) {
                    
                    for (UILabel *label in button.subviews) {
                        
                        if (label.tag >= 100) {
                            
                            NSInteger index = label.tag - 100;
                            label.text = [NSString stringWithFormat:@"%@%@", texts[index], units[index]];
                        }
                    }
                }
            }

        }
    }
}

@end
