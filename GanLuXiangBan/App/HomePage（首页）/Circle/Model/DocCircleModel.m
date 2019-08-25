//
//  DocCircleModel.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleModel.h"


@implementation DocCircleLevelBaseModel

- (BOOL)expand {
    if (!_expand && self.childs && self.childs.count > 0) {
        _expand = YES;
    }
    return _expand;
}

@end

#pragma mark -

@implementation DocCircleFirstLevelModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"childs": @"child1_tree"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"childs": DocCircleSecondLevelModel.class};
}

@end

#pragma mark -

@implementation DocCircleSecondLevelModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"childs": @"child2_tree"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"childs": DocCircleLevelBaseModel.class};
}

@end


#pragma mark -

@implementation DocCircleOrderModel

@end

#pragma mark -

@implementation DocCircleModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"dr_kpi_item": DocCircleLevelBaseModel.class, @"dr_order_detail": DocCircleOrderModel.class};
}

@end
