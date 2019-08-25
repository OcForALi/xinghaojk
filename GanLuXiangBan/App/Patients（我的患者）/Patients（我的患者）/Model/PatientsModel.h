//
//  PatientsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PatientsModel : BaseModel

/// 患者ID
@property (nonatomic, strong) NSString *mid;
/// 名称
@property (nonatomic, strong) NSString *membername;
/// 性别
@property (nonatomic, strong) NSString *gender;
/// 年龄
@property (nonatomic, strong) NSString *age;
/// 头像
@property (nonatomic, strong) NSString *head;
/// 添加日期
@property (nonatomic, strong) NSString *createtime;
/// 标签名
@property (nonatomic, strong) NSString *label_name;
/// 是否星标
@property (nonatomic, strong) NSString *is_attention;
/// 未读标识
@property (nonatomic, strong) NSString *unread;
/// 首字母
@property (nonatomic, strong) NSString *initils;
/// 手机号
@property (nonatomic, strong) NSString *mobile;
/// 图文咨询费用  -1=未开通
@property (nonatomic, strong) NSString *tw_cost;
/// 电话咨询费用  -1=未开通
@property (nonatomic, strong) NSString *tel_cost;
/// 线下咨询费用  -1=未开通
@property (nonatomic, strong) NSString *line_cost;
/// 是否选中
@property (nonatomic, assign) BOOL isSelect;

@end
