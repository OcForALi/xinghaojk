//
//  VisitDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "VisitDetailsViewModel.h"

@implementation VisitDetailsViewModel

- (void)getWeekScheduleComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"DrSchedule", @"WeekSchedule"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *weekDict in genneralBackModel.data) {
            
            VisitDetailsModel *model = [VisitDetailsModel new];
            [model setDict:weekDict];
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)drSchedules:(void (^)(NSArray *))complete {
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"drSchedules"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *dataDict = genneralBackModel.data;
        BOOL is_set = [dataDict[@"is_set"] boolValue];
        NSArray *locations = [dataDict valueForKey:@"locations"];
        if (is_set && locations && locations.count > 0) {
            for (NSDictionary *dict in locations) {
                DcScheduleModel *model = [DcScheduleModel new];
                [model setValuesForKeysWithDictionary:dict];
                NSMutableArray *weeks = [[NSMutableArray alloc] init];
                if (model.weeks && model.weeks.count > 0) {
                    for (NSDictionary *week in model.weeks) {
                        DcScheduleWeekModel *weekItem = [DcScheduleWeekModel new];
                        [weekItem setValuesForKeysWithDictionary:week];
                        if (weekItem.items && weekItem.items.count > 0) {
                            NSMutableArray *items = [NSMutableArray arrayWithCapacity:1];
                            for (NSDictionary *obj in weekItem.items) {
                                DcScheduleItemModel *itemModel = [DcScheduleItemModel new];
                                [itemModel setValuesForKeysWithDictionary:obj];
                                [items addObject:itemModel];
                            }
                            weekItem.items = items;
                        }
                        [weeks addObject:weekItem];
                    }
                    model.weeks = weeks;
                }
                [arr addObject:model];
            }
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)saveWeekScheduleWithModel:(NSArray *)details Complete:(void (^)(id))complete {
    
    NSMutableArray *values = [NSMutableArray array];
    for (int i = 0; i < [details[0] count]; i++) {
        
        VisitDetailsModel *model = details[0][i];
        if ([model.amType integerValue] > 0) {
            NSDictionary *amDict = @{ @"week" : model.week,
                                      @"time" : @"上午",
                                      @"clinic_type" : model.amType,
                                      @"location" : model.amHospital };
            [values addObject:amDict];
        }
        
        if ([model.pmType integerValue] > 0) {
            NSDictionary *pmDict = @{ @"week" : model.week,
                                      @"time" : @"下午",
                                      @"clinic_type" : model.pmType,
                                      @"location" : model.pmHospital };
            [values addObject:pmDict];
        }
    }
    
    self.urlString = [self getRequestUrl:@[@"DrSchedule", @"SaveSchedule"]];
    self.parameters = values;
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            
            complete(genneralBackModel.retcode == 0 ? @"保存成功" : genneralBackModel.retmsg);
        }
        
    } failure:nil];
}

- (void)getHelpComplete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"scheduleHelp"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {

        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

@end
