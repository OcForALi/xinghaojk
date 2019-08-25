//
//  SubscribeDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SubscribeDetailsModel : BaseModel

/// 患者id
@property (nonatomic, strong) NSString *mid;
/// 患者手机号码
@property (nonatomic, strong) NSString *mobile;
/// 用户名称
@property (nonatomic, strong) NSString *patient_name;
/// 性别
@property (nonatomic, strong) NSString *gender;
/// 年龄
@property (nonatomic, strong) NSString *age;
/// 头像
@property (nonatomic, strong) NSString *head;
/// 医生id
@property (nonatomic, strong) NSString *drid;
/// 申请时间
@property (nonatomic, strong) NSString *createtime;
/// 期望预约时间
@property (nonatomic, strong) NSString *except_date;
/// 咨询方式 1 图文 2 电话 3 线下
@property (nonatomic, strong) NSString *pre_type;
/// 咨询时间
@property (nonatomic, strong) NSString *pre_date;
/// 状态 待审核=0,待付款=1,待咨询=2,已关闭=3,已结束=4,已评价=5
@property (nonatomic, strong) NSString *status;
/// 地址
@property (nonatomic, strong) NSString *location;
/// 病情描述
@property (nonatomic, strong) NSString *disease_desc;
/// 附件集
@property (nonatomic, strong) NSArray *files;
/// 关闭/结束原因
@property (nonatomic, strong) NSString *closing_reason;
/// 订单是否自动关闭/结束
@property (nonatomic, strong) NSString *is_auto_close;
/// 关闭时间
@property (nonatomic, strong) NSString *close_time;
/// 药方ID
@property (nonatomic ,assign) NSInteger medical_id;


@end
