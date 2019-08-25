//
//  PatientsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PatientsModel.h"

@interface PatientsViewModel : HttpRequest

/**
     获取患者列表

     @param complete 成功回调
 */
- (void)getDrPatientWithIds:(NSArray *)Ids complete:(void (^)(id))complete;


/**
     设置星标

     @param mid 患者ID
     @param isAttention 是否设置
     @param complete 成功回调
 */
- (void)setAttentionWithMid:(NSString *)mid isAttention:(BOOL)isAttention Complete:(void (^)(id object))complete;

@end
