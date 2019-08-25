//
//  UILabel+Category.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (CGFloat)getTextWidth {
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    return rect.size.width;
}

- (CGFloat)getTextHeight {
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    return rect.size.height;
}

@end
