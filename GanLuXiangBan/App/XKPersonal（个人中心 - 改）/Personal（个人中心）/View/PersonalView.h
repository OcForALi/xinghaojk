//
//  PersonalView.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "PersonalModel.h"

@interface PersonalView : BaseTableView

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);
@property (nonatomic, strong) PersonalModel *model;

@end
