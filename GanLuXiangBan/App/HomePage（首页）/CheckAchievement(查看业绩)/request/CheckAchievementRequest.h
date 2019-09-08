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

- (void)postPointInfoRecord_type:(NSInteger)type Page:(NSInteger)page size:(NSInteger)size Point_date:(NSString *)string :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end

NS_ASSUME_NONNULL_END
