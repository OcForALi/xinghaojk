//
//  SubscribeViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "SubscribeModel.h"
#import "SubscribeCountModel.h"

@interface SubscribeViewModel : HttpRequest


/**
     获取预约详情

     @param preType 预约方式 1图文 2电话 3线下
     @param opStatus 0 全部 1 成功 2 待处理 3 失败
     @param page 页数
     @param complete 成功回调
 */
- (void)getOrderApps:(NSString *)preType opStatus:(NSString *)opStatus page:(NSString *)page complete:(void (^)(id object))complete;


/**
     获取数量

     @param preType 预约方式 1图文 2电话 3线下
     @param complete 成功回调
 */
- (void)getAppCount:(NSString *)preType complete:(void (^)(id object))complete;

@end
