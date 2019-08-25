//
//  HttpGeneralBackModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface HttpGeneralBackModel : BaseModel

@property (nonatomic, copy) NSString *retmsg;

@property (nonatomic, assign) NSInteger retcode;

@property (nonatomic, copy) NSString *pageinfo;

@property (nonatomic, copy) id data;

@property (nonatomic, copy) id responseObject;

@property (nonatomic ,copy) NSError *error;

@end
