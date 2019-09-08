
//
//  PersonalViewModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PersonalViewModel.h"
#import "MyPointsViewModel.h"
#import "MyPointModel.h"

@implementation PersonalViewModel

- (void)getDataSource:(void (^)(PersonalModel *))complete {
    
    NSMutableString *urlStr = [NSMutableString string];
    [urlStr appendString:@"Agent/PersonalStatics"];
    
    self.urlString = [self getRequestUrl:@[urlStr]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        PersonalModel *model = [PersonalModel new];
        [model jsonParsingWithDict:genneralBackModel.data];
        
        // 可用积分
        [self getIntegral:^(NSString *integral, NSString *total) {
            
            model.integral = integral;
            model.totalIntegral = total;
            
            if (complete) {
                complete(model);
            }
        }];
            
    } failure:nil];
}

- (void)getIntegral:(void (^)(NSString *integral, NSString *total))complete {
    
    MyPointsViewModel *viewModel = [MyPointsViewModel new];
    [viewModel getPointWithPage:1 recordType:@"0" pointDate:@"" detailType:@"all" complete:^(id object) {
       
        MyPointModel *model = object[0];
        
        // 可用积分
        NSString *integral = model.integralBalancep;
        // 总积分
        NSString *total = [@([integral intValue] + [model.presentIntegral intValue]) stringValue];
        
        // 完成
        if (complete) {
            complete(integral, total);
        }
    }];
}

@end
