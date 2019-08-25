//
//  InitialRecipeInfoModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface InitialRecipeInfoModel : BaseModel

@property (nonatomic ,copy) NSString *mid;

@property (nonatomic ,copy) NSString *medical_id;
///{@"drug_code":@"",@"qty":@""}
@property (nonatomic ,copy) NSArray *drugs;

@end
