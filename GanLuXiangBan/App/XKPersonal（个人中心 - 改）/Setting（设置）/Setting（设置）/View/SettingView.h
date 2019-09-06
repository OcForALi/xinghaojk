//
//  SettingView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface SettingView : BaseTableView

@property (nonatomic, strong) NSString *phoneString;
@property (nonatomic, strong) NSString *helpBodyString;

@property (nonatomic, strong) void (^goViewController)(BaseViewController *viewController);
// 拨打电话
@property (nonatomic, strong) void (^callBlock)();

@end
