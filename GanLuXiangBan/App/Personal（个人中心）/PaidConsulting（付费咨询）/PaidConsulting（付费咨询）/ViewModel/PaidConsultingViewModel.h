//
//  PaidConsultingViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PaidConsultingModel.h"

@interface PaidConsultingViewModel : HttpRequest

/**
     获取付费价格

     @param complete 成功回调
 */
- (void)getDrVisitsComplete:(void (^)(id object))complete;

@end
