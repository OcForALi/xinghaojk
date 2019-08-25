//
//  DocCircleRequest.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

@interface DocCircleRequest : HttpRequest

/**
 医生圈列表
 */
- (void)doctors:(NSString *)keyword startDate:(NSString *)startDate endDate:(NSString *)endDate isScreen:(BOOL)isScreen complete:(void (^)(HttpGeneralBackModel *object))complete;

@end
