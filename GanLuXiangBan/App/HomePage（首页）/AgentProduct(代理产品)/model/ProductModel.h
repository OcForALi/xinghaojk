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

@property (nonatomic ,copy) NSString *drugId;
@property (nonatomic ,copy) NSString *drugNm;
@property (nonatomic ,copy) NSString *commonNm;
@property (nonatomic ,copy) NSString *spec;
@property (nonatomic ,copy) NSString *producer;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *picUrl;
@property (nonatomic ,copy) NSString *initils;
@property (nonatomic ,copy) NSString *reason;
@property (nonatomic ,assign) NSInteger appId;

@end

NS_ASSUME_NONNULL_END
