//
//  PaidConsultingModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PaidConsultingModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *pkid;
/// 类型 1 - 图文， 2 - 电话， 3 - 线下
@property (nonatomic, strong) NSString *visit_type;
/// 备注
@property (nonatomic, strong) NSString *remarks;
/// 支付类型
@property (nonatomic, strong) NSString *pay_type;
/// 价格
@property (nonatomic, strong) NSString *dr_pay_money;
/// 是否免费
@property (nonatomic, assign) BOOL isFree;

@end
