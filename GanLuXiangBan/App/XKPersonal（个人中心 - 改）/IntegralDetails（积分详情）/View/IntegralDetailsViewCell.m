//
//  IntegralDetailsViewCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/19.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "IntegralDetailsViewCell.h"

@implementation IntegralDetailsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width = (ScreenWidth - 60)/4;
        
        self.dateLabel = [self setupLabels:kNightColor size:13.0 right:NO];
        [self.contentView addSubview:self.dateLabel];
        self.dateLabel.sd_layout.leftSpaceToView(self.contentView, 15).widthIs(width).heightIs(20).centerYEqualToView(self.contentView);
        
        self.numLabel = [self setupLabels:kThreeColor size:14.0 right:NO];
        [self.contentView addSubview:self.numLabel];
        self.numLabel.sd_layout.leftSpaceToView(self.dateLabel, 10).widthIs(width).heightIs(20).centerYEqualToView(self.contentView);
        
        self.nameLabel = [self setupLabels:kThreeColor size:14.0 right:NO];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.leftSpaceToView(self.numLabel, 10).widthIs(width+30).heightIs(20).centerYEqualToView(self.contentView);
        
        self.statusLabel = [self setupLabels:kMainColor size:14.0 right:YES];
        [self.contentView addSubview:self.statusLabel];
        self.statusLabel.sd_layout.leftSpaceToView(self.nameLabel, 10).rightSpaceToView(self.contentView, 15).heightIs(20).centerYEqualToView(self.contentView);
    }
    return self;
}

- (UILabel *)setupLabels:(UIColor *)color size:(CGFloat)size right:(BOOL)right {
    UILabel *label = [[UILabel alloc] init];
    label.font = kFontRegular(size);
    label.textColor = color;
    if (right) {
        label.textAlignment = NSTextAlignmentRight;
    }
    return label;
}

@end
