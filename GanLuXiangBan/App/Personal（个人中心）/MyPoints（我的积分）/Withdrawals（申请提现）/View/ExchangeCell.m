//
//  ExchangeCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ExchangeCell.h"
#import "CustomTextField.h"

@interface ExchangeCell ()

// 积分
@property (nonatomic, strong) UILabel *numberLabel;
// 数字
@property (nonatomic, strong) CustomTextField *numberTextFiled;
// 兑换按钮
@property (nonatomic, strong) UIButton *echangeBtn;

@end

@implementation ExchangeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 积分标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, kCellSpacing, 0, 15)];
    titleLabel.text = @"目前可用积分";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.width = [titleLabel getTextWidth];
    [self.contentView addSubview:titleLabel];
    
    // 当前积分
    CGFloat x = CGRectGetMaxX(titleLabel.frame) + 10;
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, kCellSpacing, ScreenWidth - x - 30, 15)];
    self.numberLabel.text = @"0";
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    self.numberLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.numberLabel];
    
    // 兑换按钮
    self.echangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.echangeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.echangeBtn setTitle:@"确定兑换" forState:UIControlStateNormal];
    [self.echangeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.contentView addSubview:self.echangeBtn];
    [self.echangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.numberLabel.mas_bottom).equalTo(@(15));
        make.width.equalTo(@(ScreenWidth / 3.5));
        make.height.equalTo(@40);
    }];
    
    [[self.echangeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        if ([self.numberTextFiled.text intValue] >= 10 && self.echangeBlock) {
            
            self.echangeBlock(self.numberTextFiled.text);
        }
        else {
            [self makeToast:@"最低只可兑换10积分"];
        }
    }];
    
    // 数字输入框
    self.numberTextFiled = [[CustomTextField alloc] initWithFrame:CGRectZero leftImg:@"" isCaptcha:NO];
    self.numberTextFiled.placeholder = @"请输入兑换积分数";
    self.numberTextFiled.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    self.numberTextFiled.textField.textColor = [UIColor colorWithHexString:@"0x303030"];
    self.numberTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextFiled.layer.cornerRadius = 2;
    [self.contentView addSubview:self.numberTextFiled];
    [self.numberTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.echangeBtn.mas_left);
        make.centerY.equalTo(self.echangeBtn);
        make.left.equalTo(@(kCellSpacing));
        make.height.equalTo(@40);
    }];
    
    @weakify(self);
    [[self.numberTextFiled.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
     
        @strongify(self);
        if (x && x.length > 0) {
            NSInteger now = [x integerValue];
            NSInteger have = [self.pointString integerValue];
            if (have < 10) {
                [self.contentView makeToast:@"不足10积分，无法兑换"];
            }
            else if (now > have) {
                x = self.pointString;
                self.numberTextFiled.textField.text = x;
                [self.contentView makeToast:[NSString stringWithFormat:@"最多可兑换%@积分", x]];
            }
        }
    }];
}

- (void)setPointString:(NSString *)pointString {
    
    _pointString = pointString;
//    if ([pointString intValue] < 5000) {
//        self.numberTextFiled.placeholder = [NSString stringWithFormat:@"最多可兑换%@积分", pointString];
//    }
    
    self.numberLabel.text = pointString;
}

@end
