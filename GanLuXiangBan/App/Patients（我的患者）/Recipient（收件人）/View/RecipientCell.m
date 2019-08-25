//
//  RecipientCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecipientCell.h"

@implementation RecipientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 15, 15)];
    self.selectImgView.centerY = self.centerY;
    self.selectImgView.image = [UIImage imageNamed:@"NoSelectPatients"];
    [self.contentView addSubview:self.selectImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectImgView.frame) + 10, 0, ScreenWidth / 2, 45)];
    self.titleLabel.text = @"普通病";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(self.selectImgView.x, 45 - 1, ScreenWidth - self.selectImgView.x, 1)];
    lineView.backgroundColor = kPageBgColor;
    [self.contentView addSubview:lineView];
}

- (void)setIsSelect:(BOOL)isSelect {
    
    _isSelect = isSelect;
    NSString *imgString = isSelect ? @"SelectRecipient" : @"NoSelectPatients";
    self.selectImgView.image = [UIImage imageNamed:imgString];
}

@end
