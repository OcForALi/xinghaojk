//
//  SettingViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SettingViewModel.h"

@implementation SettingViewModel

- (void)getHelpComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"protocol"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

- (void)getAboutComplete:(void (^)(AboutModel *model))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"about"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        AboutModel *aboutModel = [AboutModel new];
        [aboutModel setValuesForKeysWithDictionary:genneralBackModel.data];
        
        if (complete) {
            complete(aboutModel);
        }
        
    } failure:nil];
}

@end
