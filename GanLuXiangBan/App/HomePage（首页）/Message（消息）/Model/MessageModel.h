//
//  MessageModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
//对话时间
@property (nonatomic ,copy) NSString *minute;
//对话数组
@property (nonatomic ,copy) NSArray *items;

@end
