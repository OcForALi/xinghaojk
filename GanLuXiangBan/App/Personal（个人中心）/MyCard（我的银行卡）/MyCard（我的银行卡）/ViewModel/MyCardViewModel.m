//
//  MyCardViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyCardViewModel.h"


@implementation MyCardViewModel

- (void)getAllBankComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"banklist"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            [arr addObject:dict[@"bank"]];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)getUserBankListComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"Banklist"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dataDict = genneralBackModel.data[0];
        for (NSDictionary *dict in dataDict[@"items"]) {
            
            MyCardModel *model = [MyCardModel new];
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

- (void)deleteBankWithIds:(NSArray *)ids complete:(void (^)(id object))complete {

    NSString *str = [ids componentsJoinedByString:@","];
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DelBank"]];
    self.parameters = str;
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSLog(@"%zd", genneralBackModel.retcode);
        
        if (complete) {
            complete(@"");
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(error);
        }
    }];
}

- (void)addBankWithCardperson:(NSString *)cardperson
                         bank:(NSString *)bank
                   cardNumber:(NSString *)cardNumber
                     complete:(void (^)(id object))complete
{
    self.urlString = [self getRequestUrl:@[@"Doctor", @"AddBank"]];
    self.parameters = @{ @"card_person" : cardperson,
                         @"bank" : bank,
                         @"card_no" : cardNumber };
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"添加成功" : genneralBackModel.retmsg);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(error);
        }
    }];
}

- (void)setDefaultWithId:(NSString *)idString Complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"SetDefault"]];
//    self.parameters = @{ @"id" : [NSNumber numberWithInteger:[idString integerValue]] };
    self.parameters = idString;
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"设置成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

@end
