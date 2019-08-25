//
//  MyGiftRequest.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyGiftRequest.h"

@implementation MyGiftRequest

- (void)getStatic:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"Doctor/AdmirationStatistics"]];
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

- (void)getPage:(NSInteger)pageNo complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = [NSString stringWithFormat:@"Doctor/PatientAdmirationList?type=-1&pageindex=%@&pagesize=10",@(pageNo)];
    self.urlString = [self getRequestUrl:@[url]];
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
