//
//  HomeArticleRequest.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleRequest.h"

@implementation HomeArticleRequest

- (void)articles:(NSInteger)status pageNo:(NSInteger)pageNo word:(NSString *)word complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = [self getRequestUrl:@[@"news/NewsList"]];
    self.urlString = [NSString stringWithFormat:@"%@?NewsTitle=%@&status=%@&pageindex=%@&pagesize=10", url, word, @(status), @(pageNo)];
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

- (void)detail:(NSInteger)articleId complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = [NSString stringWithFormat:@"news/NewsDetail?pid=%@", @(articleId)];
    self.urlString = [self getRequestUrl:@[url]];
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

- (void)save:(HomeArticleSaveModel *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = model.pkid > 0 ? @"news/saveNewsPage" : @"news/AddNews";
    self.urlString = [self getRequestUrl:@[url]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[NSNumber numberWithInteger:model.pkid] forKey:@"pkid"];
    [param setObject:model.NewsTitle forKey:@"NewsTitle"];
    [param setObject:model.Tags forKey:@"Tags"];
    if (!model.Content) {
        model.Content = @"";
    }
    [param setObject:model.Content forKey:@"Content"];
    NSString *docId = [NSString stringWithFormat:@"%@",GetUserDefault(UserID)];
    [param setObject:docId forKey:@"drid"];
    if (!model.NewsSTitle) {
        model.NewsSTitle = @"";
    }
    [param setObject:model.NewsSTitle forKey:@"NewsSTitle"];
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (model.PageInfos && model.PageInfos.count > 0) {
        NSInteger num = 1;
        for (HomeArticlePageModel *page in model.PageInfos) {
            NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
            if (page.drnews_id > 0) {
                [json setObject:[NSNumber numberWithInteger:page.drnews_id] forKey:@"drnews_id"];
            }
            else if (model.pkid > 0) {
                [json setObject:[NSNumber numberWithInteger:model.pkid] forKey:@"drnews_id"];
            }
            if (page.content) {
                [json setObject:page.content forKey:@"content"];
            }
            else if (page.file_path) {
                [json setObject:page.file_path forKey:@"file_path"];
            }
            [json setObject:[NSNumber numberWithInteger:num] forKey:@"number"];
            [list addObject:json];
            
            num++;
        }
    }
    [param setObject:list forKey:@"DrNewsPageInfos"];
    
    self.parameters = param;
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

- (void)update:(HomeArticleSaveModel *)model complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"news/saveNewsPage"]];
    NSDictionary *dic = [self getParametersWithClass:model];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (model.PageInfos && model.PageInfos.count > 0) {
        for (HomeArticlePageModel *page in model.PageInfos) {
            NSDictionary *json = [self getParametersWithClass:page];
            [list addObject:json];
        }
    }
    [param setObject:list forKey:@"PageInfos"];
    
    self.parameters = param;
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            complete(nil);
        }
        
    }];
}

- (void)publish:(NSInteger)articleId complete:(void (^)(HttpGeneralBackModel *))complete {
    self.parameters = @{@"news_id": [NSNumber numberWithInteger:articleId]};
    self.urlString = [self getRequestUrl:@[@"news/publishNews"]];
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

- (void)remove:(NSInteger)articleId complete:(void (^)(HttpGeneralBackModel *))complete {
//    self.parameters = @{@"news_id": [NSNumber numberWithInteger:articleId]};
    NSString *url = [NSString stringWithFormat:@"news/delNews?news_id=%@",@(articleId)];
    self.urlString = [self getRequestUrl:@[url]];
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

- (void)patientCount:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"news/getDrPatient"]];
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

- (void)send:(NSInteger)articleId type:(NSInteger)type label:(NSArray *)label mids:(NSArray *)mids attention:(BOOL)attention complete:(void (^)(HttpGeneralBackModel *))complete {
    self.urlString = [self getRequestUrl:@[@"news/SendDrNewsNotice"]];
    if (!label) {
        label = @[];
    }
    if (!mids) {
        mids = @[];
    }
    self.parameters = @{@"news_id": [NSNumber numberWithInteger:articleId], @"is_attention": [NSNumber numberWithBool:attention], @"mids": mids, @"label": label, @"recive_type": [NSNumber numberWithInteger:type]};
    [self requestSystemWithIsGet:NO success:^(HttpGeneralBackModel *genneralBackModel) {
        
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
