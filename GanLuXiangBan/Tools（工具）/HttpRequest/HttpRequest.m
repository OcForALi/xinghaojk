//
//  HttpRequest.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "XmlParsing.h"
#import "RootViewController.h"
#import <objc/runtime.h>
#import <MBProgressHUD.h>
#import "NSString+ToJSON.h"

@interface HttpRequest ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation HttpRequest

- (void)shortUrl:(NSString *)url complete:(void (^)(NSString *))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *path = [NSString stringWithFormat:@"http://api.k780.com/",url];
    NSDictionary *param = @{@"app":@"shorturl.set", @"appkey":@"36406", @"sign":@"bb6d0cce003791740c3c81ac7f236e90", @"url":url, @"format":@"json"};
    [manager POST:@"http://api.k780.com/" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && [responseObject valueForKey:@"result"]) {
            NSDictionary *result = responseObject[@"result"];
            NSString *shortUrl = result[@"short_url"];
            if (complete) {
#if DEBUG
                NSLog(@"\n[ORIGIN] %@ \n[SHORT] %@", url, shortUrl);
#endif
                complete(shortUrl);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(nil);
        }
    }];
}

+ (void)requestBear:(RequestMode)mode url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain", @"text/javascript", @"text/json", @"text/html",@"application/xml", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *token = GetUserDefault(Access_Token);
    if (token && token.length > 0) {
        //NSString *token = [NSString stringWithFormat:@"bearer %@",GetUserDefault(Access_Token)];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"authorization"];
        KLog(@"设置authorization：%@", token);
    }
    
    DebugLog(@"urlString = %@\n\n  %@", url, params);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (mode == GetMode) {
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:%@\n", url, params, responseObject);
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:[%@]%@\n", url, params, @(error.code), error.localizedDescription);
            if (failure) {
                failure(error);
            }
            
        }];
    }
    else if (mode == PostMode) {
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:%@\n", url, params, responseObject);
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:[%@]%@\n", url, params, @(error.code), error.localizedDescription);
            if (failure) {
                failure(error);
            }
            
        }];
    }
    else if (mode == PatchMode) {
        [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:%@\n", url, params, responseObject);
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"\n=========== response ===========\n[url]:%@\n[params]:%@\n[res]:[%@]%@\n", url, params, @(error.code), error.localizedDescription);
            if (failure) {
                failure(error);
            }
            
        }];
    }
}

- (NSString *)printRequestData:(id)res {
    if (res && ([res isKindOfClass:NSArray.class] || [res isKindOfClass:NSDictionary.class])) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:res options:NSJSONWritingPrettyPrinted error:&error];
        if (data) {
            NSString *json = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
            if (json) {
                return [NSString stringWithFormat:@"%@", json];
            }
        }
    }
    return [NSString stringWithFormat:@"%@", res];
}

- (NSDictionary *)getParametersWithClass:(id)object {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    unsigned int count = 0;
    objc_property_t *properList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properList[i];
        
        NSString *keyString = [NSString stringWithUTF8String:property_getName(property)];
        
        if ([[object valueForKey:keyString] isKindOfClass:[NSArray class]]) {
            
            NSArray *valueArray = [object valueForKey:keyString];
//            valueString = valueString.length == 0 ? @"" : valueString;

            [parameters setValue:valueArray forKey:keyString];
            
        }else if ([[object valueForKey:keyString] isKindOfClass:[NSNumber class]]){

//            NSString *valueString = [NSString stringWithFormat:@"%@",[object valueForKey:keyString]];
//            [parameters setValue:valueString forKey:keyString];
            NSNumber *number = [object valueForKey:keyString];
            [parameters setValue:number forKey:keyString];
            
        }
        else if (![[object valueForKey:keyString] isKindOfClass:[UIImage class]]) {
            
            NSString *valueString = [object valueForKey:keyString];
            valueString = valueString.length == 0 ? @"" : valueString;
            [parameters setValue:valueString forKey:keyString];
            
        }

    }
    
    free(properList);
    return parameters;
}

- (NSString *)getRequestUrl:(NSArray *)parArr {
    
//#if 1
//
//#else
//    NSString *tempStr =@"http://appitftest.6ewei.com/api";
//#endif
    NSString *tempStr =
    //    @"http://appitf.6ewei.com/api";
    //@"http://appitf.6ewei.com/api";
    //@"http://39.108.187.219/xhjk_api/api";
    @"http://112.74.128.188/Agent/api";
    //@"http://itf.6ewei.com/api";
    for (int i = 0; i < parArr.count; i++) {
        tempStr = [NSString stringWithFormat:@"%@/%@",tempStr,parArr[i]];
    }
    
    return tempStr;
}

