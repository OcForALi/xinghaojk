//
//  DrugListModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DrugListModel : BaseModel

//别名
@property (nonatomic ,copy) NSString *common_name;
//药品id
@property (nonatomic ,copy) NSString *drug_id;
//药品名字
@property (nonatomic ,copy) NSString *drug_name;
//收藏 == 0未收藏 （猜测）
@property (nonatomic ,assign) NSInteger fav_id;
//药品图片
@property (nonatomic ,copy) NSString *pic_path;
//药品规格
@property (nonatomic ,copy) NSString *standard;
//药品厂
@property (nonatomic ,copy) NSString *producer;
//药品价格
@property (nonatomic ,copy) NSString *price;
//小六指数
@property (nonatomic ,assign) NSInteger six_rate;

@property (nonatomic ,copy) NSString *drug_code;

@property (nonatomic ,assign) BOOL isSelected;

@property (nonatomic ,assign) BOOL isAdded;

@property (nonatomic ,assign) NSInteger app_id;

@end
