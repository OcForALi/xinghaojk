//
//  PrescriptionCell.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionCell.h"

@implementation PrescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSubvewis];
    }
    
    return self;
}

- (void)setSubvewis {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 0)];
    [self.contentView addSubview:bgView];
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 0, 15)];
    timeLabel.width = bgView.width / 2 - timeLabel.x;
    timeLabel.text = @"2019-09-09 10:10:10";
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textColor = kMainTextColor;
    [bgView addSubview:timeLabel];
    
    // 价格
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
    priceLabel.x = timeLabel.maxX;
    priceLabel.text = @"¥ 3000";
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.textColor = kMainTextColor;
    priceLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:priceLabel];
    
    // RP
    UILabel *rpLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
    rpLabel.y = timeLabel.maxY + 10;
    rpLabel.height = 18;
    rpLabel.width = 30;
    rpLabel.text = @"RP";
    rpLabel.font = [UIFont boldSystemFontOfSize:16];
    rpLabel.textColor = kMainTextColor;
    [bgView addSubview:rpLabel];
    
    // 用户
    UILabel *userLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
    userLabel.x = rpLabel.maxX + 10;
    userLabel.y = rpLabel.centerY;
    userLabel.width -= userLabel.x;
    userLabel.text = @"临床诊断：小三阳";
    userLabel.font = [UIFont systemFontOfSize:14];
    userLabel.textColor = [UIColor lightGrayColor];
    userLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:userLabel];
    
    // 数量
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:priceLabel.frame];
    numberLabel.y = userLabel.y;
    numberLabel.text = @"共2个品种";
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.textColor = kMainTextColor;
    numberLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:numberLabel];
    
    
    float maxy = numberLabel.maxY + 15;
    for (int i = 0; i < 2; i++) {
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
        nameLabel.y = maxy;
        nameLabel.text = @"药品名（通用名）";
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = kMainTextColor;
        [bgView addSubview:nameLabel];
        
        UILabel *drugNumberLabel = [[UILabel alloc] initWithFrame:numberLabel.frame];
        drugNumberLabel.y = nameLabel.y;
        drugNumberLabel.text = @"X 1";
        drugNumberLabel.font = [UIFont systemFontOfSize:14];
        drugNumberLabel.textColor = kMainTextColor;
        drugNumberLabel.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:drugNumberLabel];
        
        maxy = nameLabel.maxY + nameLabel.height;
    }
    
    self.cellHeight = bgView.height = maxy + 15;
}

@end