- (void)requestWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure {
    
    if ([NavController isKindOfClass:[RootViewController class]]) {
        
        RootViewController *rootVC = (RootViewController *)NavController;
        RTRootNavigationController *navVC = rootVC.selectedViewController;
        if (navVC.visibleViewController) {
            [self showHudAnimated:YES viewController:rootVC];
        }
    }
    
    NSDictionary *parameters = self.parameters;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"application/xml", nil];
    [manager.requestSerializer setValue:@"text/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"AgCook"];
        KLog(@"设置cookie：%@", cookie);
    }
 
    self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DebugLog(@"urlString = %@\n\n  %@", self.urlString, [self printRequestData:parameters]);
    
    if (isGet) {
        
        [manager GET:self.urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            [model setValuesForKeysWithDictionary:responseObject];
            model.responseObject = responseObject;
            
            DebugLog(@"urlString = %@\n\n  %@  retcode = %@  \n\n", self.urlString, [self printRequestData:model.data], @(model.retcode));
            
            if (success) {
                success(model);
            }
            
            // 获取cookie方法
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            
            NSString *AgCook;
            
            NSString *ASPString;
            
            NSString *MyCookString;
            
            for(NSHTTPCookie *cookie in [cookieJar cookies])
            {
                if ([cookie.name isEqualToString:@"AgCook"]) {
                    AgCook = cookie.value;
                }
                
                NSString *string = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
                if (cookie.isHTTPOnly == YES) {
                    ASPString = string;
                }else{
                    MyCookString = string;
                }
            }
            
            NSString *cookie = [NSString stringWithFormat:@"%@",AgCook];
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Set-Cookie"];
            
            [self hideHudAnimatedWithViewController:NavController];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"error = %@\n\n  %@  \n\n", self.urlString, error);
            
            if (error.code == -1001) {
                NSLog(@"请求超时");
            }
            
            if (failure) {
                failure(error);
            }
            
            [self hideHudAnimatedWithViewController:NavController];
        }];
    }
    else {
        [manager POST:self.urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            [model setValuesForKeysWithDictionary:responseObject];
            
            DebugLog(@"urlString = %@\n\n  %@  retcode = %@  \n\n  retmsg = %@  \n\n", self.urlString, [self printRequestData:model.data], @(model.retcode), model.retmsg);
            
            if (success) {
                success(model);
            }
            
            // 获取cookie方法
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            
            NSString *AgCook;
            
            NSString *ASPString;
            
            NSString *MyCookString;
            
            for(NSHTTPCookie *cookie in [cookieJar cookies])
            {
                if ([cookie.name isEqualToString:@"AgCook"]) {
                    AgCook = cookie.value;
                }
                
                NSString *string = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
                if (cookie.isHTTPOnly == YES) {
                    ASPString = string;
                }else{
                    MyCookString = string;
                }
            }
            
            NSString *cookie = [NSString stringWithFormat:@"%@",AgCook];
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Set-Cookie"];
            
            [self hideHudAnimatedWithViewController:NavController];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"error = %@\n\n  %@  \n\n", self.urlString, error);
            
            if (error.code == -1001) {
                NSLog(@"请求超时");
            }
            
            if (failure) {
                failure(error);
            }
            
            [self hideHudAnimatedWithViewController:NavController];
            
        }];
    }
}

