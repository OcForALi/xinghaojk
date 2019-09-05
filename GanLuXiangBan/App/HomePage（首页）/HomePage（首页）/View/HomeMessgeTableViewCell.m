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

- (void)setModel:(HomeNewModel *)model{
 
    _model = model;
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    if (model.head) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:place];
    }
    else {
        self.headImage.image = place;
    }
    
    self.nameLabel.text = model.name;
    
    //    self.contentLabel.text = msg;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",model.amount];
    
    [self setupAutoHeightWithBottomView:self.headImage bottomMargin:10];
    
}

-(void)setupUI{
    
    self.serialNumberLabel = [UILabel new];
    self.serialNumberLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.serialNumberLabel];
    
    self.serialNumberLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.serialNumberLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.headImage = [UIImageView new];
    [self.headImage.layer setMasksToBounds:YES];
    [self.headImage.layer setCornerRadius:20];
    [self.contentView addSubview:self.headImage];
    
    self.headImage.sd_layout
    .leftSpaceToView(self.serialNumberLabel, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.headImage, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(16);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.sd_layout.leftSpaceToView(self.headImage, 15).topSpaceToView(self.nameLabel, 5).heightIs(14);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = kMainColor;
    [self.contentView addSubview:self.timeLabel];
    
    self.timeLabel.sd_layout.rightSpaceToView(self.contentView, 30).centerYEqualToView(self.nameLabel).heightIs(14);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.sessionLabel = [UILabel new];
    self.sessionLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.sessionLabel];
    
    self.sessionLabel.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentLabel).heightIs(14);
    [self.sessionLabel setSingleLineAutoResizeWithMaxWidth:100];
    
}

@end
