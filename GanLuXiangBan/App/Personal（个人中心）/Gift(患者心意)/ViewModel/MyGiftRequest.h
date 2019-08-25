//
//  MyGiftRequest.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

@interface MyGiftRequest : HttpRequest

/**
 获取统计数据
 */
- (void)getStatic:(void(^)(HttpGeneralBackModel *model))complete;

/**
 获取礼物列表

 @param pageNo 页码
 */
- (void)getPage:(NSInteger)pageNo complete:(void(^)(HttpGeneralBackModel *model))complete;

@end
