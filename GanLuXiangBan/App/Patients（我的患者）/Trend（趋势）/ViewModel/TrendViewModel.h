//
//  TrendViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface TrendViewModel : HttpRequest

- (void)getChkTrend:(NSString *)mid chkTypeId:(NSString *)chkTypeId items:(NSArray *)items complete:(void (^)(id object))complete;

@end
