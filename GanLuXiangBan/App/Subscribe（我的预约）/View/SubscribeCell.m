//
//  SubscribeCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeCell.h"

@interface SubscribeCell ()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *locationLabel;

@end

@implementation SubscribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubview];
    }
    
    return self;
}

- (void)setupSubview {
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellSpacing, 15, 45, 45)];
    self.headImgView.layer.cornerRadius = self.headImgView.height / 2;
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headImgView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 15)];
    self.titleLabel.x = CGRectGetMaxX(self.headImgView.frame) + 10;
    self.titleLabel.text = @"昵称";
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    self.infoLabel.centerY = self.titleLabel.centerY;
    self.infoLabel.text = @"信息";
    self.infoLabel.font = [UIFont systemFontOfSize:11];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.infoLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    self.timeLabel.x = CGRectGetMaxX(self.headImgView.frame) + 10;
    self.timeLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.timeLabel.text = @"预约时间";
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.timeLabel];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    self.locationLabel.x = CGRectGetMaxX(self.headImgView.frame) + 10;
    self.locationLabel.y = CGRectGetMaxY(self.timeLabel.frame) + 10;
    self.locationLabel.hidden = YES;
    self.locationLabel.text = @"地址";
    self.locationLabel.font = [UIFont systemFontOfSize:11];
    self.locationLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.locationLabel];
    
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 15)];
    self.stateLabel.text = @"已结束";
    self.stateLabel.font = [UIFont systemFontOfSize:11];
    self.stateLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.accessoryView = self.stateLabel;
}

- (void)setModel:(SubscribeModel *)model {
    
    if (model.location.length > 0) {
        
        self.locationLabel.hidden = NO;
        self.locationLabel.text = [NSString stringWithFormat:@"面诊地点: %@", model.location];
        self.locationLabel.width = [self.locationLabel getTextWidth];
        self.cellHeight = CGRectGetMaxY(self.locationLabel.frame) + 15;
    }
    else {
        
        self.locationLabel.hidden = YES;
        self.cellHeight = CGRectGetMaxY(self.timeLabel.frame) + 15;
    }
    
    // 获取图片
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head]];
    self.headImgView.centerY = self.cellHeight / 2;
    // 昵称
    self.titleLabel.text = model.member_name;
    self.titleLabel.width = [self.titleLabel getTextWidth];
    // 个人信息
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@", model.gender, model.age];
    self.infoLabel.x = CGRectGetMaxX(self.titleLabel.frame) + 15;
    self.infoLabel.width = [self.infoLabel getTextWidth];
    // 预约时间
    self.timeLabel.text = [NSString stringWithFormat:@"预约时间: %@", model.pre_date];
    self.timeLabel.width = [self.timeLabel getTextWidth];
    // 状态
    NSString *stateString = @"待审核";
    switch ([model.status intValue]) {
        case 0:
            stateString = @"待审核";
            break;
            
        case 1:
            stateString = @"待付款";
            break;
        
        case 2:
            stateString = @"待咨询";
            break;
            
        case 3:
            stateString = @"已关闭";
            break;
            
        case 4:
            stateString = @"已结束";
            break;
            
        default:
            stateString = @"已评价";
            break;
    }
    self.stateLabel.text = stateString;
    self.stateLabel.width = [self.stateLabel getTextWidth];
}

@end
