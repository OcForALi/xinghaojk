//
//  GroupAddModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface GroupAddModel : BaseModel

/// 列表ID
@property (nonatomic, strong) NSString *label;
/// 列表昵称
@property (nonatomic, strong) NSString *label_name;
/// 用户ID
@property (nonatomic, strong) NSString *mid;
/// 头像
@property (nonatomic, strong) NSString *head;
/// 用户名
@property (nonatomic, strong) NSString *patient_name;

@end
