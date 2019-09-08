//
//  PerformanceViewModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"
#import "PerformanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PerformanceViewModel : HttpRequest

/**
 *  s获取业绩
 *
 *  @param idStr ID
 *  @param page 页数
 *  @param type 类型 0.品种明细 1.处方明细
 */
- (void)getPerformanceWithId:(NSString *)idStr page:(int)page type:(int)type complete:(void (^ _Nullable)(PerformanceModel *model))complete;

@end

NS_ASSUME_NONNULL_END
