//
//  DrugDetails.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DrugDetailsModel : BaseModel

//批准文号
@property (nonatomic ,copy) NSString *auth_no;
//注意事项
@property (nonatomic ,copy) NSString *attentions;
//不良反应
@property (nonatomic ,copy) NSString *advers_reaction;
//形状
@property (nonatomic ,copy) NSString *character;
//药品说明书
@property (nonatomic ,copy) NSString *instructions;
//成分
@property (nonatomic ,copy) NSString *chengfen;
//别名
@property (nonatomic ,copy) NSString *common_name;
//药品id
@property (nonatomic ,copy) NSString *drug_id;
//药品名字
@property (nonatomic ,copy) NSString *drug_name;
//剂型
@property (nonatomic ,copy) NSString *dosage_form;
//药物相互作用
@property (nonatomic ,copy) NSString *drug_interation;
//药物毒理
@property (nonatomic ,copy) NSString *drug_toxicology;
//药品规格
@property (nonatomic ,copy) NSString *standard;
//药品厂
@property (nonatomic ,copy) NSString *producer;
//贮藏
@property (nonatomic ,copy) NSString *storage;
//是否处方药 0 = 不是
@property (nonatomic ,assign) NSInteger ischufang;
//是否收藏 0 = 没收藏
@property (nonatomic ,assign) NSInteger is_fav;
//禁忌
@property (nonatomic ,copy) NSString *fortbits;
//价格
@property (nonatomic ,copy) NSString *indication;
//轮播图
@property (nonatomic ,copy) NSArray *files;

@end
