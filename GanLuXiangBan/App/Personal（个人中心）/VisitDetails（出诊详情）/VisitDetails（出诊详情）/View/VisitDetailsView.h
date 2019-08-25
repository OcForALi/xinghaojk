//
//  VisitDetailsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "VisitDetailsModel.h"

@interface VisitDetailsView : BaseTableView

@property (nonatomic, strong) NSArray *hospitalList;
@property (nonatomic, strong) NSString *helpBodyString;

/// 选择院区
@property (nonatomic, strong) void (^selectHospital)();
/// 前往控制器
@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);

@end
