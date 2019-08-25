
//
//  PaidConsultingViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PaidConsultingViewModel.h"

@implementation PaidConsultingViewModel

- (void)getDrVisitsComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Visit", @"DrVisits"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dataDict = genneralBackModel.data;
        for (NSDictionary *dict in dataDict) {
            
            PaidConsultingModel *model = [PaidConsultingModel new];
            [model setValuesForKeysWithDictionary:dict];
            
            if ([model.visit_type intValue] == 1) {
                
                [self getIsFree:^(id object) {
                    
                    model.isFree = [object boolValue];
                }];
            }
            
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)getIsFree:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Visit", @"twVisitIsOpen"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete([NSNumber numberWithBool:[genneralBackModel.data boolValue]]);
        }
        
    } failure:nil];
}

@end
