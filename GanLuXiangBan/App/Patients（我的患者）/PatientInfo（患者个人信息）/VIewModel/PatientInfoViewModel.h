//
//  PatientInfoViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface PatientInfoViewModel : HttpRequest

- (void)savePatientRemark:(NSString *)remark mid:(NSString *)mid complete:(void (^)(id object))complete;

@end
