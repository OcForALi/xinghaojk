//
//  ScheduleModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface ScheduleModel : BaseModel
//名字
@property (nonatomic ,copy)NSString *patient_name;
//日期
@property (nonatomic ,copy)NSString *createtime;
//时间
@property (nonatomic ,copy)NSString *expect_time;
//pkid
@property (nonatomic ,copy)NSString *pkid;
//状态
@property (nonatomic ,copy)NSString *status;
//未读状态 0 = 已读 1 = 未读
@property (nonatomic ,assign) NSInteger unread;

@end


@interface ExhaleModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mobile;
@end
