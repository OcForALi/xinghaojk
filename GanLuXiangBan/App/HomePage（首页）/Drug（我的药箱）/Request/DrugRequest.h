//
//  DrugRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "DrugModel.h"

@interface DrugRequest : HttpRequest

/**
 药品分类
 
 */
- (void)getDrug:(void (^)(HttpGeneralBackModel *model))complete;


/**
 药品搜索
 @param class_id 分类id
 @param key 关键字
 @param sort_col 排序字段 0 默认 1 价格 2 销量
 @param is_desc  是否降序 0 否 1 是
 
 */
- (void)getSearchDrugClass_id:(NSString *)class_id key:(NSString *)key sort_col:(NSInteger)sort_col is_desc:(BOOL)is_desc pageindex:(NSInteger)pageindex :(void (^)(HttpGeneralBackModel *model))complete;

/**
 药品详情
 @param drugID 药品id
 
 */
- (void)getDrugDetailDrugID:(NSString *)drugID :(void (^)(HttpGeneralBackModel *model))complete;

/**
 我的收藏
 @param key 关键字
 
 */
- (void)getDrFavDrugsclass_id:(NSInteger)class_id Key:(NSString *)key pageindex:(NSInteger)pageindex :(void (^)(HttpGeneralBackModel *model))complete;
/**
 收藏
 @param drugid 收藏药品ID
 
 */
- (void)postFavDrugID:(NSString *)drugid :(void (^)(HttpGeneralBackModel *model))complete;

/**
删除药品ID数组
 */
- (void)postDelDrFavDrug:(NSArray *)drugids :(void (^)(HttpGeneralBackModel *model))complete;

/**
 获取药品用量

 @param drugId 药品ID
 */
- (void)getDrugUseage:(NSString *)drugId complete:(void (^)(HttpGeneralBackModel *model))complete;

@end
