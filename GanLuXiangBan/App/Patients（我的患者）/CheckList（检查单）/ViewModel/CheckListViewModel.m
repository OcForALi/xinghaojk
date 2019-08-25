//
//  CheckListViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListViewModel.h"
#import "CheckListModel.h"

@implementation CheckListViewModel

- (void)getChkTypeListWithMid:(NSString *)mid complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"ChkTypeList"]];
    self.urlString = [NSString stringWithFormat:@"%@?mid=%@", self.urlString, mid];

    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
         
            CheckListModel *model = [CheckListModel new];
            [model setValuesForKeysWithDictionary:dict];
            [dataArr addObject:model];
        }
        
        if (complete) {
            complete(dataArr);
        }
        
    } failure:nil];
}

@end
