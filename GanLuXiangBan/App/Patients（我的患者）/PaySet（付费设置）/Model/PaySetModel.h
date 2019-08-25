//
//  PaySetModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PaySetModel : BaseModel

@property (nonatomic, strong) NSString *visit_type;
// 0 未开通
@property (nonatomic, strong) NSString *is_open;
@property (nonatomic, strong) NSString *pay_money;

@property (nonatomic, assign) NSInteger index;

@end
