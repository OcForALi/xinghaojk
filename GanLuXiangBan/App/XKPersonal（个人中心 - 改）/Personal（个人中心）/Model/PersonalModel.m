//
//  PersonalModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PersonalModel.h"

@implementation PersonalModel

- (id)jsonParsingWithDict:(NSDictionary *)jsonDict {
    
    [super jsonParsingWithDict:jsonDict];
    
    for (NSString *key in [self getKeys]) {
        
        NSString *value = [self valueForKey:key];
        if (value == 0) {
            [self setValue:@"0" forKey:key];
        }
    }
    
    return self;
}

- (void)setIntegral:(NSString *)integral {
    
    if (integral.length == 0) {
        
        _integral = @"0";
        return;
    }
    
    _integral = integral;
}

- (void)setTotalIntegral:(NSString *)totalIntegral {
    
    if (totalIntegral.length == 0) {
        
        _totalIntegral = @"0";
        return;
    }
    
    _totalIntegral = totalIntegral;
}

@end
