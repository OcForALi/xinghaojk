//
//  DeleteTipView.h
//  GanLuXiangBan
//
//  Created by M on 2018/7/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteTipView : UIView

@property (nonatomic, strong) void (^exitBlock)();
@property (nonatomic, strong) void (^goViewController)();

@end
