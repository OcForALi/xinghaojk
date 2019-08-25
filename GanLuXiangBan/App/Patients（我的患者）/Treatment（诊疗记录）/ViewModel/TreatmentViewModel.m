//
//  TreatmentViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TreatmentViewModel.h"
#import "NSString+ToJSON.h"
#import "PatientDiagnosisModel.h"

@implementation TreatmentViewModel

- (void)addPatientDiagnosis:(NSString *)pkid content:(NSString *)content mid:(NSString *)mid addFiles:(NSArray *)addFiles delIds:(NSArray *)delIds isEdit:(BOOL)isEdit complete:(void (^)(id))complete
{
    self.urlString = [self getRequestUrl:@[@"Patient", isEdit ? @"EditPatientDiagnosis" : @"AddPatientDiagnosis"]];
    
    self.parameters = @{ @"pkid" : isEdit ? pkid : @0,
                         @"content" : content,
                         @"mid" : mid,
                         @"add_files" : addFiles,
                         @"del_ids" : delIds };
 
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"发送成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)getPatientDiagnosis:(NSString *)pkid complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"GetPatientDiagnosis"]];
    self.urlString = [NSString stringWithFormat:@"%@?pkid=%@", self.urlString, pkid];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dict in genneralBackModel.data[@"files"]) {
                
                PatientDiagnosisModel *model = [PatientDiagnosisModel new];
                [model setValuesForKeysWithDictionary:dict];
                [arr addObject:model];
            }
            
            complete(arr);
        }
        
    } failure:nil];

}

@end
