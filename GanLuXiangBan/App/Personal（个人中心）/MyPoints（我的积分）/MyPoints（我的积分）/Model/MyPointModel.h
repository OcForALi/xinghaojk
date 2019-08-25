//
//  MyPointModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MyPointModel : BaseModel

/// 可用积分
@property (nonatomic, strong) NSString *AvailableIntegral;
/// 总积分
@property (nonatomic, strong) NSString *integralBalancep;
/// 已提取的积分
@property (nonatomic, strong) NSString *presentIntegral;
/// 在途积分
@property (nonatomic, strong) NSString *ztIntegral;
/// 详情列表
@property (nonatomic, strong) NSArray *detailList;
/// 数量
@property (nonatomic, strong) NSString *total;

@end
