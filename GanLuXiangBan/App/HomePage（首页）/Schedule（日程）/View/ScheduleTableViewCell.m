//
//  ScheduleTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ScheduleTableViewCell.h"

@implementation ScheduleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(ScheduleModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.patient_name;
    
    self.timeLabel.text = model.createtime;
    
    if ([model.status integerValue] == 0) {
        
        self.statusLabel.text = @"待审核";
        self.statusLabel.textColor = [UIColor redColor];
        
    }else if ([model.status integerValue] == 1) {
        
        self.statusLabel.text = @"待付款";
        self.statusLabel.textColor = [UIColor greenColor];
        
    }else if ([model.status integerValue] == 2){
        
        self.statusLabel.text = @"待咨询";
        self.statusLabel.textColor = [UIColor redColor];
        
    }else if ([model.status integerValue] == 3){
        
        self.statusLabel.text = @"已关闭";
        self.statusLabel.textColor = [UIColor redColor];
        
    }else if ([model.status integerValue] == 4){
        
        self.statusLabel.text = @"已结束";
        self.statusLabel.textColor = [UIColor blackColor];
        
    }else if ([model.status integerValue] == 5){
        
        self.statusLabel.text = @"已评价";
        self.statusLabel.textColor = [UIColor blackColor];
        
    }
    
    if (model.unread > 0) {
        
        self.nameLabel.badgeCenterOffset = CGPointMake(8, 0);
        [self.nameLabel showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
        
    }else{
        
        [self.nameLabel clearBadge];
        
    }
    
    [self setupAutoHeightWithBottomView:self.timeLabel bottomMargin:13];
    
}

-(void)setupUI{
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 12)
    .heightIs(16);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.nameLabel, 15)
    .heightIs(14);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.statusLabel = [UILabel new];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.statusLabel];
    
    self.statusLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.statusLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

@end
