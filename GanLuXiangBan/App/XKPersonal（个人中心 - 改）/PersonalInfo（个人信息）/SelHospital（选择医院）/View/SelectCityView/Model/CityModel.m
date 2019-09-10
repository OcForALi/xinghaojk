//
//  CityModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        for (NSString *key in [self getKeys]) {
            [self setValue:@"" forKey:key];
        }
    }
    
    return self;
}

- (void)setModelWithDict:(NSDictionary *)dict {
    
    self.name = [dict objectForKey:@"n"];
    self.cityId = [dict objectForKey:@"v"];
    
    for (NSString *key in [self getKeys]) {
        
        if ([[self valueForKey:key] length] == 0) {
            [self setValue:@"" forKey:key];
        }
    }
}

@end
