//
//  PrescriptionDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PrescriptionDetailsViewModel.h"
#import "PrescriptionDetailsModel.h"

@implementation PrescriptionDetailsViewModel

- (void)getElectronRecipeDetail:(NSString *)idStirng complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"electronRecipeDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?medical_id=%@", self.urlString, idStirng];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        PrescriptionDetailsModel *model = [PrescriptionDetailsModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        NSMutableArray *arr = [NSMutableArray array];
        model.dicDrugs = model.druguses;
        for (NSDictionary *dict in model.druguses) {
            
            DruguseModel *model = [DruguseModel new];
            [model setValuesForKeysWithDictionary:dict];
            [arr addObject:model];
        }
        
        model.druguses = arr;
        
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

@end
