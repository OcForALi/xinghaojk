//
//  BaseCircleView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/20.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseCircleView.h"

@implementation BaseCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    if (!self.fillColor) {
        self.fillColor = [UIColor redColor];
    }
    [self.fillColor setFill];
    [path fill];
}

@end
