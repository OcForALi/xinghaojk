//
//  NewPatientViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PatientsModel.h"

@interface NewPatientViewModel : HttpRequest

/**
     获取患者列表
 
     @param complete 成功回调
 */
- (void)getDrNewPatienttComplete:(void (^)(id object))complete;

- (void)addPatienttComplete:(void (^)(id object))complete;

@end
