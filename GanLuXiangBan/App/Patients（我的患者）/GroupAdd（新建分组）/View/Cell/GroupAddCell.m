//
//  GroupAddCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupAddCell.h"

@implementation GroupAddCell
@synthesize textField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 0, 0, 45)];
    titleLabel.text = @"分组名称:";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    titleLabel.width = [titleLabel getTextWidth];
    [self.contentView addSubview:titleLabel];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10, 0, 0, 45)];
    textField.width = ScreenWidth - titleLabel.x - 15;
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"清输入名称";
    textField.textColor = titleLabel.textColor;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:textField];
}

@end
