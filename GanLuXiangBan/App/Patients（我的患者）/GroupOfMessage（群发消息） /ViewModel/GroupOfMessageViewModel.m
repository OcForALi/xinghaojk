//
//  GroupOfMessageViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupOfMessageViewModel.h"

@implementation GroupOfMessageViewModel

- (void)sendMessageWithContent:(NSString *)content reciveType:(GroupMessageReceiveType)reciveType labels:(NSArray *)labels mids:(NSArray *)mids isAttention:(BOOL)isAttention complete:(void (^)(NSInteger, NSString *))complete
{
    if (!mids) {
        mids = @[];
    }
    if (!labels) {
        labels = @[];
    }
    
    self.urlString = [self getRequestUrl:@[@"PatientMsg", @"SendDrNotice"]];
    
    self.parameters = @{ @"content" : content,
                         @"recive_type" : [NSNumber numberWithInteger:reciveType],
                         @"label" : labels,
                         @"mids" : mids,
                         @"is_attention" : [NSNumber numberWithBool:isAttention]};
    
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode, genneralBackModel.retmsg);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(error.code, error.localizedDescription);
        }
        
    }];
}

- (void)getCountComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DrNoticeSendCount"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSDictionary *dict = @{@"count" : genneralBackModel.data[@"send_count"], @"total" : genneralBackModel.data[@"total"]};
        if (complete) {
            complete(dict);
        }
        
    } failure:nil];
}

@end
