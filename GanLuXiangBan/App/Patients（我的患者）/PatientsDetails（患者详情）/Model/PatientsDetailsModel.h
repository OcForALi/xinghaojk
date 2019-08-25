//
//  PatientsDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PatientsDetailsModel : BaseModel

/// 患者id
@property (nonatomic, strong) NSString *pkid;
/// 名字
@property (nonatomic, strong) NSString *name;
/// 性别
@property (nonatomic, strong) NSString *gender;
/// 年龄
@property (nonatomic, strong) NSString *age;
/// 手机号码
@property (nonatomic, strong) NSString *mobile_no;
/// 分组标签id
@property (nonatomic, strong) NSString *label;
/// 分组标签名称
@property (nonatomic, strong) NSString *label_name;
/// 备注名
@property (nonatomic, strong) NSString *remarks;
/// 头像
@property (nonatomic, strong) NSString *head;
/// 地址
@property (nonatomic, strong) NSString *addr;
/// 加入时间
@property (nonatomic, strong) NSString *join_time;
/// 历史过敏原 多个用逗号分隔
@property (nonatomic, strong) NSString *allergys;

@end
