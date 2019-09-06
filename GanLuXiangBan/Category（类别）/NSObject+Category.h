//
//  NSObject+Category.h
//  Oneyes
//
//  Created by 黄锡凯 on 2018/12/1.
//  Copyright © 2018 黄锡凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Category)

/**
 *  打印Log
 */
- (void)log;

/**
 *  获取所有Key
 */
- (NSArray *)getKeys;

/**
 *  Json解析
 *
 *  @param jsonDict 解析字典
 */
- (id)jsonParsingWithDict:(NSDictionary *)jsonDict;

/**
 *  是否不是空字段
 */
- (BOOL)isNoEmpty;

@end

NS_ASSUME_NONNULL_END
