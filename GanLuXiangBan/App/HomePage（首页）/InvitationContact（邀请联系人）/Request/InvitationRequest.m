//
//  InvitationRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/9/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "InvitationRequest.h"

@implementation InvitationRequest

- (void)getK780AppKey:(NSString *)AppKey Sign:(NSString *)Sign :(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"DrugDetail"]];
    
//    self.urlString = [NSString stringWithFormat:@"%@?drugid=%ld", self.urlString,[drugID integerValue]];
    
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
