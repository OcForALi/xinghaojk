//
//  SignRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SignRequest.h"

@implementation SignRequest

- (void)postSign:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"sign"]];
    
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getSignDetail:(void (^)(HttpGeneralBackModel *model))complete{
 
    self.urlString = [self getRequestUrl:@[@"Doctor", @"signDetail"]];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

@end
