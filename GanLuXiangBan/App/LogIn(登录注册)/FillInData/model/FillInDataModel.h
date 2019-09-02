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
//城市ID
@property (nonatomic ,copy) NSString *cityID;
//身份ID
@property (nonatomic ,copy) NSString *provinceID;

@end
