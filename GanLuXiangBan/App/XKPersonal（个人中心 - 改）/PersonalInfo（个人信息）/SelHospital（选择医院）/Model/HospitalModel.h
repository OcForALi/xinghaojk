//
//  HospitalModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface HospitalModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *pkid;
/// 医院名称
@property (nonatomic, strong) NSString *name;
/// 城市ID
@property (nonatomic, strong) NSString *cityid;
/// 地址
@property (nonatomic, strong) NSString *address;
/// 联系方式
@property (nonatomic, strong) NSString *contact_tel;
@property (nonatomic, strong) NSString *level;
/// 检查状态
@property (nonatomic, strong) NSString *check_status;
/// 城市
@property (nonatomic, strong) NSString *citys;


@end
