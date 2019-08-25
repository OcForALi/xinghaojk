//
//  ScheduleRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ScheduleRequest.h"

@implementation ScheduleRequest

-(void)getPreOrderListPageindex:(NSInteger)pageindex :(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"PatientOrder", @"preOrderList"]];
    self.urlString = [NSString stringWithFormat:@"%@?pageindex=%@&pagesize=10", self.urlString,@(pageindex)];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)postExhale:(ExhaleModel *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"PatientOrder/exhale"]];
    //@"http://39.108.187.219/xhjk_api/api/PatientOrder/exhale";
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

@end
