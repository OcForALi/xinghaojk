//
//  GroupEditorViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupEditorViewModel.h"

@implementation GroupEditorViewModel

- (void)getLabelListComplete:(void (^)(NSArray *))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"LabelList"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            GroupEditorModel *model = [GroupEditorModel new];
            [model setValuesForKeysWithDictionary:dict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)saveLabelWithIds:(NSArray *)ids mid:(NSString *)midString complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"SaveLabel"]];
    self.parameters = @{ @"label" : ids,
                         @"mid" : midString };
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"保存成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}


@end
