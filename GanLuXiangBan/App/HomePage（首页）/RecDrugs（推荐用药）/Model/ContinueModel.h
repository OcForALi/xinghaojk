//
//  ContinueModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/21.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface ContinueModel : BaseModel

///临床诊断
@property (nonatomic ,copy) NSString *check_result;
///处方时间
@property (nonatomic ,copy) NSString *createtime;
///用药
@property (nonatomic ,copy) NSArray *items;
///医疗_id
@property (nonatomic ,copy) NSString *medical_id;
///mid
@property (nonatomic ,copy) NSString *mid;
///配方_id
@property (nonatomic ,copy) NSString *recipe_id;

@end
