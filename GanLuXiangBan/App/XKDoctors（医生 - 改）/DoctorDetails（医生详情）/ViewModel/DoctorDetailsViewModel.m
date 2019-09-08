//
//  DoctorDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorDetailsViewModel.h"

@implementation DoctorDetailsViewModel

- (void)getDetailsWithIdStr:(NSString *)idStr complete:(void (^)(DoctorDetailsModel * _Nonnull))complete {
    
    NSString *urlStr = [NSString stringWithFormat:@"Agent/DrDetail?drid=%@", idStr];
    self.urlString = [self getRequestUrl:@[urlStr]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        DoctorDetailsModel *model = [DoctorDetailsModel new];
        [model jsonParsingWithDict:genneralBackModel.data];
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

@end
