//
//  DocCircleTableCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleTableCell.h"

@implementation DocCircleTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView.frame = CGRectMake(15, 14, 12, 12);
        [self addSubview:self.iconView];
        
        self.label.frame = CGRectMake(35, 8, ScreenWidth-50, 24);
        [self addSubview:self.label];
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

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
        _label.font = kFontRegular(14);
    }
    return _label;
}

@end




@implementation DocCircleNextTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView.frame = CGRectMake(35, 14, 12, 12);
        self.label.frame = CGRectMake(55, 8, ScreenWidth-70, 24);
    }
    return self;
}

@end



@implementation DocCircleLastTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView.frame = CGRectMake(55, 14, 12, 12);
        self.label.frame = CGRectMake(75, 8, ScreenWidth-90, 24);
    }
    return self;
}

@end
