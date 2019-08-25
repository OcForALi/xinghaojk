//
//  VisitDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "VisitDetailsModel.h"

@interface VisitDetailsViewModel : HttpRequest

/**
 获取出诊时间
 */
- (void)drSchedules:(void (^)(NSArray *arr))complete;

/// 获取出诊详情
- (void)getWeekScheduleComplete:(void (^)(id object))complete;

/// 保存出诊详情
- (void)saveWeekScheduleWithModel:(NSArray *)details Complete:(void (^)(id object))complete;

/// 获取帮助
- (void)getHelpComplete:(void (^)(id object))complete;

@end
