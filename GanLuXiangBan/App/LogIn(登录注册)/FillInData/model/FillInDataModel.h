//
//  fillInDataModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface FillInDataModel : BaseModel

@property (nonatomic ,copy) NSString *titleName;

@property (nonatomic ,copy) NSString *messageString;

@property (nonatomic ,copy) NSString *valueId;

@property (nonatomic ,copy) NSString *placeholderString;

@end
