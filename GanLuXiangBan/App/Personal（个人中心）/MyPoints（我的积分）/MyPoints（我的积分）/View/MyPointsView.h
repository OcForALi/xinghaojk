//
//  MyPointsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPointModel.h"

@interface MyPointsView : UIView

@property (nonatomic, strong) MyPointModel *model;
@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
