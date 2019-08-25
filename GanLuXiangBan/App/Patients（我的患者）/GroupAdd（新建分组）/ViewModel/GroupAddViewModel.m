//
//  GroupAddViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupAddViewModel.h"
#import "NSString+ToJSON.h"

@implementation GroupAddViewModel

- (void)getLabelLabelDetailWithId:(NSString *)idString complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"LabelDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?label=%@", self.urlString, idString];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dict = genneralBackModel.data;
        NSArray *patients = dict[@"patients"];
        if (![patients isKindOfClass:[NSNull class]]) {
            
            for (NSDictionary *patientsDic in patients) {
                
                GroupAddModel *model = [GroupAddModel new];
                model.label = dict[@"label"];
                model.label_name = dict[@"label_name"];
                [model setValuesForKeysWithDictionary:patientsDic];
                [arr addObject:model];
            }
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)savePatientLabelWithAddIds:(NSArray *)addIds delIds:(NSArray *)delIds moedl:(GroupAddModel *)model complete:(void (^)(id))complete {

    self.urlString = [self getRequestUrl:@[@"Doctor", @"SavePatientLabel"]];
    self.parameters = @{ @"label" : model.label,
                         @"label_name" : model.label_name,
                         @"del_patients" : delIds,
                         @"add_patients" : addIds };
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {

        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"保存成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)addLabelWithAddIds:(NSArray *)addIds name:(NSString *)nameString complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"AddLabel"]];
    self.parameters = @{ @"label_name" : nameString,
                         @"mids" : addIds };
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"添加成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)delPatientLabelWithId:(NSString *)idString complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"DelPatientLabel"]];
    self.parameters = @{ @"label" : idString};
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.retcode == 0 ? @"删除成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

@end
