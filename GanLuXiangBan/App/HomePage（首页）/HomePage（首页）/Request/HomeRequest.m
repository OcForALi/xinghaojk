//
//  HomeRequest.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/15.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HomeRequest.h"


@implementation HomeRequest

- (void)getBanner:(void (^)(HttpGeneralBackModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"banner"]];

    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
    }];
    
}

- (void)getIndexInfo:(void (^)(HomeModel *model))complete{
    
    self.urlString = [self getRequestUrl:@[@"Msg", @"IndexInfo"]];
    
    HomeModel *model = [HomeModel new];
    
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        [model setValuesForKeysWithDictionary:generalBackModel.data];
        
        if (complete) {
            complete(model);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(model);
        }
        
    }];
    
}

- (void)postUpdateDrHeadUrl:(NSString *)urlString :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"user", @"updateDrHead"]];
    self.parameters = urlString;
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

- (void)getMsgListLoad_type:(NSString *)Load_type :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Msg", @"MsgList"]];
    self.urlString = [NSString stringWithFormat:@"%@?load_type=%@&pageindex=1&pagesize=10", self.urlString,Load_type];
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}



+ (void)getAssistantList:(void (^)(HttpGeneralBackModel *))complete {
    NSString *user = GetUserDefault(UserID);
    NSString *url = [NSString stringWithFormat:@"http://39.108.140.12:28087/message/getClerkMessageList?doctorId=%@_doc",user];
    [HttpRequest requestBear:GetMode url:url params:nil success:^(id object) {
        if (object && complete) {
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            model.retcode = 0;
            model.data = object;
            complete(model);
        }
    } failure:^(NSError *error) {
        if (complete) {
            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
            model.retcode = 1;
            model.retmsg = error.localizedDescription;
            complete(model);
        }
    }];
}

+ (void)transferDoctor:(HomeAssistantModel *)model complete:(void (^)(HttpGeneralBackModel *))complete {
//    NSString *url = @"http://39.108.140.12:28087/message/transferDoctor";
//    NSDictionary *params = @{@"channelNo":model.ms, @"msgType":msgType, @"receiveId":receiveId, @"senderId":sender, @"type": type, @"patientDescribe":patientDescribe, @"clerkMemo": clerkMemo};
//    [HttpRequest requestBear:PatchMode url:url params:params success:^(id object) {
//        if (object && complete) {
//            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
//            model.retcode = 0;
//            complete(model);
//        }
//    } failure:^(NSError *error) {
//        if (complete) {
//            HttpGeneralBackModel *model = [HttpGeneralBackModel new];
//            model.retcode = 1;
//            model.retmsg = error.localizedDescription;
//            complete(model);
//        }
//    }];
}

- (void)getIsSign:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"isSign"]];

    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {

        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)getUnreadForMyPatient:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Doctor", @"unreadForMyPatient"]];
    
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)getNoticeList:(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"Msg", @"NoticeList"]];
    
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *generalBackModel) {
        
        if (complete) {
            complete(generalBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

- (void)getZeroPushNum:(NSString *)client_id :(void (^)(HttpGeneralBackModel *generalBackModel))complete{
    
    self.urlString = [self getRequestUrl:@[@"MasterData", @"zeroPushNum"]];
    self.urlString = [NSString stringWithFormat:@"%@?client_id=%@", self.urlString,client_id];
    [self requestNotHudWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
    
}

@end
