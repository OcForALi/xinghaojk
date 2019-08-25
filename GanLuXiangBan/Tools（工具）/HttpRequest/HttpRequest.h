//
//  HttpRequest.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpGeneralBackModel.h"

typedef NS_ENUM(NSInteger, RequestMode) {
    GetMode = 0,
    PostMode,
    PatchMode,
    DeleteMode
};

@interface HttpRequest : NSObject

/// UrlString
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) id parameters;

/// 获取parameters
- (NSDictionary *)getParametersWithClass:(id)object;

/// 获取请求Url
- (NSString *)getRequestUrl:(NSArray *)parArr;

/// 开始请求
- (void)requestWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure;

/// 无菊花_请求
- (void)requestNotHudWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure;

/// 系统_请求
- (void)requestSystemWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure;

/**
 生成短连接

 @param url 原链接
 */
- (void)shortUrl:(NSString *)url complete:(void(^)(NSString *shortUrl))complete;

/**
 bear方式请求
 */
+ (void)requestBear:(RequestMode)mode url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id object))success failure:(void (^)(NSError *error))failure;

@end
