//
//  CertificationViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CertificationViewModel.h"

@implementation CertificationViewModel

- (void)uploadImageWithImgs:(NSData *)imgData complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"uploadImage"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"application/xml", nil];
    
    [manager.requestSerializer setValue:@"text/json" forHTTPHeaderField:@"Accept"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"MyCook"];
    }
    
    
    [manager POST:self.urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imgData name:@"image" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {
            complete(responseObject[@"data"][0][@"Url"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (complete) {
            complete(nil);
        }
        NSLog(@"%@", error);
    }];
}

- (void)getIdtAuthDetailWithComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"user", @"idtAuthDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?drid=%@", self.urlString, GetUserDefault(UserID)];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSDictionary *dataDict = genneralBackModel.data;
        if (complete) {
            complete(dataDict);
        }
        
    } failure:nil];
}

- (void)getDoctorFilesWithComplete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"user", @"doctorFiles"]];
    self.urlString = [NSString stringWithFormat:@"%@?drid=%@", self.urlString, GetUserDefault(UserID)];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel.data);
        }
        
    } failure:nil];
}

- (void)setIdtAuthFilesWithModel:(SubmitCertificationModel *)model complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"user", @"setIdtAuthFiles"]];
    self.parameters = @[[self getParametersWithClass:model]];
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {

        complete(@"成功");
        
    } failure:^(NSError *error) {
        
        complete(@"失败");
    }];
}

- (void)setCertFicateFilesWithModel:(SubmitCertificationModel *)model complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"user", @"setCertFicateFiles"]];
    self.parameters = @[[self getParametersWithClass:model]];
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        complete(@"成功");
        
    } failure:^(NSError *error) {
       
        complete(@"失败");
    }];
}

@end
