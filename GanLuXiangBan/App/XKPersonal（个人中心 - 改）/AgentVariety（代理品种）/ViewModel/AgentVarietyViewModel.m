//
//  AgentVarietyViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentVarietyViewModel.h"
#import "AgentVarietyModel.h"

@implementation AgentVarietyViewModel

- (void)getListWithPage:(int)page complete:(void (^)(NSArray * _Nonnull))complete {
    
    NSMutableString *urlStr = [NSMutableString string];
    [urlStr appendString:@"Agent/AgDrugDetails?"];
    [urlStr appendFormat:@"page=%d&", page];
    [urlStr appendString:@"size=20"];
    
    self.urlString = [self getRequestUrl:@[urlStr]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            AgentVarietyModel *model = [AgentVarietyModel new];
            [model jsonParsingWithDict:dict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];

}

@end
