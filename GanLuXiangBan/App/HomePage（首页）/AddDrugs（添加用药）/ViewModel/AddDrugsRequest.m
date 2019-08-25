//
//  AddDrugsRequest.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/26.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AddDrugsRequest.h"

@implementation AddDrugsRequest

- (void)getBaseUseInfoList:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/baseUseInfoList"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)saveBaseUseInfo:(BaseUseInfoItem *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/saveBaseUseInfo"]];
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getBaseUseNumList:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/baseUseNumList"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)saveBaseUseNum:(BaseUseNumItem *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/saveBaseUseNum"]];
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getBaseUnitMinList:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/baseUnitMinList"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)saveBaseUnitMin:(BaseUnitMinItem *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/saveBaseUnitMin"]];
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getBaseUseCycleList:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/baseUseCycleList"]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        if (complete) {
            complete(genneralBackModel);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)saveBaseUseCycle:(BaseUseCycleItem *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"MasterData/saveBaseUseCycle"]];
    self.parameters = [self getParametersWithClass:model];
    [self requestWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
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
