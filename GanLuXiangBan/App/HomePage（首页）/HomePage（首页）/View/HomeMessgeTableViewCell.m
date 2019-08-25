//
//  HomeMessgeTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HomeMessgeTableViewCell.h"

@implementation HomeMessgeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(HomeMessgeModel *)model{
    
    _model = model;
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    if (model.logo) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:place];
    }
    else {
        self.headImage.image = place;
    }
    
    NSString *name = model.name;
    if (!name || name.length == 0) {
        name = @"    ";
    }
    self.nameLabel.text = model.name;
    
    //msgsource字段   0 患者端 1 商城
    NSString *msg = [model.msg_source isEqualToString:@"1"] ? @"[商城]" : @"[专科]";
    if (model.content) {
        msg = [msg stringByAppendingString:model.content];
    }
    self.contentLabel.text = msg;
    self.timeLabel.text = model.create_time;
    
    if ([model.unread integerValue] != 0) {
        self.nameLabel.badgeCenterOffset = CGPointMake(8, 0);
        [self.nameLabel showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
    }
    else{
        [self.nameLabel clearBadge];
    }
    
    [self setupAutoHeightWithBottomView:self.headImage bottomMargin:10];
    
}

-(void)setupUI{
    
    self.headImage = [UIImageView new];
    [self.headImage.layer setMasksToBounds:YES];
    [self.headImage.layer setCornerRadius:20];
    [self.contentView addSubview:self.headImage];
    
    self.headImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 10).widthIs(40).heightEqualToWidth();
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.headImage, 15)
    .topSpaceToView(self.contentView, 12)
    .heightIs(16);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.sd_layout.leftSpaceToView(self.headImage, 15).topSpaceToView(self.nameLabel, 5).heightIs(14);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.timeLabel.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.nameLabel).heightIs(14);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.sessionLabel = [UILabel new];
    self.sessionLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.sessionLabel];
    
    self.sessionLabel.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentLabel).heightIs(14);
    [self.sessionLabel setSingleLineAutoResizeWithMaxWidth:100];
    
}

@end
