//
//  MyPrescriptionModel.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPrescriptionModel : BaseModel

@property (nonatomic, copy) NSString *total;//总数
@property (nonatomic, copy) NSString *purchased_count;//已购买
@property (nonatomic, copy) NSString *nopurchase_count;//未购买
@property (nonatomic, copy) NSString *shipped_count;//已发货
@property (nonatomic, copy) NSString *received_count;//已收货
@property (nonatomic, copy) NSString *ineffective_count;//未生效

@end

NS_ASSUME_NONNULL_END
