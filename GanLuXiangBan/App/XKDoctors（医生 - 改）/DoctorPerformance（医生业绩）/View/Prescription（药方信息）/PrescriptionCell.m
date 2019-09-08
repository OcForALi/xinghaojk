//
//  PrescriptionCell.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionCell.h"

@interface PrescriptionCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation PrescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSubvewis];
    }
    
    return self;
}

- (void)setSubvewis {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.contentView addSubview:bgView];
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 15)];
    timeLabel.width = bgView.width / 2 - timeLabel.x;
    timeLabel.text = @"2019-09-09 10:10:10";
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textColor = kMainTextColor;
    self.timeLabel = timeLabel;
    [bgView addSubview:timeLabel];
    
    // 价格
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
    priceLabel.x = timeLabel.maxX;
    priceLabel.text = @"¥ 3000";
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.textColor = kMainTextColor;
    priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel = priceLabel;
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
    
    // 数量
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:priceLabel.frame];
    numberLabel.text = @"共2个品种";
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.textColor = kMainTextColor;
    numberLabel.textAlignment = NSTextAlignmentRight;
    numberLabel.width = [numberLabel getTextWidth];
    numberLabel.y = rpLabel.centerY;
    numberLabel.x = bgView.width - numberLabel.width - 15;
    self.numberLabel = numberLabel;
    [bgView addSubview:numberLabel];
    
    // 用户
    UILabel *userLabel = [[UILabel alloc] initWithFrame:timeLabel.frame];
    userLabel.font = [UIFont systemFontOfSize:14];
    userLabel.textColor = [UIColor lightGrayColor];
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.adjustsFontSizeToFitWidth = YES;
    userLabel.x = rpLabel.maxX;
    userLabel.y = rpLabel.centerY;
    userLabel.width = bgView.width - userLabel.x - numberLabel.width - 30;
    self.userLabel = userLabel;
    [bgView addSubview:userLabel];
    
    self.cellHeight = bgView.height = numberLabel.maxY;
}

- (void)setModel:(PerformanceRecipesModel *)model {
    
    self.timeLabel.text = model.recipe_time;
    self.priceLabel.text = [@"¥ " stringByAppendingString:model.amount];
    self.userLabel.text = [@"临床诊断：" stringByAppendingString:model.check_result];
    self.numberLabel.text = [NSString stringWithFormat:@"共%zd个品种", model.drugModels.count];
}

@end
