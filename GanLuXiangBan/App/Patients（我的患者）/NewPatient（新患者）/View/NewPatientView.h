//
//  NewPatientView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface NewPatientView : BaseTableView

@property (nonatomic, strong) NSDictionary *dictDataSource;
@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);

@end
