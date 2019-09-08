//
//  CheckAchievementRequest.m
//  GanLuXiangBan
//
//  Created by 黎智愿 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CheckAchievementRequest.h"

@implementation CheckAchievementRequest

- (void)postPointInfoRecord_type:(NSInteger)type Page:(NSInteger)page size:(NSInteger)size Point_date:(NSString *)string :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Agent",@"PointInfo"]];
    
    self.parameters = @{@"pageindex":@(page),
                        @"pagesize":@(size),
                        @"record_type":@(type),
                        @"point_date":string
                        };
    
    [self requestNotHudWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)postPointExchangeBank_id:(NSInteger)ID  point_num:(NSInteger)point :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Agent",@"pointExchange"]];
    
    self.parameters = @{@"bank_id":@(ID),
                        @"point_num":@(point)
                        };
    
    [self requestNotHudWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
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
