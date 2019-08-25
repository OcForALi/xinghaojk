//
//  PrescriptionDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DruguseModel : BaseModel

/// 药名
@property (nonatomic, strong) NSString *drug_name;
/// 次数
@property (nonatomic, strong) NSString *qty;
/// 使用说明
@property (nonatomic, strong) NSString *dosage;
/// 备注
@property (nonatomic, strong) NSString *remark;

@end

@interface PrescriptionDetailsModel : BaseModel

/// 编号
@property (nonatomic, strong) NSString *code;
/// 时间
@property (nonatomic, strong) NSString *date;
/// 姓名
@property (nonatomic, strong) NSString *name;
/// 性别
@property (nonatomic, strong) NSString *gender;
/// 年龄
@property (nonatomic, strong) NSString *age;
/// 地区
@property (nonatomic, strong) NSString *region;
/// 前三次诊疗结果
@property (nonatomic, strong) NSString *rcd_result;
/// 当次诊断结果
@property (nonatomic, strong) NSString *rcd_result2;
/// 处方用药记录
@property (nonatomic, strong) NSArray *druguses;
/// 处方开具医生
@property (nonatomic, strong) NSString *recipe_drname;
/// 收费金额
@property (nonatomic, strong) NSString *money;
/// 审方药师
@property (nonatomic, strong) NSString *check_drname;
/// 调配药师
@property (nonatomic, strong) NSString *allocate_drname;
/// 核对/发药药师
@property (nonatomic, strong) NSString *medicine_drname;
/// 药品渠道 0 平台 1 七乐康
@property (nonatomic, strong) NSString *channel;

@property (nonatomic, assign) NSInteger check_id;

@property (nonatomic, strong) NSString *check_result;

@property (nonatomic, strong) NSArray *dicDrugs;

@end
