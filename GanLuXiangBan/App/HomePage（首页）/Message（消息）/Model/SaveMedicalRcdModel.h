//
//  SaveMedicalRcdModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/27.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SaveMedicalRcdModel : BaseModel

@property (nonatomic ,copy) NSString *mid;
///患者名字
@property (nonatomic ,copy) NSString *patient_name;
///患者年龄
@property (nonatomic ,copy) NSString *patient_age;
///患者性别
@property (nonatomic ,copy) NSString *patient_gender;
///诊疗ID
@property (nonatomic ,copy) NSString *code;
///诊疗ID
@property (nonatomic ,copy) NSString *check_id;
///诊断结果
@property (nonatomic ,copy) NSString *rcd_result;
///分析结果
@property (nonatomic ,copy) NSString *analysis_result;
///分析建议
@property (nonatomic ,copy) NSString *analysis_suggestion;
///药品
@property (nonatomic ,copy) NSArray *druguse_items;
///消息状态
@property (nonatomic ,copy) NSString *msg_flag;
///药方ID
@property (nonatomic ,copy) NSString *visit_id;
///消息id
@property (nonatomic ,copy) NSString *msg_id;
///不知道干啥子用的
//@property (nonatomic ,copy) NSString *zx_no;
///过敏 ？？？ 不清楚
@property (nonatomic ,copy) NSString *allergy_codes;
///过敏名字
@property (nonatomic ,copy) NSString *allergy_names;

@end

@interface UpdateMedicalRcdModel : BaseModel
///处方ID
@property (nonatomic ,assign) NSInteger recipe_id;
///患者名字
@property (nonatomic ,copy) NSString *patient_name;
///患者年龄
@property (nonatomic ,assign) NSInteger patient_age;
///患者性别
@property (nonatomic ,copy) NSString *patient_gender;
///诊疗ID
@property (nonatomic ,assign) NSInteger check_id;
///诊断结果
@property (nonatomic ,copy) NSString *check_result;
///药品
@property (nonatomic ,copy) NSArray *druguse_items;

@end
