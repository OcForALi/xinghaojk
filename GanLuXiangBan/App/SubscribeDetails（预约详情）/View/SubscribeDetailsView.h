//
//  SubscribeDetailsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "SubscribeDetailsModel.h"

@interface SubscribeDetailsView : BaseTableView

@property (nonatomic, strong) SubscribeDetailsModel *model;
@property (nonatomic, strong) void (^goViewController)();

@end
