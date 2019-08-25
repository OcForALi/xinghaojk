//
//  MyGiftModel.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyGiftModel : BaseModel
@property (nonatomic, copy) NSString *patient_head;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *patient_name;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *typestr;
@end


@interface MyGiftStaticModel : BaseModel
@property (nonatomic, assign) NSInteger mind_count;
@property (nonatomic, assign) NSInteger flower_count;
@property (nonatomic, assign) NSInteger pennant_count;
@end

NS_ASSUME_NONNULL_END
