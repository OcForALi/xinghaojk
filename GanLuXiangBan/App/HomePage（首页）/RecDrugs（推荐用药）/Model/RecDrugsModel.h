//
//  RecDrugsModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface RecDrugsModel : BaseModel
///处方号
@property (nonatomic ,copy) NSString *code;
///处方时间
@property (nonatomic ,copy) NSString *createtime;
///临床诊断
@property (nonatomic ,copy) NSArray *rcd_result;
///姓名
@property (nonatomic ,copy) NSString *patient_name;
///年龄
@property (nonatomic ,copy) NSString *age;
///性别
@property (nonatomic ,copy) NSString *gender;
///处方号 （猜测）
@property (nonatomic ,copy) NSString *check_id;
///临床诊断
@property (nonatomic ,copy) NSString *check_result;

@property (nonatomic ,copy) NSString *analysis_result;

@property (nonatomic ,copy) NSString *analysis_suggestion;
///用药
@property (nonatomic ,copy) NSArray *druguse_items;

@end
