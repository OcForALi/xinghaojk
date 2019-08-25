//
//  SubscribeViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeViewModel.h"


@implementation SubscribeViewModel

- (void)getOrderApps:(NSString *)preType opStatus:(NSString *)opStatus page:(NSString *)page complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"orderApps"]];
    self.urlString = [NSString stringWithFormat:@"%@?pre_type=%@&op_status=%@&pageindex=%@&pagesize=10", self.urlString, preType, opStatus, page];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dataDict in genneralBackModel.data) {
            
            SubscribeModel *model = [SubscribeModel new];
            [model setValuesForKeysWithDictionary:dataDict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

- (void)getAppCount:(NSString *)preType complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"appCount"]];
    self.urlString = [NSString stringWithFormat:@"%@?pre_type=%@", self.urlString, preType];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        SubscribeCountModel *model = [SubscribeCountModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

@end
