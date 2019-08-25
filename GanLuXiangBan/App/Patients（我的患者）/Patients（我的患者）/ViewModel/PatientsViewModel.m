//
//  PatientsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsViewModel.h"

@implementation PatientsViewModel

- (void)getDrPatientWithIds:(NSArray *)Ids complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DrPatient"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *dataArr = genneralBackModel.data;
        for (NSDictionary *dataDict in dataArr) {
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *itmeDict in dataDict[@"items"]) {
                
                PatientsModel *model = [PatientsModel new];
                [model setValuesForKeysWithDictionary:itmeDict];
                
                for (int i = 0; i < Ids.count; i++) {
                    
                    if ([model.mid isEqualToString:Ids[i]]) {
                        model.isSelect = YES;
                    }
                }
                
                [arr addObject:model];
            }
            
            [dict setObject:arr forKey:dataDict[@"initils"]];
        }
        
        if (complete) {
            complete(dict);
        }
        
    } failure:nil];
}

- (void)setAttentionWithMid:(NSString *)mid isAttention:(BOOL)isAttention Complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"setAttention"]];
    
    if (isAttention == YES) {
        self.parameters = @{ @"mid" : mid, @"is_attention" : @"true"};
    }else{
        self.parameters = @{ @"mid" : mid, @"is_attention" : @"false"};
    }

    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"设置成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

@end
