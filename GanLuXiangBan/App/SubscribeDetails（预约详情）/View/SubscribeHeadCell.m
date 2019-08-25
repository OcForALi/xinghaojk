//
//  SubscribeHeadCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeHeadCell.h"

@interface SubscribeHeadCell ()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation SubscribeHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setuoSubviews];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

- (void)setuoSubviews {
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellSpacing, 0, 55, 55)];
    self.headImgView.centerY = 35;
    self.headImgView.layer.cornerRadius = self.headImgView.height / 2;
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headImgView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 15)];
    self.titleLabel.x = CGRectGetMaxX(self.headImgView.frame) + 15;
    self.titleLabel.text = @"昵称";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    self.infoLabel.x = CGRectGetMaxX(self.headImgView.frame) + 15;
    self.infoLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.infoLabel.text = @"信息";
    self.infoLabel.font = [UIFont systemFontOfSize:12];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    [self.contentView addSubview:self.infoLabel];
}

- (void)setModel:(SubscribeDetailsModel *)model {
    
    // 获取图片
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head]];
    // 昵称
    self.titleLabel.text = model.patient_name;
    self.titleLabel.width = [self.titleLabel getTextWidth] + 10;
    // 个人信息
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@", model.gender, model.age];
    self.infoLabel.width = [self.infoLabel getTextWidth] + 10;
}

@end
