//
//  PaySetCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PaySetCell.h"

@interface PaySetCell ()

@property (nonatomic, strong) UIButton *setPriceBtn;

@end

@implementation PaySetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubview];
    }
    
    return self;
}

- (void)setupSubview {
    
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    self.setPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setPriceBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.setPriceBtn setTitle:@"单独改价" forState:UIControlStateNormal];
    [self.setPriceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setPriceBtn.height = 25;
    self.setPriceBtn.width = [self.setPriceBtn.titleLabel getTextWidth] + 20;
    self.setPriceBtn.x = ScreenWidth - self.setPriceBtn.width - 20;
    self.setPriceBtn.centerY = self.centerY;
    self.setPriceBtn.backgroundColor = kMainColor;
    self.setPriceBtn.layer.cornerRadius = 3;
    self.setPriceBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.setPriceBtn];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 15, 0, 15)];
    self.priceLabel.text = @"图文咨询";
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.priceLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.priceLabel.width = [self.priceLabel getTextWidth];
    self.priceLabel.x = self.priceLabel.x + [self.priceLabel getTextWidth] + 15;
    self.priceLabel.width = self.setPriceBtn.x - self.priceLabel.x - 30;
    self.priceLabel.text = @"免费";
    [self.contentView addSubview:self.priceLabel];
}

- (void)setModel:(PaySetModel *)model {
    
    if ([model.is_open boolValue] == NO) {
        self.priceLabel.text = @"未开通";
    }
    
    if ([model.pay_money intValue] == -1) {
        
        if ([model.visit_type intValue] == 1) {
            self.priceLabel.text = @"免费";
        }
        
        return;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@元/次", model.pay_money];
}

@end
