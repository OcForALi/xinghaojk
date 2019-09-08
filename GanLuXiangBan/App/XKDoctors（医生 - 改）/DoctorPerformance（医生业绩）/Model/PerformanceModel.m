//
//  PerformanceModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PerformanceModel.h"

@implementation PerformanceModel

- (id)jsonParsingWithDict:(NSDictionary *)jsonDict {
    
    [super jsonParsingWithDict:jsonDict];
    
    if (![jsonDict[@"drug_items"] isKindOfClass:[NSNull class]]) {
        
        NSMutableArray *drugModels = [NSMutableArray array];
        for (NSDictionary *dict in jsonDict[@"drug_items"]) {
            
            PerformanceDrugsModel *model = [PerformanceDrugsModel new];
            [model jsonParsingWithDict:dict];
            [drugModels addObject:model];
        }
        self.drugModels = drugModels;
    }
    
    if (![jsonDict[@"recipe_items"] isKindOfClass:[NSNull class]]) {
        
        NSMutableArray *recipeModels = [NSMutableArray array];
        for (NSDictionary *dict in jsonDict[@"recipe_items"]) {
            
            PerformanceRecipesModel *model = [PerformanceRecipesModel new];
            [model jsonParsingWithDict:dict];
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *drugsDict in dict[@"drugs"]) {
                
                PerformanceDrugsModel *model = [PerformanceDrugsModel new];
                [model jsonParsingWithDict:drugsDict];
                [arr addObject:model];
            }
            
            model.drugModels = arr;
            [recipeModels addObject:model];
        }
        self.recipeModels = recipeModels;

    }
    
    return self;
}

@end

@implementation PerformanceDrugsModel

@end

@implementation PerformanceRecipesModel

@end
