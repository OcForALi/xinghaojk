//
//  CheckAchievementRequest.h
//  GanLuXiangBan
//
//  Created by 黎智愿 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckAchievementRequest : HttpRequest

/**
 积分明细

 @param type 0 所有 1 收入 -1 支出
 @param page 页数
 @param size 数量
 @param string 积分时间 默认传空字符串(表示近6个月)，本月传0，前一个月传-1，前两个月传-2 ，以此类推
 @param complete 回调
 */
- (void)postPointInfoRecord_type:(NSInteger)type Page:(NSInteger)page size:(NSInteger)size Point_date:(NSString *)string :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 积分兑换

 @param ID 银行卡ID
 @param point 兑换数量
 @param complete 回调
 */
- (void)postPointExchangeBank_id:(NSInteger)ID  point_num:(NSInteger)point :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end

NS_ASSUME_NONNULL_END
