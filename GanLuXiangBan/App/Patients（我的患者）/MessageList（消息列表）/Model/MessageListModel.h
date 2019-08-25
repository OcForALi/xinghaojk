//
//  MessageListModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MessageListModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *pkid;
/// 收件人 0、所有人 1、部分可见 2、部分不可见
@property (nonatomic, strong) NSString *recive_type;
/// 内容
@property (nonatomic, strong) NSString *content;
/// 创建时间
@property (nonatomic, strong) NSString *createtime;
/// 总数量
@property (nonatomic, strong) NSString *total;

@end
