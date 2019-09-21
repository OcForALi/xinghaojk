//
//  ProductModel.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : BaseModel
///药品编码
@property (nonatomic ,copy) NSString *drugId;
///药品名
@property (nonatomic ,copy) NSString *drugNm;
///通用名
@property (nonatomic ,copy) NSString *commonNm;
///规格
@property (nonatomic ,copy) NSString *spec;
///厂家
@property (nonatomic ,copy) NSString *producer;
///价格
@property (nonatomic ,copy) NSString *price;
///药品图片路径
@property (nonatomic ,copy) NSString *picUrl;
///商品名首字母
@property (nonatomic ,copy) NSString *initils;
///不通过原因(状态为不通过时，该字段才有值)
@property (nonatomic ,copy) NSString *reason;
///申请记录id
@property (nonatomic ,assign) NSInteger appId;

@property (nonatomic ,assign) BOOL noPassBool;
///不通过原因
@property (nonatomic ,copy) NSString *unreason;
///资质上传图片
@property (nonatomic ,copy) NSArray *certs;
///单位
@property (nonatomic ,copy) NSString *unit;

@end

NS_ASSUME_NONNULL_END
