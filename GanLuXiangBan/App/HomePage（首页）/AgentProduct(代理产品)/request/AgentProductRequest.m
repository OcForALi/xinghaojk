//
//  AgentProductRequest.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentProductRequest.h"

@implementation AgentProductRequest

- (void)getAgDrugLstStart:(NSInteger)status Page:(NSInteger)page size:(NSInteger)size :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
   
    self.urlString = [self getRequestUrl:@[@"Drug",@"AgDrugLst"]];
    
    self.urlString = [NSString stringWithFormat:@"%@?status=%ld&page=%ld&size=%ld", self.urlString,status,page,size];
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
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
