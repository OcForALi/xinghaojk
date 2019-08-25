//
//  SubscribeModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SubscribeModel : BaseModel

/// id
@property (nonatomic, strong) NSString *pkid;
/// 头像
@property (nonatomic, strong) NSString *head;
/// 昵称
@property (nonatomic, strong) NSString *member_name;
/// 性别
@property (nonatomic, strong) NSString *gender;
/// 年龄
@property (nonatomic, strong) NSString *age;
/// 患者ID
@property (nonatomic, strong) NSString *mid;
/// 状态 待审核=0, 待付款=1, 待咨询=2, 已关闭=3, 已结束=4, 已评价=5
@property (nonatomic, strong) NSString *status;
/// 咨询日期
@property (nonatomic, strong) NSString *pre_date;
/// 地址
@property (nonatomic, strong) NSString *location;

@end
