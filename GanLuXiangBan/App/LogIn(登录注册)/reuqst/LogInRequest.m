//
//  LonInRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "LogInRequest.h"

@implementation LogInRequest

- (void)getLogInfoWithloginname:(NSString *)loginname loginpwd:(NSString *)loginpwd complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"Login"]];
    self.urlString = [NSString stringWithFormat:@"%@?loginname=%@&loginpwd=%@", self.urlString, loginname,loginpwd];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getBearToken {
    NSString *url = @"http://39.108.140.12:18080/oauth/token?grant_type=client_credentials&client_id=yynanke&client_secret=Nk13413B0";
    [HttpRequest requestBear:PostMode url:url params:nil success:^(id object) {
        if (object) {
            NSDictionary *dict = object;
            if (dict) {
                NSString *token = dict[@"access_token"];
                NSString *token_type = dict[@"token_type"];
                token = [NSString stringWithFormat:@"%@ %@", token_type, token];
                if (token) {
                    SetUserDefault(Access_Token, token);
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)postSaveClientCid:(NSString *)cid complete:(void (^)(LogInModel *))complete {
    
    self.urlString = [self getRequestUrl:@[@"user/SaveClient"]];
    self.parameters = @{@"cid":cid,@"device_type":[NSNumber numberWithInteger:2]};
    LogInModel *logInModel = [LogInModel new];
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *model) {
        
        [logInModel setValuesForKeysWithDictionary:model.data];
        
        if (complete) {
            complete(logInModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(logInModel);
        }
    }];
    
}

- (void)getClientInfoComplete:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"ClientInfo"]];
    
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *model) {
        
        if (complete) {
            complete(model);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getCaptchaWithmobileno:(NSString *)mobileno type:(NSInteger)type complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete{

    self.urlString = [self getRequestUrl:@[@"user", @"GetMobileCode"]];
    self.urlString = [NSString stringWithFormat:@"%@?mobileno=%@", self.urlString, mobileno];

    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getMasterDataCaptchaWithmobileno:(NSString *)mobileno type:(NSInteger)type complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"GetMobileCode"]];
    self.urlString = [NSString stringWithFormat:@"%@?mobileno=%@&type=%ld", self.urlString, mobileno,type];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)postLogOnWithMobileNo:(NSString *)MobileNo Password:(NSString *)Password Code:(NSString *)Code complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"register"]];
    self.parameters = @{@"MobileNo":MobileNo,@"Password":Password,@"Code":Code};
    
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

-(void)postSaveBasicInfo:(FillInDataRequestModel *)model complete:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"saveBasicInfo"]];
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)postForgetPwdMobileNo:(NSString *)MobileNo Password:(NSString *)Password Code:(NSString *)Code complete:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"forgetPwd"]];
    self.parameters = @{@"MobileNo":MobileNo,@"Password":Password,@"Code":Code};
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getProtocolComplete:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"protocol"]];

    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getVersionUpdateInfoComplete:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"versionUpdateInfo"]];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

@end


