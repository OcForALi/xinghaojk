//
//  CheckListDetailsViewModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListDetailsViewModel.h"
#import "CheckYearModel.h"

@implementation CheckListDetailsViewModel

- (void)getChkTypeListWithChkId:(NSString *)chkId complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"ChkDetail"]];
    self.urlString = [NSString stringWithFormat:@"%@?chk_id=%@", self.urlString, chkId];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        CheckListDetailsModel *model = [CheckListDetailsModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in model.items) {
            
            CheckItemsModel *model = [CheckItemsModel new];
            [model setValuesForKeysWithDictionary:dict];
            [arr addObject:model];
        }
        
        model.items = arr;

        if (complete) {
            complete(model);
        }
        
    } failure:nil];
}

- (void)getChkListByYearWithTypeId:(NSString *)typeId mid:(NSString *)mid complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"ChkListByYear"]];
    self.urlString = [NSString stringWithFormat:@"%@?type_id=%@&mid=%@", self.urlString, typeId, mid];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dataDict in genneralBackModel.data) {
            
            CheckYearModel *model = [CheckYearModel new];
            [model setValuesForKeysWithDictionary:dataDict];
            
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *dict in model.items) {
                
                CheckYearItemsModel *model = [CheckYearItemsModel new];
                [model setValuesForKeysWithDictionary:dict];
                [tempArr addObject:model];
            }
            
            model.items = tempArr;
            [arr addObject:model];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}

- (void)getChkFilesWithGroupid:(NSString *)groupid complete:(void (^)(id))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"ChkFiles"]];
    self.urlString = [NSString stringWithFormat:@"%@?group_id=%@", self.urlString, groupid];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            [arr addObject:dict[@"file_path"]];
        }
        
        if (complete) {
            complete(arr);
        }
        
    } failure:nil];
}
    
- (void)getChkFilesGroup_id:(NSString *)group_id complete:(void (^)(id object))complete {
    
    self.urlString = [self getRequestUrl:@[@"Patient", @"ChkFiles"]];
    self.urlString = [NSString stringWithFormat:@"%@?group_id=%@", self.urlString, group_id];
    
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:nil];
}

- (void)getDemoItems:(NSString *)typeId complete:(void (^)(HttpGeneralBackModel *))complete {
    NSString *url = [NSString stringWithFormat:@"Patient/chkDemoItems?chk_type_id=%@", typeId];
    self.urlString = [self getRequestUrl:@[url]];
    [self requestWithIsGet:YES success:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (complete) {
            complete(genneralBackModel);
        }
        
    } failure:^(NSError *error) {
        
        if (complete) {
            HttpGeneralBackModel *obj = [HttpGeneralBackModel new];
            obj.retcode = 1;
            obj.retmsg = error.localizedDescription;
            complete(obj);
        }
        
    }];
}

@end
