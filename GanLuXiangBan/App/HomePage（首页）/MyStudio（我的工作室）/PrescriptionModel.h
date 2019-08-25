//
//  PrescriptionModel.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/23.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrescriptionAddDrugModel : NSObject
@property (nonatomic, assign) NSInteger pkid; //新增传0 修改时传对应的值
@property (nonatomic, copy) NSString *drugid; //药品id
@property (nonatomic, copy) NSString *use_num;//药品数量
@property (nonatomic, assign) NSInteger days;//天数
@property (nonatomic, copy) NSString *use_type;//用法
@property (nonatomic, copy) NSString *use_cycle;//用药周期名称 比如：3天,1周，1月等
@property (nonatomic, copy) NSString *day_use;//服用次数
@property (nonatomic, copy) NSString *day_use_num;//每次服用数量
@property (nonatomic, copy) NSString *use_unit;//用量单位
@property (nonatomic, copy) NSString *use_num_name;//用量名称
@end

@interface PrescriptionAddModel : NSObject
@property (nonatomic, copy) NSString *check_id;//临床诊断id
@property (nonatomic, copy) NSString *recipe_id;//新增传0
@property (nonatomic, copy) NSString *check_result;//临床诊断
@property (nonatomic, strong) NSArray *drugs;//药品集合
@end

@interface SendRecipePost : NSObject
@property (nonatomic, assign) NSInteger recipe_id;// 处方id
@property (nonatomic, strong) NSArray *druguse_items;// 处方用药集合
@end


@interface PrescriptionDrugModel : NSObject
@property (nonatomic, copy) NSString *drugId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *alia;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, assign) NSInteger status;
+ (instancetype)initWithDes:(NSString *)des;
@end

@interface PrescriptionModel : BaseModel
@property (nonatomic, assign) NSInteger recipelist_id;//1493
@property (nonatomic, assign) NSInteger check_id;//20271,
@property (nonatomic, assign) NSInteger drug_count;//1,
@property (nonatomic, assign) NSInteger medical_id;//0,
@property (nonatomic, copy) NSString *drug_use_str;//"120396#可乐必妥#左氧氟沙星片#2.00",
@property (nonatomic, copy) NSString *check_result;//"慢性前列腺炎腹性盆腔疼痛综合征"
@property (nonatomic, strong) NSArray *drugs;
@end

@interface PrescriptionDetailModel : BaseModel
@property (nonatomic, assign) NSInteger recipe_id;//常用处方id
@property (nonatomic, assign) NSInteger check_id;//临床诊断id
@property (nonatomic, copy) NSString *check_result;//临床诊断
@property (nonatomic, strong) NSArray *drugs;//处方药集合
@end

NS_ASSUME_NONNULL_END
