//
//  ThroughView.h
//  GanLuXiangBan
//
//  Created by M on 2018/7/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThroughView : UIView

@property (nonatomic, assign) NSInteger throughType;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) void (^textBlock)(NSString *text, NSString *address);
@property (nonatomic, strong) UILabel *dateLabel;

@end
