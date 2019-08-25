//
//  NSString+ToJSON.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "NSString+ToJSON.h"

@implementation NSString (ToJSON)

+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary

{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}

+ (NSString *)arrayToJSONString:(NSArray *)array{

    NSError *error = nil;
//        NSMutableArray *muArray = [NSMutableArray array];
//        for (NSString *userId in array) {
//            [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
//        }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
//        NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}

- (BOOL)stringIsNull {
    return !self || [self isKindOfClass:NSNull.class] || self.length == 0;
}

@end
