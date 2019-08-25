//
//  TrendModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface TrendItemsModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *chk_demo_id;
/// 类型名
@property (nonatomic, strong) NSString *chk_demo_name;
/// 数组
@property (nonatomic, strong) NSArray *chk_values;

@end

@interface TrendModel : BaseModel

@property (nonatomic, strong) NSArray *dates;
@property (nonatomic, strong) NSArray *items;

@end
