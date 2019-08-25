//
//  FamousRequest.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousRequest.h"

@implementation FamousRequest

- (void)list:(NSInteger)pageNo complete:(void (^)(HttpGeneralBackModel * _Nonnull))complete {
    self.urlString = [self getRequestUrl:@[@"Doctor/gradeDrList"]];
    self.urlString = [NSString stringWithFormat:@"%@?grade=1&pageindex=%@&pagesize=10", self.urlString,@(pageNo)];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            model.retcode = -1;
            model.retmsg = error.localizedDescription;
            complete(model);
        }
        
    }];
}

/**
 GET /api/Doctor/drDetail
 医生详情
 */
- (void)detail:(NSString *)doctorId complete:(void (^)(HttpGeneralBackModel * _Nonnull))complete {
    self.urlString = [self getRequestUrl:@[@"Doctor/drDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?id=%@", self.urlString,doctorId];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            model.retcode = -1;
            model.retmsg = error.localizedDescription;
            complete(model);
        }
        
    }];
}

@end
