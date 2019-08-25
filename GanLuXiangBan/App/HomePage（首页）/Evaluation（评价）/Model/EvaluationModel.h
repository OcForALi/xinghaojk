//
//  EvaluationModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface EvaluationModel : BaseModel
///内容
@property (nonatomic ,copy) NSString *content;
///评价时间
@property (nonatomic ,copy) NSString *createtime;
///id
@property (nonatomic ,copy) NSString *id;
///mid
@property (nonatomic ,copy) NSString *mid;
///病人头像
@property (nonatomic ,copy) NSString *patient_head;
///病人名字
@property (nonatomic ,copy) NSString *patient_name;
///评分
@property (nonatomic ,copy) NSString *score;
///赞赏 0 = 否 1 = 赞赏
@property (nonatomic ,assign) NSInteger is_zs;
///不知道干嘛用的
@property (nonatomic ,copy) NSString *zs_points;


@end
