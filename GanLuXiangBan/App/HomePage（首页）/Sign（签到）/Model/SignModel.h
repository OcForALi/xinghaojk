//
//  SignModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SignModel : BaseModel
///已签到 日期
@property (nonatomic ,copy) NSArray *sign_his;
///连续签到提醒语
@property (nonatomic ,copy) NSString *remark;
///连续天数
@property (nonatomic ,copy) NSString *continuity_sign_days;
///签到规则
@property (nonatomic ,copy) NSString *sign_rules;

@end
