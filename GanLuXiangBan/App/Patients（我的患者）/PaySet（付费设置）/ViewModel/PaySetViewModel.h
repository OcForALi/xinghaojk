//
//  PaySetViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PaySetModel.h"

@interface PaySetViewModel : HttpRequest

- (void)getPatientVisit:(NSString *)mid complete:(void (^)(id object))complete;

- (void)saveVisitDetailWithModel:(PaySetModel *)model ids:(NSArray *)ids complete:(void (^)(id object))complete;

- (void)savePatientVisit:(NSArray *)list complete:(void (^)(NSString *msg))complete;

@end
