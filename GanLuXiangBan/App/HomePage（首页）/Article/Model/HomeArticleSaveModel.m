//
//  HomeArticleSaveModel.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleSaveModel.h"

@implementation HomeArticlePageModel

@end


@implementation HomeArticleSaveModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"PageInfos": @"DrNewsPageInfos"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"PageInfos": HomeArticlePageModel.class};
}

@end
