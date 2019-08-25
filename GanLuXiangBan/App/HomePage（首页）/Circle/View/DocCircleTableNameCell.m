//
//  DocCircleTableNameCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleTableNameCell.h"

@implementation DocCircleTableNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconView];
        self.iconView.sd_layout.leftSpaceToView(self.contentView, 15).widthIs(12).heightEqualToWidth().centerYEqualToView(self.contentView);
        
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.leftSpaceToView(self.iconView, 10).heightIs(24).centerYEqualToView(self.contentView);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        [self.contentView addSubview:self.dotView];
        self.dotView.sd_layout.leftSpaceToView(self.nameLabel, 0).widthIs(6).heightEqualToWidth().topSpaceToView(self.contentView, 14);
    }
    return self;
}

- (void)setExpand:(BOOL)expand {
    _expand = expand;
    NSString *name = expand ? @"Home_DownTriangle" : @"arrow_down";
    self.iconView.image = [UIImage imageNamed:name];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"arrow_down"];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFontRegular(14);
    }
    return _nameLabel;
}

- (BaseCircleView *)dotView {
    if (!_dotView) {
        _dotView = [[BaseCircleView alloc] init];
    }
    return _dotView;
}

@end



@implementation DocCircleTableNextNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView.sd_resetLayout.leftSpaceToView(self.contentView, 37).widthIs(12).heightEqualToWidth().centerYEqualToView(self.contentView);
    }
    return self;
}

@end



@implementation DocCircleTableLastNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView.sd_resetLayout.leftSpaceToView(self.contentView, 59).widthIs(12).heightEqualToWidth().centerYEqualToView(self.contentView);
    }
    return self;
}

@end
