//
//  SubscribeCountModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SubscribeCountModel : BaseModel

/// 预约成功
@property (nonatomic, strong) NSString *success_num;
/// 待处理
@property (nonatomic, strong) NSString *pend_num;
/// 预约失败
@property (nonatomic, strong) NSString *fail_num;

@end
