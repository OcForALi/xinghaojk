//
//  SubscribeView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "SubscribeCountModel.h"

@interface SubscribeView : BaseTableView

//@property (nonatomic, strong) void (^selectTypeBlock)(NSInteger type);
@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);

@property (nonatomic, assign) BOOL offlinePoint;

@end
