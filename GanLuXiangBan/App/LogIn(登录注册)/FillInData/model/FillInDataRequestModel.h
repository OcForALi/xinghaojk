//
//  FillInDataRequestModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

/**
 pkid (integer, optional): 医生id ,
 Name (string, optional): 姓名 ,
 Gender (integer, optional): 性别 1 先生 0 女士 ,
 HispitalId (integer, optional): 医院 ,
 HispitalName (string, optional): 医院名称 ,
 CustName (string, optional): 科室 ,
 Title (string, optional): 职称 ,
 Introduction (string, optional): 简介 ,
 Remark (string, optional): 擅长
 */
@interface FillInDataRequestModel : BaseModel
///userid
@property (nonatomic ,copy) NSString *pkid;
///名字
@property (nonatomic ,copy) NSString *Name;
///性别
@property (nonatomic ,copy) NSString *Gender;
///科室号
@property (nonatomic ,copy) NSString *HispitalId;
///医院名字
@property (nonatomic ,copy) NSString *HispitalName;
///科室
@property (nonatomic ,copy) NSString *CustName;
///职称
@property (nonatomic ,copy) NSString *Title;
///简介
@property (nonatomic ,copy) NSString *Introduction;
///擅长
@property (nonatomic ,copy) NSString *Remark;

@end
