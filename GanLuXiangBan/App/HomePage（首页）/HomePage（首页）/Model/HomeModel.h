//
//  HomeModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"
#import "DrInfoModel.h"

@interface HomeModel : BaseModel

///评价数
@property (nonatomic ,assign) NSInteger evaluateNum;
///患者数
@property (nonatomic ,assign) NSInteger patientNum;
///医生信息
@property (nonatomic ,copy) NSDictionary *drinfo;

@property (nonatomic ,retain) DrInfoModel *drinfoModel;
///底部未读？
@property (nonatomic ,assign) NSInteger indexUnread;
///
@property (nonatomic ,assign) NSInteger is_sign;
///日程未读？
@property (nonatomic ,assign) NSInteger orderUnread;


@end
