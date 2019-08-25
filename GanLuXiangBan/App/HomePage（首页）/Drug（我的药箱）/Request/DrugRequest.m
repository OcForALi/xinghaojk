//
//  DrugRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugRequest.h"
#import "XmlDrugRequest.h"
#import "NSString+ToJSON.h"

@implementation DrugRequest

- (void)getDrug:(void (^)(HttpGeneralBackModel *model))complete {
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"DrugClass"]];
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

- (void)getSearchDrugClass_id:(NSString *)class_id key:(NSString *)key sort_col:(NSInteger)sort_col is_desc:(BOOL)is_desc pageindex:(NSInteger)pageindex :(void (^)(HttpGeneralBackModel *model))complete{

    self.urlString = [self getRequestUrl:@[@"Drug", @"searchDrug"]];
    
    [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (is_desc == YES) {
       self.urlString = [NSString stringWithFormat:@"%@?class_id=%ld&key=%@&sort_col=%ld&is_desc=true&pageindex=%ld&pagesize=30", self.urlString, [class_id integerValue],key,sort_col,pageindex];
    }else{
        self.urlString = [NSString stringWithFormat:@"%@?class_id=%ld&key=%@&sort_col=%ld&is_desc=false&pageindex=%ld&pagesize=30", self.urlString, [class_id integerValue],key,sort_col,pageindex];
    }
    
    
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


- (void)getDrugDetailDrugID:(NSString *)drugID :(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"DrugDetail"]];
    
    self.urlString = [NSString stringWithFormat:@"%@?drugid=%ld", self.urlString,[drugID integerValue]];
    
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

- (void)getDrFavDrugsclass_id:(NSInteger)class_id Key:(NSString *)key pageindex:(NSInteger)pageindex :(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"DrFavDrugs"]];
    
    self.urlString = [NSString stringWithFormat:@"%@?class_id=%ld&key=%@&pageindex=%ld", self.urlString,class_id,key,pageindex];
    
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

- (void)postFavDrugID:(NSString *)drugid :(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"FavDrug"]];
    
    NSNumber *num =[NSNumber numberWithInt:[drugid intValue]];
    
    self.parameters = @{@"drugid":num};
    
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

- (void)postDelDrFavDrug:(NSArray *)drugids :(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug", @"DelDrFavDrug"]];
   
    self.parameters = @{@"":drugids};
    
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getDrugUseage:(NSString *)drugId complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"Drug/drugUseDosage?drugcode="]];
    self.urlString = [self.urlString stringByAppendingFormat:@"%@",drugId];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            HttpGeneralBackModel *obj = [HttpGeneralBackModel new];
            obj.retcode = 1;
            obj.retmsg = error.localizedDescription;
            complete(obj);
        }
    }];
}

@end
