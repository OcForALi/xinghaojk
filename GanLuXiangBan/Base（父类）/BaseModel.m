//
//  BaseModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNumber class]]) {
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterRoundFloor;
        value = [numberFormatter stringFromNumber:value];
        value = [value stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    else if ([value isKindOfClass:[NSNull class]]) {
        value = @"";
    }

    [super setValue:value forKey:key];
}


@end
