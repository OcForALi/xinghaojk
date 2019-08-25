//
//  HospitalViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HospitalViewModel.h"
#import "HospitalModel.h"

@implementation HospitalViewModel

- (void)getHospitalListComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"defaultHospitals"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            HospitalModel *model = [HospitalModel new];
            [model setValuesForKeysWithDictionary:dict];
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

- (void)queryHospital:(NSString *)searchKey city:(NSString *)city pageNo:(NSInteger)pageNo complete:(void (^)(id))complete {
    if (!city) {
        city = @"";
    }
    if (!searchKey) {
        searchKey = @"";
    }
    self.urlString = [self getRequestUrl:@[@"MasterData", @"hospitallist"]];
    self.urlString = [NSString stringWithFormat:@"%@?name=%@&city_name=%@&pageindex=%@&pagesize=10", self.urlString, searchKey, city, @(pageNo)];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            HospitalModel *model = [HospitalModel new];
            [model setValuesForKeysWithDictionary:dict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

@end
