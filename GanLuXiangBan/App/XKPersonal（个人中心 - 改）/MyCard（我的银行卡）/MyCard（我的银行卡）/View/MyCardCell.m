//
//  MyCardCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyCardCell.h"

@interface MyCardCell ()

@property (nonatomic, strong) UIView *bgView;
/// 图标
@property (nonatomic, strong) UIImageView *iconImgView;
/// 银行昵称
@property (nonatomic, strong) UILabel *cardNickNameLabel;
/// 号码
@property (nonatomic, strong) UILabel *numberLabel;
/// 卡类型
@property (nonatomic, strong) UILabel *cardTypeLabel;
/// 选中图标
@property (nonatomic, strong) UIImageView *selectImgView;
/// 设为默认卡
@property (nonatomic, strong) UIButton *defaultBtn;

@end

@implementation MyCardCell
@synthesize bgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubview];
        self.backgroundColor = kPageBgColor;
    }
    
    return self;
}

- (void)setupSubview {
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - (15 * 2), 70)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [[UIColor colorWithHexString:@"0xc6c6c6"] CGColor];
    [self.contentView addSubview:bgView];
    
    // CardNoSelectImg
    self.selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, 25, 25)];
    self.selectImgView.centerY = bgView.height / 2;
    self.selectImgView.image = [UIImage imageNamed:@"CardNoSelectImg"];
    [self.contentView addSubview:self.selectImgView];
    
    // 图标
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, bgView.height - 20, bgView.height - 20)];
    self.iconImgView.image = [UIImage imageNamed:@"CardLogo"];
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImgView.layer.cornerRadius = (bgView.height - 20) / 2;
    self.iconImgView.layer.masksToBounds = YES;
    [bgView addSubview:self.iconImgView];
    
    // 银行昵称
    self.cardNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame) + 10, 15, 0, 16)];
    self.cardNickNameLabel.text = @"招商银行";
    self.cardNickNameLabel.font = [UIFont systemFontOfSize:15];
    self.cardNickNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.cardNickNameLabel.width = [self.cardNickNameLabel getTextWidth];
    [bgView addSubview:self.cardNickNameLabel];
    
    // 卡号
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cardNickNameLabel.x, CGRectGetMaxY(self.cardNickNameLabel.frame) + 10, 0, 15)];
    self.numberLabel.text = @"**** **** **** 3411";
    self.numberLabel.font = [UIFont systemFontOfSize:13];
    self.numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.numberLabel.width = [self.numberLabel getTextWidth];
    [bgView addSubview:self.numberLabel];
    
    // 卡类型
    self.cardTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 16)];
    self.cardTypeLabel.text = @"储蓄卡";
    self.cardTypeLabel.font = [UIFont systemFontOfSize:15];
    self.cardTypeLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.cardTypeLabel.width = [self.cardTypeLabel getTextWidth];
    self.cardTypeLabel.x = bgView.width - 10 - self.cardTypeLabel.width;
    [bgView addSubview:self.cardTypeLabel];
    
    // 设为默认卡
    self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.defaultBtn.frame = CGRectMake(0, CGRectGetMaxY(self.cardTypeLabel.frame) + 10, 0, 15);
    self.defaultBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.defaultBtn setTitle:@"设为默认卡" forState:UIControlStateNormal];
    [self.defaultBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.defaultBtn.width = [self.defaultBtn.titleLabel getTextWidth];
    self.defaultBtn.x = bgView.width - 10 - self.defaultBtn.width;
    [bgView addSubview:self.defaultBtn];
    
    [[self.defaultBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        if (self.defaultCardBlock) {
            self.defaultCardBlock();
        }
    }];
}

- (void)setIsSelect:(BOOL)isSelect {

    _isSelect = isSelect;
    self.selectImgView.image = [UIImage imageNamed:isSelect ? @"CardSelectImg" : @"CardNoSelectImg"];
}

- (void)setIsEdit:(BOOL)isEdit {
    
    _isEdit = isEdit;
    self.selectImgView.x = ((-self.selectImgView.width) * !isEdit) + 15 * isEdit;
    self.numberLabel.superview.x = CGRectGetMaxX(self.selectImgView.frame) + 15;
}

- (void)setModel:(MyCardModel *)model {
    
    _model = model;
    self.cardTypeLabel.text = model.card_type;
    self.numberLabel.text = model.card_no;
    self.cardNickNameLabel.text = model.bank;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.card_ico]];
    
    self.cardNickNameLabel.width = [self.cardNickNameLabel getTextWidth];
    self.numberLabel.width = [self.numberLabel getTextWidth];
    
    // 是否默认卡
    [self.defaultBtn setTitle:[model.is_default boolValue] ? @"默认卡" : @"设为默认卡" forState:UIControlStateNormal];
    [self.defaultBtn setTitleColor:[model.is_default boolValue] ? [UIColor redColor] : kMainColor forState:UIControlStateNormal];
    self.defaultBtn.width = [self.defaultBtn.titleLabel getTextWidth];
    self.defaultBtn.x = bgView.width - 10 - self.defaultBtn.width;
}

@end
