//
//  QuickReplyModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface QuickReplyModel : BaseModel

///pkid
@property (nonatomic ,copy) NSString *pkid;
///drid
@property (nonatomic ,copy) NSString *drid;
///内容
@property (nonatomic ,copy) NSString *content;
///创建时间
@property (nonatomic ,copy) NSString *createtime;
///delete_flag
@property (nonatomic ,copy) NSString *delete_flag;

@end
