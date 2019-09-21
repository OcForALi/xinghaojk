//
//  AgentProductRequest.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentProductRequest.h"



@implementation AgentProductRequest

- (void)getAgDrugLstStart:(NSInteger)status Page:(NSInteger)page size:(NSInteger)size :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
   
    self.urlString = [self getRequestUrl:@[@"Drug",@"AgDrugLst"]];
    
    self.urlString = [NSString stringWithFormat:@"%@?status=%ld&page=%ld&size=%ld", self.urlString,status,page,size];
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

- (void)postAgentDrug:(DrugListModel*)model :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug",@"AgentDrugApp"]];
    if (model.unit == nil) {
        model.unit = @"";
    }
    self.parameters = [self getParametersWithClass:model];
    
    [self requestNotHudWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)getAgDrugAppDetailAppID:(NSInteger)appId :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug",@"AgDrugAppDetail"]];
    
    self.urlString = [NSString stringWithFormat:@"%@?appId=%ld", self.urlString,appId];
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

- (void)postReAppDrugAgent:(ProductModel*)model :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug",@"ReAppDrugAgent"]];
    if (model.unit == nil) {
        model.unit = @"";
    }
    self.parameters = [self getParametersWithClass:model];
    
    [self requestNotHudWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
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
