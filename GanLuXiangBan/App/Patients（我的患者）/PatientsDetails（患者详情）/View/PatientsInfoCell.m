//
//  PatientsInfoCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsInfoCell.h"

@interface PatientsInfoCell ()

/// 头像
@property (nonatomic, strong) UIImageView *headerImgView;
/// 昵称
@property (nonatomic, strong) UILabel *nickNameLabel;
/// 信息
@property (nonatomic, strong) UILabel *infoLabel;
/// 分组
@property (nonatomic, strong) UILabel *phoneLabel;

@end


@implementation PatientsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 头像
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellSpacing, 15, 65, 65)];
    self.headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImgView.clipsToBounds = YES;
    self.headerImgView.layer.cornerRadius = self.headerImgView.height / 2;
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.borderWidth = 0.5;
    self.headerImgView.layer.borderColor = [[UIColor colorWithHexString:@"0xeeeeee"] CGColor];
    [self.contentView addSubview:self.headerImgView];
    
    // 昵称
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgView.frame) + 10, 15, ScreenWidth / 2, 15)];
    self.nickNameLabel.text = @"测试";
    self.nickNameLabel.font = [UIFont systemFontOfSize:14];
    self.nickNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.nickNameLabel];
    
    // 信息
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgView.frame) + 10, CGRectGetMaxY(self.nickNameLabel.frame) + 10, ScreenWidth, 15)];
    self.infoLabel.text = @"测试";
    self.infoLabel.font = [UIFont systemFontOfSize:13];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    [self.contentView addSubview:self.infoLabel];
    
    // 手机号
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgView.frame) + 10, CGRectGetMaxY(self.infoLabel.frame) + 10, ScreenWidth, 15)];
    self.phoneLabel.text = @"13149913545";
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.phoneLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    [self.contentView addSubview:self.phoneLabel];
}

- (void)setModel:(PatientsDetailsModel *)model {
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    if (model.head) {
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:place];
    }
    else {
        self.headerImgView.image = place;
    }
    self.nickNameLabel.text = model.name;
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@", model.gender, model.age];
    self.phoneLabel.text = model.mobile_no;
}

@end
