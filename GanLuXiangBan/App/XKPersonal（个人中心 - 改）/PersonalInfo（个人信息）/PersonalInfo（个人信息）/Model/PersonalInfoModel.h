//
//  PersonalInfoModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PersonalInfoModel : BaseModel

/** 代理id */
@property (nonatomic, strong) NSString *pkid;
// 名称
@property (nonatomic, strong) NSString *name;
// 头像
@property (nonatomic, strong) NSString *head;
// 性别 男/女
@property (nonatomic, strong) NSString *gender;
// 身份证号
@property (nonatomic, strong) NSString *idcard;
// 代理省份id
@property (nonatomic, strong) NSString *province_id;
// 代理市区id
@property (nonatomic, strong) NSString *city_id;
// 资格认证状态 0 未认证 1 认证中 2 已认证(通过) 3 认证不通过
@property (nonatomic, strong) NSString *certification_status;
// 资格认证备注(一般用于记录不通过原因)
@property (nonatomic, strong) NSString *certification_remark;
// 身份认证状态 未认证 = 0, 认证中 = 1, 已认证 = 2, 认证失败 = 3
@property (nonatomic, strong) NSString *auth_status;
// 邀请医生二维码
@property (nonatomic, strong) NSString *invite_dr_qrcode;
// 邀请同行二维码
@property (nonatomic, strong) NSString *invite_sample_qrcode;
// 邀请码
@property (nonatomic, strong) NSString *invite_code;
// 资质认证附件
@property (nonatomic, strong) NSString *certification_items;
// 身份认证附件
@property (nonatomic, strong) NSString *auth_items;
// 代理医院集合
@property (nonatomic, strong) NSString *hospital_items;
/** 城市 */
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *title;

@end



@interface PersonalStaticModel : BaseModel
@property (nonatomic, strong) NSString *reg_count;
@property (nonatomic, strong) NSString *zx_count;
@property (nonatomic, strong) NSString *pay_count;
@property (nonatomic, strong) NSString *recipe_count;
@end
