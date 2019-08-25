//
//  QuickReplysReuqest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "QuickReplysReuqest.h"

@implementation QuickReplysReuqest

- (void)getQuickReplysComplete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"quickReplys"]];
    self.urlString = [NSString stringWithFormat:@"%@?pageindex=1&pagesize=100",self.urlString];
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

- (void)postSaveQuickReplyContent:(NSString *)content pkid:(NSString *)pkid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"SaveQuickReply"]];
    self.parameters = @{@"content":content,@"pkid":pkid};
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

- (void)postDelQuickReplyPkids:(NSArray *)pkids complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"delQuickReply"]];
    self.parameters = @{@"pkids":pkids};
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
