//
//  ChatStateModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/19.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface ChatStateModel : BaseModel
///结束时间
@property (nonatomic ,copy) NSString *endtime;
///0 = 不显示倒计时 1 = 显示倒计时
@property (nonatomic ,copy) NSString *is_closed;
///0 = 聊天没开启 1= 聊天开启中
@property (nonatomic ,copy) NSString *is_start;
///开始时间
@property (nonatomic ,copy) NSString *starttime;


@end
