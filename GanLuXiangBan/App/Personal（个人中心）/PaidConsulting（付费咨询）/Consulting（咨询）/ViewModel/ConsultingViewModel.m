//
//  ConsultingViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ConsultingViewModel.h"

@implementation ConsultingViewModel

- (void)getHelpWithType:(NSString *)type complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"AdvisoryDes"]];
    self.urlString = [NSString stringWithFormat:@"%@?type_id=%@", self.urlString, type];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

@end
