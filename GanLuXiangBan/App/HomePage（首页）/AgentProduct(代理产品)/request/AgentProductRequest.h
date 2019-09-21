//
//  AgentProductRequest.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"
#import "DrugListModel.h"
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgentProductRequest : HttpRequest


/**
 代理品种列表

 @param start 状态 0 审核中 1 审核通过 2 审核不通过 默认为1
 @param page 页数
 @param size 个数
 @param complete 回调
 */
- (void)getAgDrugLstStart:(NSInteger)start Page:(NSInteger)page size:(NSInteger)size :(void (^)(HttpGeneralBackModel *generalBackModel))complete;


- (void)postAgentDrug:(DrugListModel*)model :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取代理产品申请详情

 @param appId 申请ID?
 @param complete 回调
 */
- (void)getAgDrugAppDetailAppID:(NSInteger)appId :(void (^)(HttpGeneralBackModel *generalBackModel))complete;


- (void)postReAppDrugAgent:(ProductModel*)model :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end

NS_ASSUME_NONNULL_END
