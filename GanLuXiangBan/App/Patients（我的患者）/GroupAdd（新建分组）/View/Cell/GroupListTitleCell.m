//
//  GroupListTitleCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupListTitleCell.h"

@implementation GroupListTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 12.5, 5, 20)];
    colorView.backgroundColor = kMainColor;
    [self.contentView addSubview:colorView];
    
    self.textLabel.text = @"患者列表";
    self.textLabel.font = [UIFont boldSystemFontOfSize:15];
    self.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
}

@end
