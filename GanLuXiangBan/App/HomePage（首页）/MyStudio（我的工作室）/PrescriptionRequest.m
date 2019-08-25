//
//  PrescriptionRequest.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "PrescriptionRequest.h"

@implementation PrescriptionRequest

- (void)getCommonRecipelist:(NSInteger)pageNo key:(NSString *)key complete:(void (^)(HttpGeneralBackModel *))complete {
    if (!key) {
        key = @"";
    }
    NSString *url = [NSString stringWithFormat:@"Doctor/CommonRecipelist?pageindex=%@&key=%@&pagesize=10", @(pageNo), key];
    self.urlString = [self getRequestUrl:@[url]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getCommonRecipeDetail:(NSString *)recipeId complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = [NSString stringWithFormat:@"Doctor/CommonRecipeDetail?recipe_id=%@", recipeId];
    self.urlString = [self getRequestUrl:@[url]];
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)postCommonRecipeInfo:(PrescriptionAddModel *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"Doctor", @"AddDrCommonRecipe"]];
    //@"http://39.108.187.219/xhjk_api/api/Doctor/AddDrCommonRecipe";
    self.parameters = [self getParametersWithClass:model];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:self.parameters];
    if (model.drugs && model.drugs.count > 0) {
        NSMutableArray *drugs = [[NSMutableArray alloc] init];
        for (PrescriptionAddDrugModel *drug in model.drugs) {
            NSDictionary *drugDic = [self getParametersWithClass:drug];
            [drugs addObject:drugDic];
        }
        [dict setObject:drugs forKey:@"drugs"];
    }
    
    self.parameters = dict;
    
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)postRecipeMessage:(SendRecipePost *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"PatientMsg", @"sendRecipe"]];
    self.parameters = [self getParametersWithClass:model];
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict addEntriesFromDictionary:self.parameters];
//    if (model.druguse_items && model.druguse_items.count > 0) {
//        NSMutableArray *drugs = [[NSMutableArray alloc] init];
//        for (PrescriptionAddDrugModel *drug in model.druguse_items) {
//            NSDictionary *drugDic = [self getParametersWithClass:drug];
//            [drugs addObject:drugDic];
//        }
//        [dict setObject:drugs forKey:@"druguse_items"];
//    }
    
//    self.parameters = dict;
    
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

@end
