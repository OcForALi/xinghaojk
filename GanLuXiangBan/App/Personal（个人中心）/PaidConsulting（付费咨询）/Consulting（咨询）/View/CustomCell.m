//
//  CustomCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize textField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.clipsToBounds = YES;
        [self setupSubviews];
        [self initInputBox];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 0, 100, 45)];
    titleLabel.text = @"自定义价格";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    
    // 选中图标
    self.selImgView = [UIImageView new];
    self.selImgView.image = [UIImage imageNamed:@"pirce_select"];
    self.selImgView.hidden = YES;
    [self.contentView addSubview:self.selImgView];
    
    [self.selImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(@(-(kCellSpacing)));
        make.width.equalTo(@18);
        make.height.equalTo(@14);
    }];
}

// 初始化输入框
- (void)initInputBox {
    
    // 单位
    UILabel *unitLabel = [UILabel new];
    unitLabel.text = @"元 / 次";
    unitLabel.font = [UIFont systemFontOfSize:14];
    unitLabel.textColor = [UIColor blackColor];
    unitLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:unitLabel];
    
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-(kCellSpacing)));
        make.top.equalTo(@45);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    
    // 输入框
    textField = [UITextField new];
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"请输入大于0且不含小数的价格";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kCellSpacing));
        make.right.equalTo(unitLabel.mas_left).equalTo(@-15);
        make.centerY.equalTo(unitLabel);
        make.height.equalTo(@30);
    }];
    
    // 线
    UIView *line = [UIView new];
    line.backgroundColor = RGBA(0, 0, 0, 0.2);
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kCellSpacing));
        make.right.equalTo(@(-(kCellSpacing)));
        make.top.equalTo(self.textField.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

@end
