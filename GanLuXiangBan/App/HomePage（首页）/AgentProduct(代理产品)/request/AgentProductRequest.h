//
//  AgentProductRequest.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgentProductRequest : HttpRequest


/**
 代理品种列表

 @param start 状态 0 审核中 1 审核通过 2 审核不通过 默认为1
 @param page 页数
 @param size 个数
 @param complete 回调
 */
- (void)getAgDrugLstStart:(NSString *)start Page:(NSString *)page size:(NSString *)size :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end

NS_ASSUME_NONNULL_END
