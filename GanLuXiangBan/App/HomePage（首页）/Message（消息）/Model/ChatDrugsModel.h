//
//  ChatDrugsModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface ChatDrugsModel : BaseModel
//别名
@property (nonatomic ,copy) NSString *common_name;
//科室
@property (nonatomic ,copy) NSString *drug_class;
//药品code
@property (nonatomic ,copy) NSString *drug_code;
//药品名称
@property (nonatomic ,copy) NSString *drug_name;
//mid
@property (nonatomic ,copy) NSString *mid;
//数量
@property (nonatomic ,copy) NSString *qty;
//规格，标准
@property (nonatomic ,copy) NSString *standard;

@property (nonatomic ,copy) NSString *status;

@end
