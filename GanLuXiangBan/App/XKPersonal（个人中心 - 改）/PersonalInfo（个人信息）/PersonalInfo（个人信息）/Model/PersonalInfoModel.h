//
//  PersonalInfoModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PersonalInfoModel : BaseModel

/// 医生主键ID
@property (nonatomic, strong) NSString *Pkid;
/// 医生姓名
@property (nonatomic, strong) NSString *Name;
/// 职称
@property (nonatomic, strong) NSString *Title;
/// 所属门诊
@property (nonatomic, strong) NSString *HospitalName;
/// 所属医院ID
@property (nonatomic, strong) NSString *HispitalId;
/// 性别
@property (nonatomic, strong) NSString *Gender;
/// 科室
@property (nonatomic, strong) NSString *CustName;
/// 擅长
@property (nonatomic, strong) NSString *Remark;
/// 简介
@property (nonatomic, strong) NSString *Introduction;
/// 头像
@property (nonatomic, strong) NSString *Head;
/// 资格认证状态 0 未认证 1 已认证 2 认证失败
@property (nonatomic, strong) NSString *Auth_Status;
/// 二维码路径
@property (nonatomic, strong) NSString *qrcode;
/// APP二维码
@property (nonatomic, strong) NSString *qrcode2;
/// 邀请码
@property (nonatomic, strong) NSString *invite_code;
/// 身份认证状态 0 未认证 1 已认证 2 认证失败
@property (nonatomic, strong) NSString *idt_auth_status;

/**
 *  城市
 */
@property (nonatomic, strong) NSString *city;

@end



@interface PersonalStaticModel : BaseModel
@property (nonatomic, strong) NSString *reg_count;
@property (nonatomic, strong) NSString *zx_count;
@property (nonatomic, strong) NSString *pay_count;
@property (nonatomic, strong) NSString *recipe_count;
@end
