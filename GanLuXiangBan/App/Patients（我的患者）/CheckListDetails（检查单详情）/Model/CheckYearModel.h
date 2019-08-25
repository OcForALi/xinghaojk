//
//  CheckYearModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface CheckYearItemsModel : BaseModel

@property (nonatomic, strong) NSString *month_day;
@property (nonatomic, strong) NSString *chk_id;
@property (nonatomic, strong) NSString *unread;

@end

@interface CheckYearModel : BaseModel

/// 年份
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSArray *items;

@end
