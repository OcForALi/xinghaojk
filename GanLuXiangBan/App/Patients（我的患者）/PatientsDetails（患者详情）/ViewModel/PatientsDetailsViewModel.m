//
//  PatientsDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsDetailsViewModel.h"

@implementation PatientsDetailsViewModel

- (void)getDetailWithMidString:(NSString *)mid complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"Detail"]];
    self.urlString = [NSString stringWithFormat:@"%@?mid=%@", self.urlString, mid];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        PatientsDetailsModel *model = [PatientsDetailsModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

- (void)getMedicalRcdWithMidString:(NSString *)mid page:(NSString *)page complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"MedicalRcd"]];
    self.urlString = [NSString stringWithFormat:@"%@?mid=%@&pageIndex=%@&pageSize=5", self.urlString, mid, page];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *monthDict in dict[@"Months"]) {
                
                PatientsVisitDetailsModel *model = [PatientsVisitDetailsModel new];
                [model setValuesForKeysWithDictionary:monthDict];
                [arr addObject:model];
            }
            
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
            [tempDict setObject:dict[@"year_month"] forKey:@"year_month"];
            [tempDict setObject:arr forKey:@"Months"];
            [dataArr addObject:tempDict];
        }
        
        if (complete) {
            complete(dataArr);
        }
        
    } failure:nil];
}

- (void)chkUnread:(NSString *)mid complete:(void (^)(NSInteger))complete {
    NSString *url = [NSString stringWithFormat:@"Patient/ChkUnread?mid=%@", mid];
    self.urlString = [self getRequestUrl:@[url]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            NSInteger count = [genneralBackModel.data integerValue];
            complete(count);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(0);
        }
    }];
}

@end
