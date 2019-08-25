//
//  MedicalRecordsModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/27.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MedicalRecordsModel : BaseModel

///创建时间
@property (nonatomic ,copy) NSString *createtime;
///药品名字
@property (nonatomic ,copy) NSString *drug_names;
///头像
@property (nonatomic ,copy) NSString *head;
///年龄
@property (nonatomic ,assign) NSInteger patient_age;
///性别
@property (nonatomic ,copy) NSString *patient_gender;
///名字
@property (nonatomic ,copy) NSString *patient_name;
///配方id
@property (nonatomic ,assign) NSInteger recipe_id;
///购买状态
@property (nonatomic ,copy) NSString *status;
///购买状态
@property (nonatomic ,copy) NSString *pay_status;

@end
