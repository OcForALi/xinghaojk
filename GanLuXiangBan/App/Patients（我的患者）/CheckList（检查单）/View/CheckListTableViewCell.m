//
//  CheckListTableViewCell.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/20.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CheckListTableViewCell.h"

@implementation CheckListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.title = [[UILabel alloc] init];
    self.title.textColor = kMainTextColor;
    self.title.font = kFontRegular(14);
    [self.contentView addSubview:self.title];
    self.title.sd_layout.leftSpaceToView(self.contentView, 14).heightIs(24).centerYEqualToView(self.contentView);
    [self.title setSingleLineAutoResizeWithMaxWidth:ScreenWidth-120];
    
    self.date = [[UILabel alloc] init];
    self.date.textAlignment = NSTextAlignmentRight;
    self.date.textColor = kSixColor;
    self.date.font = kFontRegular(14);
    [self.contentView addSubview:self.date];
    self.date.sd_layout.rightSpaceToView(self.contentView, 14).heightIs(24).centerYEqualToView(self.contentView).widthIs(90);
    
    self.redPoints = [[BaseCircleView alloc] init];
    [self.contentView addSubview:self.redPoints];
    self.redPoints.sd_layout.leftSpaceToView(self.title, 0).topEqualToView(self.title).widthIs(8).heightEqualToWidth();
}

@end
