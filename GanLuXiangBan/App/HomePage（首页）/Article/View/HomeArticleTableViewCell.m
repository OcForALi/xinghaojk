//
//  HomeArticleTableViewCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleTableViewCell.h"

@implementation HomeArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = kFontRegular(14);
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.leftSpaceToView(self.contentView, 14).rightSpaceToView(self.contentView, 14).topSpaceToView(self.contentView, 14).heightIs(16);
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.font = kFontRegular(12);
        self.numLabel.textColor = kNightColor;
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numLabel];
        self.numLabel.sd_layout.topSpaceToView(self.nameLabel, 8).rightSpaceToView(self.contentView, 14).heightIs(14).widthIs(100);
        
        self.labelView = [[UILabel alloc] init];
        self.labelView.layer.masksToBounds = YES;
        self.labelView.layer.cornerRadius = 4.0;
        self.labelView.layer.borderWidth = 1;
        self.labelView.layer.borderColor = kNightColor.CGColor;
        self.labelView.textColor = kNightColor;
        self.labelView.textAlignment = NSTextAlignmentCenter;
        self.labelView.font = kFontRegular(12);
        [self.contentView addSubview:self.labelView];
        self.labelView.sd_layout.topSpaceToView(self.nameLabel, 8).leftSpaceToView(self.contentView, 14).heightIs(16);
        [self.labelView setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    }
    return self;
}

@end
