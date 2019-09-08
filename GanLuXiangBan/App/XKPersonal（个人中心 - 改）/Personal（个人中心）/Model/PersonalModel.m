//
//  PersonalModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PersonalModel.h"

@implementation PersonalModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        for (NSString *key in [self getKeys]) {
            [self setValue:@"" forKey:key];
        }
    }
    
    return self;
}

@end
