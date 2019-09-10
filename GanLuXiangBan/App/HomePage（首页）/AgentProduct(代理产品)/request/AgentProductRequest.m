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

- (void)postAgentDrugAppAppId:(NSInteger)ID Drug_id:(NSString *)drug_id Drug_name:(NSString *)drug_name Commonname:(NSString *)commonname Producer:(NSString *)producer Spec:(NSString *)spec Form:(NSString *)form Unit:(NSString *)unit Approval:(NSString *)approval Certs:(NSArray *)certs :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Drug",@"AgentDrugApp"]];
    self.parameters = @{
                        @"appId":@(ID),
                        @"drug_id":drug_id,
                        @"drug_name":drug_name,
                        @"commonname":commonname,
                        @"producer":producer,
                        @"spec":spec,
                        @"form":form,
                        @"unit":unit,
                        @"approval":approval,
                        @"certs":certs
                        };
    
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

@end
