//
//  SortingAreaViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SortingAreaViewModel.h"

@implementation SortingAreaViewModel

- (void)getHospitalListComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"DrSchedule", @"DrBranchHospital"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dataDict = genneralBackModel.data;
        for (NSDictionary *dict in dataDict) {
            
            SortingAreaModel *model = [SortingAreaModel new];
            [model setValuesForKeysWithDictionary:dict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)addHospitalWithName:(NSString *)nameStirng Complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"DrSchedule", @"AddDrHospitalBranch"]];
    self.parameters = @{ @"name" : nameStirng };
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"添加成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)deleteHospitalWithId:(NSString *)idStirng Complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"DrSchedule", @"DelDrHospitalBranch"]];
    self.parameters = idStirng;
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
    
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"删除成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

@end
