//
//  DrInfoModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DrInfoModel : BaseModel

///名字
@property (nonatomic ,copy) NSString *Name;
///医师级别
@property (nonatomic ,copy) NSString *Title;
///医生邀请码
@property (nonatomic ,copy) NSString *qrcode;
///医生二维码
@property (nonatomic ,copy) NSString *qrcode2;
///邀请码
@property (nonatomic ,copy) NSString *invite_code;
///性别
@property (nonatomic ,copy) NSString *Gender;
///医院名字
@property (nonatomic ,copy) NSString *HospitalName;
///介绍
@property (nonatomic ,copy) NSString *Introduction;
///Pkid
@property (nonatomic ,copy) NSString *Pkid;
///备注
@property (nonatomic ,copy) NSString *Remark;
///Head
@property (nonatomic ,copy) NSString *Head;

@end
