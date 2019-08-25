//
//  AddCardCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddCardCell.h"

@implementation AddCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(@(kCellSpacing));
        make.width.equalTo(@60);
    }];
    
    self.textFieldText = [UITextField new];
    self.textFieldText.font = [UIFont systemFontOfSize:14];
    self.textFieldText.textColor = [UIColor blackColor];
    self.textFieldText.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:self.textFieldText];
    [self.textFieldText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).equalTo(@5);
        make.right.equalTo(@(-(kCellSpacing)));
    }];
}

@end
