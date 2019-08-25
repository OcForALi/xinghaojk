//
//  TipCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TipCell.h"

@implementation TipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(20, 20, 100, 20);
    titleLabel.text = @"温馨提示";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    
    self.tipLabel = [UILabel new];
    self.tipLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 10, ScreenWidth - 40, 0);
    self.tipLabel.font = [UIFont systemFontOfSize:13];
    self.tipLabel.textColor = [UIColor blackColor];
    self.tipLabel.numberOfLines = 0;
    [self.contentView addSubview:self.tipLabel];
}

- (void)setTipContent:(NSString *)tipContent {
    NSMutableParagraphStyle *pp = [[NSMutableParagraphStyle alloc] init];
    [pp setLineSpacing:5.0];
    self.tipLabel.attributedText = [[NSAttributedString alloc] initWithString:tipContent attributes:@{NSParagraphStyleAttributeName:pp, NSFontAttributeName: kFontRegular(13)}];
    self.tipLabel.height = [self.tipLabel.attributedText boundingRectWithSize:CGSizeMake(self.tipLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 10;
    self.tipCellHeight = self.tipLabel.height + 70;
}

@end
