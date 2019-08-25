//
//  CheckTimeListView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

#import "CheckYearModel.h"

@interface CheckTimeListView : UIView

@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *navName;

@property (nonatomic, strong) void (^dismissBlock)();
@property (nonatomic, strong) void (^selectBlock)(NSString *selectTitle);
@property (nonatomic, strong) void (^selectChkModel)(CheckYearItemsModel *model);

@end
