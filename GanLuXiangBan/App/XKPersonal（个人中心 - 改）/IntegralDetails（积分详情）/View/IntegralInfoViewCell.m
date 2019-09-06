//
//  IntegralInfoViewCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "IntegralInfoViewCell.h"

@implementation IntegralInfoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.leftLabel];
        self.leftLabel.sd_layout.leftSpaceToView(self.contentView, 15).heightIs(20).centerYEqualToView(self.contentView).widthIs(100);
        
        [self.contentView addSubview:self.rightLabel];
        self.rightLabel.sd_layout.leftSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 15).heightIs(20).centerYEqualToView(self.contentView);
    }
    return self;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = kNightColor;
        _leftLabel.font = kFontRegular(14);
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.font = kFontRegular(14);
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

@end




@implementation IntegralInfoViewRemarkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = kPageBgColor;
        [self.contentView addSubview:self.lineView];
        self.lineView.sd_layout.topSpaceToView(self.contentView, 15).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
        
        self.leftLabel.sd_resetLayout.leftSpaceToView(self.contentView, 15).heightIs(20).widthIs(100).topSpaceToView(self.lineView, 15);
        self.leftLabel.text = @"温馨提示：";
        
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
        self.rightLabel.sd_resetLayout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(self.leftLabel, 10).bottomSpaceToView(self.contentView, 15);
    }
    return self;
}

@end
