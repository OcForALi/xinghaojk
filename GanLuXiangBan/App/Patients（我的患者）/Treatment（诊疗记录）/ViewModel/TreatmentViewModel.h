//
//  TreatmentViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PatientDiagnosisModel.h"

@interface TreatmentViewModel : HttpRequest

- (void)addPatientDiagnosis:(NSString *)pkid content:(NSString *)content mid:(NSString *)mid addFiles:(NSArray *)addFiles delIds:(NSArray *)delIds isEdit:(BOOL)isEdit complete:(void (^)(id))complete;

- (void)getPatientDiagnosis:(NSString *)pkid complete:(void (^)(id))complete;

@end
