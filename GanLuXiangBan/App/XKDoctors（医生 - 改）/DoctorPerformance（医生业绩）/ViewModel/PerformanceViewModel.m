
//
//  PerformanceViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PerformanceViewModel.h"

@implementation PerformanceViewModel

- (void)getPerformanceWithId:(NSString *)idStr page:(int)page type:(int)type complete:(void (^ _Nullable)(PerformanceModel *model))complete {
    
    NSMutableString *urlStr = [NSMutableString string];
    [urlStr appendString:@"Agent/DrStatistics?"];
    // ID
    [urlStr appendFormat:@"drid=%@&", idStr];
    // 类型
    [urlStr appendFormat:@"type=%d&", type];
    // 页数
    [urlStr appendFormat:@"page=%d&", page];
    // 数量
    [urlStr appendString:@"size=10"];
    
    self.urlString = [self getRequestUrl:@[urlStr]];;
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        PerformanceModel *model = [PerformanceModel new];
        [model jsonParsingWithDict:genneralBackModel.data];
        
        if (complete) {
            complete(model);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

@end
