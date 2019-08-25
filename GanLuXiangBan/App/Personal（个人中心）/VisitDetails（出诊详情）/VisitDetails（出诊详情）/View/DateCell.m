//
//  DateCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DateCell.h"

@interface DateCell ()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation DateCell
@synthesize dateLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kPageBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    CGFloat width = (ScreenWidth - 4) / 3;
    for (int i = 0; i < 3; i++) {
        
        // 背景View
        UIButton *bgButton = [UIButton new];
        bgButton.tag = i + 10;
        bgButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgButton];
        
        [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@((width + 2) * i));
            make.width.equalTo(@(width));
            make.top.equalTo(@2);
            make.bottom.equalTo(self.contentView);
        }];
        
        [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            if (self.selectType) {
                
                NSString *valueString = bgButton.tag == 11 ? self.model.amType : self.model.pmType;
                if ([valueString intValue] == 0) {
                    self.selectType(bgButton.tag - 11);
                }
            }
        }];
        
        if (i == 0) {
            
            dateLabel = [UILabel new];
            dateLabel.text = @"星期一";
            dateLabel.font = [UIFont boldSystemFontOfSize:15];
            dateLabel.textColor = kMainColor;
            dateLabel.textAlignment = NSTextAlignmentCenter;
            [bgButton addSubview:dateLabel];
            [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(bgButton);
            }];
        }
        else {
            
            // 状态图片
            UIImageView *statusImgView = [UIImageView new];
            statusImgView.image = [UIImage imageNamed:@"VisitDetailsStatusImg"];
            [bgButton addSubview:statusImgView];
            [statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(bgButton);
                make.width.height.equalTo(@20);
            }];
            
            // 类型按钮
            for (int a = 0; a < 2; a++) {
                
                UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                typeBtn.tag = i * 100 + a;
                typeBtn.layer.cornerRadius = 5;
                typeBtn.layer.masksToBounds = YES;
                typeBtn.layer.borderWidth = 0.5;
                typeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [typeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [bgButton addSubview:typeBtn];
                [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.equalTo(@70);
                    make.height.equalTo(@30);
                    make.centerX.equalTo(bgButton);
                    
                    if (a == 0) {
                        make.top.equalTo(@10);
                    }
                    else {
                        make.bottom.equalTo(@-10);
                    }
                }];
                
                if (a == 0) {
                    
                    typeBtn.layer.borderColor = [kMainColor CGColor];
                    [typeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                }
                else {
                    
                    typeBtn.layer.borderColor = [[UIColor colorWithHexString:@"0xc6c6c6"] CGColor];
                    [typeBtn setTitle:@"本院区" forState:UIControlStateNormal];
                    [typeBtn setTitleColor:[UIColor colorWithHexString:@"0xc6c6c6"] forState:UIControlStateNormal];
                }
            }
        }
    }
}

#pragma mark - 点击事件
- (void)buttonClick:(UIButton *)button {
    
    // 选择出诊类型
    if (self.selectType && button.tag % 100 == 0) {
        self.selectType(button.tag / 100 - 1);
    }
    
    if (self.selectHospital && button.tag % 100 == 1) {
        self.selectHospital(button.tag / 100 - 1);
    }
}

#pragma mark - set
- (void)setIndex:(int)index {
    
    _index = index;
    
    NSArray *titles = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    dateLabel.text = [NSString stringWithFormat:@"星期%@", titles[index]];
}

- (void)setModel:(VisitDetailsModel *)model {

    _model = model;
    
    if (!model.isVisits) {
        
        [self isHidden:YES time:AM];
        [self isHidden:YES time:PM];
    }
    else {
        
        [self setBtnValueWithTime:AM model:model];
        [self setBtnValueWithTime:PM model:model];
    }
}

- (void)setBtnValueWithTime:(VisitTime)time model:(VisitDetailsModel *)model {
    
    UIButton *bgButton = [self viewWithTag:11 + time];
    for (UIView *subview in bgButton.subviews) {
        
        NSString *valueString = time == 0 ? model.amType : model.pmType;
        if ([subview isKindOfClass:[UIButton class]]) {
        
            UIButton *button = (UIButton *)subview;
            if ([valueString intValue] == 0) {
                button.hidden = YES;
                continue;
            }
            else {
                button.hidden = NO;
            }
            
            if (button.tag == (time + 1) * 100) {
                
                if ([valueString intValue] == 1) {
                    valueString = @"普通";
                }
                else if ([valueString intValue] == 2) {
                    valueString = @"专家";
                }
                else if ([valueString intValue] == 3) {
                    valueString = @"特诊";
                }
                
                [button setTitle:valueString forState:UIControlStateNormal];
                
                UIColor *color = kMainColor;
                if ([valueString isEqualToString:@"普通"]) {
                    color = [UIColor colorWithHexString:@"0x333333"];
                }
                else if ([valueString isEqualToString:@"特诊"]) {
                    color = [UIColor redColor];
                }
                
                button.layer.borderColor = [color CGColor];
                [button setTitleColor:color forState:UIControlStateNormal];
            }
            else if (button.tag == ((time + 1) * 100 + 1)) {
                
                NSString *valueString = time == 0 ? model.amHospital : model.pmHospital;
                if (valueString.length > 0) {
                    [button setTitle:valueString forState:UIControlStateNormal];
                }
            }
        }
        
        if ([subview isKindOfClass:[UIImageView class]]) {
            
            if ([valueString intValue] == 0) {
                subview.hidden = NO;
            }
            else {
                subview.hidden = YES;
            }
        }
    }
}

- (void)isHidden:(BOOL)hidden time:(VisitTime)time {
    
    UIButton *bgButton = [self viewWithTag:11 + time];
    for (UIView *subview in bgButton.subviews) {
        
        if ([subview isKindOfClass:[UIButton class]] && subview.tag >= 100) {
            subview.hidden = hidden;
        }
        
        if ([subview isKindOfClass:[UIImageView class]]) {
            subview.hidden = !hidden;
        }
    }
}

@end
