//
//  DiseasesRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "DiseaseLibraryModel.h"

@interface DiseasesRequest : HttpRequest


/**
 疾病库

 */
-(void)getSearchMedicalDiseaseKey:(NSString *)key type:(DiseaseLibraryType)type pageindex:(NSInteger)pageindex complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 疾病库
 
 @param key 关键字 搜索栏用
 */
- (void)getdrDiseaseLstKey:(NSString *)key pageindex:(NSInteger)pageindex pagesize:(NSInteger)pagesize complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 收藏疾病库

 */
-(void)postCollectDiseaseId:(DiseaseLibraryModel *)model complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 删除常用疾病
 */
-(void)postDelDrDisease:(NSString *)diseaseId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
