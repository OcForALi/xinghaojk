//
//  VisitDetailsModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "VisitDetailsModel.h"

@implementation VisitDetailsModel

- (void)setDict:(NSDictionary *)dict {
    
    self.week = dict[@"week"];
    
    NSArray *items = dict[@"items"];
    self.amType = items[0][@"clinic_type"];
    self.amHospital = items[0][@"location"];
    self.pmType = items[1][@"clinic_type"];
    self.pmHospital = items[1][@"location"];
}

- (void)setAmType:(NSString *)amType {
    
    _amType = amType;
    if ([amType intValue] == 0 && [self.pmType intValue] == 0) {
        self.isVisits = NO;
    }
    else {
        self.isVisits = YES;
    }
}

- (void)setPmType:(NSString *)pmType {
    
    _pmType = pmType;
    if ([pmType intValue] == 0 && [self.amType intValue] == 0) {
        self.isVisits = NO;
    }
    else {
        self.isVisits = YES;
    }
}

@end



@implementation DcScheduleModel

@end

@implementation DcScheduleWeekModel

@end

@implementation DcScheduleItemModel

@end
