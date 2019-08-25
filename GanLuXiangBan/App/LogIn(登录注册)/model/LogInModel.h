//
//  LogInModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface LogInModel : BaseModel
///应该userID 差不多
@property (nonatomic ,copy) NSString *pkid;
///名字
@property (nonatomic ,copy) NSString *name;
///账号
@property (nonatomic ,copy) NSString *mobileno;
///填写资料信息 0 已审核 1 基本信息未完善 2 资格验证未通过
@property (nonatomic ,assign) NSInteger check_status;
///审核状态
@property (nonatomic ,copy) NSString *check_remark;

@property (nonatomic ,copy) NSString *last_activetime;
///错误码
@property (nonatomic ,assign) NSInteger retcode;
///错误信息
@property (nonatomic ,copy) NSString *retmsg;

@end
