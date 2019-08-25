//
//  FamousTableViewCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousTableViewCell.h"

@implementation FamousTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.layer.masksToBounds = YES;
        self.iconView.layer.cornerRadius = 40;
        [self.contentView addSubview:self.iconView];
        self.iconView.sd_layout.leftSpaceToView(self.contentView, 14).widthIs(80).heightEqualToWidth().centerYEqualToView(self.contentView);
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = kFontRegular(15);
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.topSpaceToView(self.contentView, 14).leftSpaceToView(self.iconView, 10).rightSpaceToView(self.contentView, 14).heightIs(18);
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.font = kFontRegular(12);
        [self.contentView addSubview:self.infoLabel];
        self.infoLabel.sd_layout.topSpaceToView(self.nameLabel, 8).leftSpaceToView(self.iconView, 10).rightSpaceToView(self.contentView, 14).heightIs(15);
        
        self.hospitalLabel = [[UILabel alloc] init];
        self.hospitalLabel.font = kFontRegular(12);
        [self.contentView addSubview:self.hospitalLabel];
        self.hospitalLabel.sd_layout.topSpaceToView(self.infoLabel, 8).leftSpaceToView(self.iconView, 10).rightSpaceToView(self.contentView, 14).heightIs(15);
    }
    return self;
}

@end



@implementation FamouseDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = kFontMedium(16);
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 15).widthIs(180).heightIs(20).centerYEqualToView(self.contentView);
        
        self.arrowView = [[UIImageView alloc] init];
        self.arrowView.contentMode = UIViewContentModeScaleAspectFit;
        self.arrowView.image = [UIImage imageNamed:@"arrow_down"];
        [self.contentView addSubview:self.arrowView];
        self.arrowView.sd_layout.rightSpaceToView(self.contentView, 14).widthIs(24).heightIs(24).centerYEqualToView(self.contentView);
    }
    return self;
}

- (void)setExpand:(BOOL)expand {
    _expand = expand;
    NSString *name = expand ? @"Home_DownTriangle" : @"arrow_down";
    self.arrowView.image = [UIImage imageNamed:name];
}

@end
