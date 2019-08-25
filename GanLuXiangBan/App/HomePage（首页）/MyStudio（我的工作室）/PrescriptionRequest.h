//
//  PrescriptionRequest.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

#import "PrescriptionModel.h"

@interface PrescriptionRequest : HttpRequest

/**
 获取医生常用处方列表
 */
- (void)getCommonRecipelist:(NSInteger)pageNo key:(NSString *)key complete:(void (^)(HttpGeneralBackModel *model))complete;

/**
 保存常用处方

 @param model 处方数据
 */
- (void)postCommonRecipeInfo:(PrescriptionAddModel *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 根据常用处方id获取处方详情

 @param recipeId 常用处方id
 */
- (void)getCommonRecipeDetail:(NSString *)recipeId complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 发送处方

 @param model 处方数据
 */
- (void)postRecipeMessage:(SendRecipePost *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

@end
