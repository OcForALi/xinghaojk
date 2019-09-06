//
//  NSObject+Category.m
//  Oneyes
//
//  Created by 黄锡凯 on 2018/12/1.
//  Copyright © 2018 黄锡凯. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

- (void)log {
    
    NSLog(@"=========================== Log ===========================");
    NSLog(@"Class = %@", NSStringFromClass([self class]));
    
    NSArray *keys = [self getKeys];
    for (int i = 0; i < keys.count; i++) {
        NSLog(@"keys = %@, value = %@", keys[i], [self valueForKey:keys[i]]);
    }
    
    NSLog(@"=========================== Log ===========================");
}

- (NSArray *)getKeys {
    
    NSMutableArray *keys = [NSMutableArray array];
    
    Class cls = [self class];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        [keys addObject:[NSString stringWithUTF8String:property_getName(property)]];
    }
    
    return keys;
}

- (id)jsonParsingWithDict:(NSDictionary *)jsonDict {
    
    NSArray *keys = [self getKeys];
    NSArray *dictKeys = [jsonDict allKeys];
    for (int i = 0; i < dictKeys.count; i++) {
        
        if ([jsonDict[dictKeys[i]] isKindOfClass:[NSArray class]]) {}
        else if ([jsonDict[dictKeys[i]] isKindOfClass:[NSDictionary class]]) {
            
            [self jsonParsingWithDict:jsonDict[dictKeys[i]]];
        }
        else if ([jsonDict[dictKeys[i]] isKindOfClass:[NSNull class]]) {
            
            if ([keys containsObject:dictKeys[i]]) {
                [self setValue:@"" forKey:dictKeys[i]];
            }
        }
        else {
            
            if ([keys containsObject:dictKeys[i]]) {
                
                id value = [jsonDict valueForKey:dictKeys[i]];
                if ([value isKindOfClass:[NSNumber class]]) {
                    value = [value stringValue];
                }
                [self setValue:value forKey:dictKeys[i]];
            }
        }
    }

    return self;
}

- (BOOL)isNoEmpty {
    
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if ([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        return [str length] > 0;
    }
    else if ([self isKindOfClass:[NSData class]]) {
        return [(NSData *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self count] > 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)self count] > 0;
    }
    
    return YES;
}

@end
