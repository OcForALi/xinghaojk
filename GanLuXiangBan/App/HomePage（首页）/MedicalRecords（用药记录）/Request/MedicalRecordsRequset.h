//
//  MedicalRecordsRequset.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/27.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "MedicalRecordsModel.h"
@interface MedicalRecordsRequset : HttpRequest

/**
 用药记录
 
 @param key 关键字 搜索栏用
 */

- (void)getMedicationRecordsKey:(NSString *)key page:(NSInteger)page complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 用药记录
 
 @param recipe_id 配方ID
 @param status 购买状态
 */

- (void)getMedicatinDetailRecipe_id:(NSInteger)recipe_id status:(NSString *)status complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 用药统计
 */
- (void)getMedicalStatic:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 获取未发送的处方详情

 @param recipeId 处方ID
 */
- (void)getUnsendRecipeDetail:(NSString *)recipeId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
