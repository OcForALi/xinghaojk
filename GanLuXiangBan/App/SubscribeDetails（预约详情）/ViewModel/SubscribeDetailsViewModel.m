//
//  SubscribeDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeDetailsViewModel.h"
#import "SubscribeDetailsModel.h"

@implementation SubscribeDetailsViewModel

- (void)getPreOrderDetail:(NSString *)idString complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"preOrderDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?id=%@", self.urlString, idString];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        SubscribeDetailsModel *model = [SubscribeDetailsModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}


- (void)getHelpComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"help"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

- (void)closeVisit:(NSString *)visitId complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"closeVisit"]];
    self.urlString = [NSString stringWithFormat:@"%@?visit_id=%@", self.urlString, visitId];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"结束" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)checkVisit:(NSString *)appid
          pre_type:(NSString *)pre_type
          is_check:(NSString *)is_check
            reason:(NSString *)reason
          pre_date:(NSString *)pre_date
          location:(NSString *)location
          complete:(void (^)(HttpGeneralBackModel *))complete
{
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"checkVisit"]];
    self.parameters = @{ @"appid": appid,
                         @"pre_type": pre_type,
                         @"is_check": is_check,
                         @"reason": reason,
                         @"pre_date": pre_date,
                         @"location": location};
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:nil];
}

@end
