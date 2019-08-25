//
//  NewPatientViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "NewPatientViewModel.h"

@implementation NewPatientViewModel

- (void)getDrNewPatienttComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DrNewPatient"]];
    self.urlString = [NSString stringWithFormat:@"%@?pageindex=1&pagesize=10", self.urlString];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *dataArr = genneralBackModel.data;
        for (NSDictionary *dataDict in dataArr) {
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *itmeDict in dataDict[@"items"]) {
                
                PatientsModel *model = [PatientsModel new];
                [model setValuesForKeysWithDictionary:itmeDict];
                [arr addObject:model];
            }
            
            [dict setObject:arr forKey:dataDict[@"year"]];
        }
        
        if (complete) {
            complete(dict);
        }
        
    } failure:nil];
}

- (void)addPatienttComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"InvitePatients"]];
    self.parameters = @{@"name" : @"k", @"mobile" : @"13149913545"};
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

@end