- (void)requestNotHudWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure{
    
    NSDictionary *parameters = self.parameters;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"application/xml", nil];
    [manager.requestSerializer setValue:@"text/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"AgCook"];
        KLog(@"设置cookie：%@", cookie);
    }else{
        
        // 获取cookie方法
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        NSString *AgCook;
        
        NSString *ASPString;
        
        NSString *MyCookString;
        
        for(NSHTTPCookie *cookie in [cookieJar cookies])
        {
            if ([cookie.name isEqualToString:@"AgCook"]) {
                AgCook = cookie.value;
            }
            
            NSString *string = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
            if (cookie.isHTTPOnly == YES) {
                ASPString = string;
            }else{
                MyCookString = string;
            }
        }
        
        NSString *cookie = [NSString stringWithFormat:@"%@",AgCook];
        [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Set-Cookie"];
        
    }
    
    self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (isGet) {
        
        DebugLog(@"GETurlString = %@\n\n  %@", self.urlString,parameters);
        
        [manager GET:self.urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (responseObject == nil) {
                return ;
            }
            
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            [model setValuesForKeysWithDictionary:responseObject];
            model.responseObject = responseObject;
            
            DebugLog(@"urlString = %@\n\n  %@  retcode = %@  \n\n", self.urlString, [self printRequestData:model.data], @(model.retcode));
            
            if (success) {
                success(model);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DebugLog(@"error = %@\n\n  %@  \n\n", self.urlString, error);
            
            if (error.code == -1001) {
                NSLog(@"请求超时");
            }
            
            if (failure) {
                failure(error);
            }
            
        }];
    }
    else {
        
        DebugLog(@"POSTurlString = %@\n\n  %@", self.urlString,parameters);
        
        [manager POST:self.urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            [model setValuesForKeysWithDictionary:responseObject];

            DebugLog(@"urlString = %@\n\n  %@  retcode = %@  \n\n", self.urlString, [self printRequestData:model.data], @(model.retcode));
            
            // 获取cookie方法
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            
            NSString *AgCook;
            
            NSString *ASPString;
            
            NSString *MyCookString;
            
            for(NSHTTPCookie *cookie in [cookieJar cookies])
            {
                if ([cookie.name isEqualToString:@"AgCook"]) {
                    AgCook = cookie.value;
                }
                
                NSString *string = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
                if (cookie.isHTTPOnly == YES) {
                    ASPString = string;
                }else{
                    MyCookString = string;
                }
            }
            
            NSString *cookie = [NSString stringWithFormat:@"%@",AgCook];
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Set-Cookie"];
            
            if (success) {
                success(model);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            DebugLog(@"error = %@\n\n  %@  \n\n", self.urlString, error);

            if (error.code == -1001) {
                NSLog(@"请求超时");
            }

            if (failure) {
                failure(error);
            }

        }];
    }
    
}

#pragma mark - 加载
- (void)showHudAnimated:(BOOL)animated viewController:(UIViewController *)viewController {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (UIView *subview in viewController.view.subviews) {
            
            if ([subview isKindOfClass:[MBProgressHUD class]]) {
                return ;
            }
        }
        
        self.hud = [MBProgressHUD showHUDAddedTo:viewController.view animated:animated];
        self.hud.label.text = @"加载中...";
    });
    
}

- (void)requestSystemWithIsGet:(BOOL)isGet success:(void (^)(HttpGeneralBackModel *genneralBackModel))success failure:(void (^)(NSError *error))failure{
    
    DebugLog(@"urlString = %@\n\n  %@", self.urlString, [self printRequestData:self.parameters]);
    
    if (!isGet) {
        
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
        request.HTTPMethod = @"POST";
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"text/json" forHTTPHeaderField:@"Accept"];
        // 如果已有Cookie, 则把你的cookie符上
        NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
        if (cookie != nil) {
            [request setValue:cookie forHTTPHeaderField:@"AgCook"];
            KLog(@"设置cookie：%@", cookie);
        }
        NSString *jsonString = [NSString dictionaryToJSONString:self.parameters];
//        NSRange range = {0, jsonString.length};
//
//        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//        NSRange range2 = {0, mutStr.length};
//
//        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        request.HTTPBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        // 3.获得会话对象
        NSURLSession *session = [NSURLSession sharedSession];
        // 4.根据会话对象，创建一个Task任务
        NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //判断statusCode
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            if (!(res.statusCode == 200 || error)) {
                if (success) {
                    HttpGeneralBackModel *model = [HttpGeneralBackModel new];
                    model.retcode = 1;
                    model.retmsg = @"短信发送失败";
                    success(model);
                }
                return;
            }
            NSLog(@"从服务器获取到数据");
            if (error) {
                KLog(@"error:%@",error.description);
                if (success) {
                    HttpGeneralBackModel *model = [HttpGeneralBackModel new];
                    model.retcode = 1;
                    model.retmsg = error.localizedDescription;
                    success(model);
                }
                return ;
            }
            
            NSError *newError;
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&newError];
            if ([object isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *response = (NSDictionary *)object;
                
                HttpGeneralBackModel *model = [HttpGeneralBackModel new];
                [model setValuesForKeysWithDictionary:response];
                
                DebugLog(@"urlString = %@\n\n  %@  retcode = %@  \n\n", request.URL, [self printRequestData:model.data], @(model.retcode));
                
                if (success) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        success(model);
                    });
                }
            }
        }];

        [sessionDataTask resume];
    }
    
}

- (void)hideHudAnimatedWithViewController:(UIViewController *)viewController {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:viewController.view animated:YES];
    });
    
}

@end
