//
//  PatientInfoViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientInfoViewModel.h"

@implementation PatientInfoViewModel

- (void)savePatientRemark:(NSString *)remark mid:(NSString *)mid complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"savePatientRemark"]];
    self.parameters = @{ @"remark" : remark, @"mid" : mid };
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"备注修改成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

@end
