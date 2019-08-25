//
//  SignRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface SignRequest : HttpRequest

/**
 医生签到
 
 */
- (void)postSign:(void (^)(HttpGeneralBackModel *model))complete;

/**
 医生签到详情（签到成功后页面)
 
 */
- (void)getSignDetail:(void (^)(HttpGeneralBackModel *model))complete;

@end
