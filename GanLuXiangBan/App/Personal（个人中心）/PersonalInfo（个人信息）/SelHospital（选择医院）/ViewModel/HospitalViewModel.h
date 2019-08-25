//
//  HospitalViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface HospitalViewModel : HttpRequest

/// 获取医院列表
- (void)getHospitalListComplete:(void (^)(id object))complete;

/// 查找医院
- (void)queryHospital:(NSString *)searchKey city:(NSString *)city pageNo:(NSInteger)pageNo complete:(void (^)(id object))complete;

@end
