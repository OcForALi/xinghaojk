//
//  PatientsVisitDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PatientsVisitDetailsModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *id;
/// 类型 0 患者上传 1 系统保存处方 2 仅诊疗记录
@property (nonatomic, strong) NSString *type;
/// 出诊当天
@property (nonatomic, strong) NSString *rcd_time_d;
/// 出诊时间
@property (nonatomic, strong) NSString *rcd_time_hm;
/// 医师
@property (nonatomic, strong) NSString *doctor_name;
/// 科室
@property (nonatomic, strong) NSString *cust_name;
/// 医院
@property (nonatomic, strong) NSString *hospital_name;
/// 内容
@property (nonatomic, strong) NSString *content;
/// 文件
@property (nonatomic, strong) NSString *files;

@end
