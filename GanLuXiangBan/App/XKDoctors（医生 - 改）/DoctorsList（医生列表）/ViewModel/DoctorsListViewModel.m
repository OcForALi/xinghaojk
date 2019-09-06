//
//  DoctorsListViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorsListViewModel.h"
#import "DoctorsListModel.h"

@implementation DoctorsListViewModel

- (void)getDataSourceWithKey:(NSString *)key page:(int)page complete:(void (^)(NSDictionary *))complete {
    
    NSMutableString *urlStr = [NSMutableString string];
    [urlStr appendString:@"Agent/MyDoctor?"];
    [urlStr appendFormat:@"key=%@&", key];
    [urlStr appendFormat:@"page=%d&", page];
    [urlStr appendString:@"size=10"];
    
    self.urlString = [self getRequestUrl:@[urlStr]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
    
        NSMutableDictionary *dataSource = [NSMutableDictionary dictionary];
        for (NSDictionary *dataDict in genneralBackModel.data) {
            
            DoctorsListModel *model = [DoctorsListModel new];
            [model jsonParsingWithDict:dataDict];
            
            NSString *key = model.initils;
            if (key.length > 1) {
                key = [key substringToIndex:1];
            }
            
            if ([dataSource.allKeys containsObject:key]) {
                
                NSMutableArray *arr = [NSMutableArray arrayWithArray:dataDict[key]];
                [arr addObject:model];
                [dataSource setObject:arr forKey:key];
            }
            else {
                
                [dataSource setObject:@[model] forKey:key];
            }
        }
        
        if (complete) {
            complete(dataSource);
        }
        
    } failure:nil];
}

@end
