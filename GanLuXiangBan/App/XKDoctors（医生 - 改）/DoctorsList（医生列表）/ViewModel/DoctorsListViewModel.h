//
//  DoctorsListViewModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoctorsListViewModel : HttpRequest

/**
 *  获取医生列表
 *
 *  @param key 还不清楚是啥
 *  @param page 页数
 *  @param complete 返回医生列表
 */
- (void)getDataSourceWithKey:(NSString *)key page:(int)page complete:(void (^)(NSDictionary *dataSource))complete;

@end

NS_ASSUME_NONNULL_END
