//
//  VisitDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface VisitDetailsModel : BaseModel

/// 是否出诊
@property (nonatomic, assign) BOOL isVisits;
/// 星期
@property (nonatomic, strong) NSString *week;
/// 早上出诊类型 门诊类型 0 不出诊 1 普通 2 专家 3 特诊
@property (nonatomic, strong) NSString *amType;
/// 下午出诊类型 门诊类型 0 不出诊 1 普通 2 专家 3 特诊
@property (nonatomic, strong) NSString *pmType;
/// 早上出诊医院
@property (nonatomic, strong) NSString *amHospital;
/// 下午出诊医院
@property (nonatomic, strong) NSString *pmHospital;

- (void)setDict:(NSDictionary *)dict;

@end


@interface DcScheduleModel : BaseModel
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSArray *weeks;//DcScheduleWeekModel
@end


@interface DcScheduleWeekModel : BaseModel
@property (nonatomic, copy) NSString *week;
@property (nonatomic, strong) NSArray *items;//DcScheduleItemModel
@end


@interface DcScheduleItemModel : BaseModel
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, copy) NSString *clinc_type;
@end
