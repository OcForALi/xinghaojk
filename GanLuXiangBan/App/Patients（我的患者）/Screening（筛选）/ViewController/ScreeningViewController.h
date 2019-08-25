//
//  ScreeningViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

@interface ScreeningViewController : BaseViewController

@property (nonatomic, strong) NSArray *allTypes;

@property (nonatomic, strong) void(^didBackToTrendVCBlock)(void);

@end
