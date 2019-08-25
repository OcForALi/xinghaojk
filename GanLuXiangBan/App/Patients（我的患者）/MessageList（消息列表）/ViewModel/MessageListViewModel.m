//
//  MessageListViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MessageListViewModel.h"

@implementation MessageListViewModel

- (void)getDrNoticeListWithPage:(NSString *)page complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DrNoticeList"]];
    self.urlString = [NSString stringWithFormat:@"%@?pageindex=%@&pagesize=10", self.urlString, page];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *pageDict = (NSDictionary *)genneralBackModel.pageinfo;
        for (NSDictionary *patientsDic in genneralBackModel.data) {
            
            MessageListModel *model = [MessageListModel new];
            [model setValuesForKeysWithDictionary:patientsDic];
            
            model.total = pageDict[@"total"];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

@end
