//
//  MyPointDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MyPointDetailsModel : BaseModel

/// 月份
@property (nonatomic, strong) NSString *year_month;
/// 日期
@property (nonatomic, strong) NSString *integral_date;
/// 积分
@property (nonatomic, strong) NSString *integral_number;
/// 状态
@property (nonatomic, strong) NSString *detail_description;
@property (nonatomic, strong) NSString *prescriptionId;

@property (nonatomic, strong) NSString *status;//0 在途 1可用 2已兑换

@end
