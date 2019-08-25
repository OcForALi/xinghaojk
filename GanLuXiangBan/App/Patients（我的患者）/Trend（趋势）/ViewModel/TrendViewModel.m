//
//  TrendViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TrendViewModel.h"
#import "TrendModel.h"

@implementation TrendViewModel

- (void)getChkTrend:(NSString *)mid chkTypeId:(NSString *)chkTypeId items:(NSArray *)items complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"chkTrend"]];
    self.parameters = @{ @"mid" : mid,
                         @"chk_type_id" : chkTypeId,
                         @"chk_demo_items" : items };

    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        TrendModel *model = [TrendModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *itemDict in model.items) {
            
            TrendItemsModel *itemModel = [TrendItemsModel new];
            [itemModel setValuesForKeysWithDictionary:itemDict];
            [arr addObject:itemModel];
        }
        
        model.items = arr;
        
        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

@end
