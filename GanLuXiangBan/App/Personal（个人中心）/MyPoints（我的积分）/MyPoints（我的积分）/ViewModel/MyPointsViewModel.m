//
//  MyPointsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyPointsViewModel.h"
#import "MyPointModel.h"
#import "MyPointDetailsModel.h"
#import "MyPointInfoModel.h"

@implementation MyPointsViewModel

- (void)getPointWithPage:(NSInteger)page
              recordType:(NSString *)recordType
               pointDate:(NSString *)pointDate
              detailType:(NSString *)detailType
                complete:(void (^)(id))complete
{
    if (!detailType) {
        detailType = @"all";
    }
    self.urlString = [self getRequestUrl:@[@"Agent", @"PointInfo"]];
    self.parameters = @{ @"pageindex" : [NSNumber numberWithInteger:page],
                         @"pagesize": @(10),
                         @"record_type" : recordType,
                         @"point_date" : pointDate };

    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (genneralBackModel.data == nil) {
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dict = genneralBackModel.data;
        NSDictionary *pageInfoDict = (NSDictionary *)genneralBackModel.pageinfo;
        
        MyPointModel *model = [MyPointModel new];
        [model setValuesForKeysWithDictionary:dict];
        [model setValuesForKeysWithDictionary:pageInfoDict];
        
        NSMutableArray *details = [NSMutableArray array];
        for (NSDictionary *detailDict in dict[@"details"]) {
            
            for (NSDictionary *itemsDict in detailDict[@"items"]) {
                
                MyPointDetailsModel *detailsModel = [MyPointDetailsModel new];
                detailsModel.year_month = [detailDict valueForKey:@"year_month"];
                [detailsModel setValuesForKeysWithDictionary:itemsDict];
                [details addObject:detailsModel];
            }
        }
        
        model.detailList = details;
        [arr addObject:model];

        if (complete) {
            complete(arr);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

- (void)pointExchangeWithBankId:(NSString *)bankId
                       pointNum:(NSString *)pointNumber
                       complete:(void (^)(id object))complete
{
    self.urlString = [self getRequestUrl:@[@"Doctor", @"pointExchange"]];
    self.parameters = @{ @"bank_id" : bankId, @"point_num": pointNumber };
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"兑换成功" : genneralBackModel.retmsg);
        }

    } failure:nil];
}

- (void)pointDetail:(NSString *)prescriptionId complete:(void (^)(id))complete {
    self.urlString = [self getRequestUrl:@[@"Doctor/PointDetail"]];
    self.urlString = [self.urlString stringByAppendingFormat:@"?cf_id=%@", prescriptionId];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete && genneralBackModel.data) {
            MyPointInfoModel *model = [MyPointInfoModel yy_modelWithJSON:genneralBackModel.data];
            complete(model);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

@end
