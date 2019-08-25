//
//  RefusedView.h
//  GanLuXiangBan
//
//  Created by M on 2018/7/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefusedView : UIView

@property (nonatomic, strong) void (^textBlock)(NSString *text);

@end
