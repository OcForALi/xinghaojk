//
//  DocCircleRequest.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleRequest.h"

@implementation DocCircleRequest

- (void)doctors:(NSString *)keyword startDate:(NSString *)startDate endDate:(NSString *)endDate isScreen:(BOOL)isScreen complete:(void (^)(HttpGeneralBackModel *))complete {
    if (!keyword) {
        keyword = @"";
    }
    if (!startDate) {
        startDate = @"";
    }
    if (!endDate) {
        endDate = @"";
    }
    NSString *sc = isScreen ? @"1" : @"0";
    self.urlString = [self getRequestUrl:@[@"Doctor/docterInviteRecordList"]];
    self.urlString = [self.urlString stringByAppendingFormat:@"?keyword=%@&startDate=%@&endDate=%@&isScreen=%@", keyword, startDate, endDate, sc];
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
