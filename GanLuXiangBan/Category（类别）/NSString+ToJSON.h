//
//  NSString+ToJSON.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToJSON)

+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;

+ (NSString *)arrayToJSONString:(NSArray *)array;

- (BOOL)stringIsNull;

@end
