//
//  FamousRequest.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

@interface FamousRequest : HttpRequest

/**
 GET /api/Doctor/gradeDrList
 医生列表-名医查询
 */
- (void)list:(NSInteger)pageNo complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 GET /api/Doctor/drDetail
 医生详情

 @param doctorId 医生id
 */
- (void)detail:(NSString *)doctorId complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end
