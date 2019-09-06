//
//  MyPointInfoModel.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyPointInfoModel.h"

@implementation MyPointInfoDrugModel

@end


@implementation MyPointInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"rp_items": MyPointInfoDrugModel.class};
}

@end
