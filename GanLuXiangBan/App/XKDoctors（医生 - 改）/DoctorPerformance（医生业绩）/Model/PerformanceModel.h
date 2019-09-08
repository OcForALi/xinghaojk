//
//  PerformanceModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerformanceModel : NSObject

/** 品种数量 */
@property (nonatomic, strong) NSString *drug_num;
/** 处方数 */
@property (nonatomic, strong) NSString *recipe_num;
/** 订单金额 */
@property (nonatomic, strong) NSString *order_amount;
/** 患者数 */
@property (nonatomic, strong) NSString *patient_num;
/** 品种明细 */
@property (nonatomic, strong) NSArray *drugModels;
/** 处方 */
@property (nonatomic, strong) NSArray *recipeModels;

@end

@interface PerformanceDrugsModel : NSObject

/** 药名 */
@property (nonatomic, strong) NSString *drug_nm;
/** 规格 */
@property (nonatomic, strong) NSString *spec;
/** 厂商名字 */
@property (nonatomic, strong) NSString *producer;
/** 数量 */
@property (nonatomic, strong) NSString *num;
/** 药名2 */
@property (nonatomic, strong) NSString *drug_name;

@end

@interface PerformanceRecipesModel : NSObject

/** 时间 */
@property (nonatomic, strong) NSString *recipe_time;
/** 临床诊断 */
@property (nonatomic, strong) NSString *check_result;
/** 金额 */
@property (nonatomic, strong) NSString *amount;
/** 模型数量 */
@property (nonatomic, strong) NSArray *drugModels;

@end


NS_ASSUME_NONNULL_END
