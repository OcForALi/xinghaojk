//
//  RecDrugsRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "RecDrugsModel.h"
#import "ChatModel.h"
#import "InitialRecipeInfoModel.h"

@interface RecDrugsRequest : HttpRequest

/**
 初始化处方
 */
-(void)getInitialTmpRecipecomplete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 初始化处方 (患者详情/消息详情)
 */
-(void)getInitialRecipeInfo:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 续方
 */
-(void)getXufangItemsMid:(NSString *)mid key:(NSString *)key paegNo:(NSInteger)pageNo complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 续方
 */
-(void)postSaveTmpRecipe:(RecDrugsModel *)model :(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 初始化处方信息及处方用药
 */
-(void)postInitialRecipeInfo:(InitialRecipeInfoModel *)model :(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 根据临床诊断结果或处方id获取对应处方用药
 */
-(void)getRecipeDruguse:(NSString *)mid recipeId:(NSString *)recipeId checkId:(NSString *)checkId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
