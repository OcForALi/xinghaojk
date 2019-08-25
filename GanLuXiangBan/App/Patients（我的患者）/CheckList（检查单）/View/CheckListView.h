//
//  CheckListView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface CheckListView : BaseTableView

@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);

@end
