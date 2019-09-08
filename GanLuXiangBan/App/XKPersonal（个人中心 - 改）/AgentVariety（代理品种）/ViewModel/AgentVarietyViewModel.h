//
//  AgentVarietyViewModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgentVarietyViewModel : HttpRequest

/**
 *  获取品种列表
 *
 *  @param page 页数
 */
- (void)getListWithPage:(int)page complete:(void (^)(NSArray *list))complete;

@end

NS_ASSUME_NONNULL_END
