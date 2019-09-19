//
//  PrescriptionNumViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionNumViewModel.h"
#import "PrescriptionNumModel.h"

@implementation PrescriptionNumViewModel

- (void)getListWithPage:(int)page complete:(void (^)(NSArray *list))complete {
    
    NSMutableString *urlStr = [NSMutableString string];
    [urlStr appendString:@"Agent/DrRecipeStatistics?"];
    [urlStr appendFormat:@"page=%d&", page];
    [urlStr appendString:@"size=20"];
    
    self.urlString = [self getRequestUrl:@[urlStr]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if ([genneralBackModel.data isKindOfClass:[NSNull class]] || genneralBackModel.data == nil || [genneralBackModel.data isKindOfClass:[NSString class]]) {
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            PrescriptionNumModel *model = [PrescriptionNumModel new];
            [model jsonParsingWithDict:dict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

@end
