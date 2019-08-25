//
//  Evaluation.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EvaluationRequest.h"

@implementation EvaluationRequest

- (void)getEvaluatesPageindex:(NSInteger)pageindex complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"evaluates"]];
    self.urlString = [NSString stringWithFormat:@"%@?pageindex=%ld", self.urlString,pageindex];
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

- (void)getDdmirationDetailID:(NSString *)id complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"admirationDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?evaluate_id=%@", self.urlString,id];
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

@end
