//
//  GroupAddView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface GroupAddView : BaseTableView

@property (nonatomic, strong) NSString *groupNameString;

#pragma mark - Block
@property (nonatomic, strong) void (^deleteBlock)(NSArray *dels);
@property (nonatomic, strong) void (^goViewControllerBlock)();

@end
