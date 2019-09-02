//
//  DepartmentViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DepartmentViewModel.h"
#import "DrugModel.h"

@implementation DepartmentViewModel

- (void)getDepartmentComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"department"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            DrugModel *model = [DrugModel new];
            [model setValuesForKeysWithDictionary:dict];
            
            NSMutableArray *items = [NSMutableArray array];
            for (NSDictionary *itemDict in dict[@"items"]) {
                DrugModel *itemsModel = [DrugModel new];
                [itemsModel setValuesForKeysWithDictionary:itemDict];
                itemsModel.id = itemDict[@"pkid"];
                [items addObject:itemsModel];
            }
            
            model.itmeArray = items;
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(error);
        }
    }];
}

@end
