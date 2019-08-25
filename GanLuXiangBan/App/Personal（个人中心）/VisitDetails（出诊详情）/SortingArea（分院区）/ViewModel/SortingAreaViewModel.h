//
//  SortingAreaViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "SortingAreaModel.h"

@interface SortingAreaViewModel : HttpRequest


/**
     获取分院列表

     @param complete 成功回调
 */
- (void)getHospitalListComplete:(void (^)(id object))complete;


/**
     添加分院列表

     @param nameStirng 昵称
     @param complete 完成回调
 */
- (void)addHospitalWithName:(NSString *)nameStirng Complete:(void (^)(id object))complete;


/**
     删除分院

     @param complete 成功回调
 */
- (void)deleteHospitalWithId:(NSString *)idStirng Complete:(void (^)(id object))complete;

@end
