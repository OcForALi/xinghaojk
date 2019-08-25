//
//  HomeArticleDetailCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleDetailCell.h"

@implementation HomeArticleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation HomeArticleDetailHeaderCell


@end



@implementation HomeArticleDetailPictureCell


@end



@implementation HomeArticleDetailTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tagLabel.layer.borderColor = kNightColor.CGColor;
    self.tagLabel.layer.borderWidth = 1.0;
}

@end
