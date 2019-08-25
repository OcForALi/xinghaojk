//
//  RecDrugsRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecDrugsRequest.h"
#import "NSString+ToJSON.h"
@implementation RecDrugsRequest


-(void)getInitialTmpRecipecomplete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"initialTmpRecipe"]];
    
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

-(void)getInitialRecipeInfo:(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"InitialRecipeInfo"]];
    
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

-(void)getXufangItemsMid:(NSString *)mid key:(NSString *)key paegNo:(NSInteger)pageNo complete:(void (^)(HttpGeneralBackModel *))complete {
    
    if (!key) {
        key = @"";
    }
    if (!mid) {
        mid = @"0";
    }
    //@"http://39.108.187.219/xhjk_api/api/Doctor/xufangItems";/
    self.urlString = [self getRequestUrl:@[@"Doctor", @"xufangItems"]];
    self.urlString = [NSString stringWithFormat:@"%@?mid=%@&key=%@&pageindex=%@&pagesize=20", self.urlString,mid, key, @(pageNo)];
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

-(void)postSaveTmpRecipe:(RecDrugsModel *)model :(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"saveTmpRecipe"]];
    self.parameters = [self getParametersWithClass:model];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict addEntriesFromDictionary:self.parameters];
    
    NSArray *array = [self.parameters allKeys];
    
    for (int i = 0; i < array.count; i++) {
        
        NSString *string = array[i];
        
        if ([string isEqualToString:@"druguse_items"]) {
            
            [dict setObject:model.druguse_items forKey:@"druguse_items"];
            
        }
        
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

-(void)postInitialRecipeInfo:(InitialRecipeInfoModel *)model :(void (^)(HttpGeneralBackModel *genneralBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"InitialRecipeInfo"]];
    self.parameters = [self getParametersWithClass:model];
//    self.parameters = @{@"mid":@"3391",@"medical_id":@"62306",@"drugs":@[@{@"drug_code":@"1002107",@"qty":@"1"}]};
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

-(void)getRecipeDruguse:(NSString *)mid recipeId:(NSString *)recipeId checkId:(NSString *)checkId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"recipeDruguse"]];
    self.urlString = [NSString stringWithFormat:@"%@?mid=%@&recipeid=%@&check_id=%@", self.urlString, mid, recipeId, checkId];
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

@end
