//
//  DrugDetailModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DrugDetailModel : BaseModel
///药品名字
@property (nonatomic ,copy) NSString *drug_name;
///单价
@property (nonatomic ,copy) NSString *price;
///数量
@property (nonatomic ,assign) NSInteger qty;
///规格
@property (nonatomic ,copy) NSString *standard;
///小六指数
@property (nonatomic ,assign) NSInteger six_rate;

@end
