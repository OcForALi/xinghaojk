//
//  AddDrugsModel.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/26.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddDrugsModel : BaseModel

@end


#pragma mark -

@interface BaseUseModel : BaseModel
@property (nonatomic, assign) BOOL check;
@end


#pragma mark -

@interface BaseUseInfoItem : BaseUseModel
@property (nonatomic, copy) NSString *pkid;
@property (nonatomic, copy) NSString *use_name;
@end

#pragma mark -

@interface BaseUnitMinItem : BaseUseModel
@property (nonatomic, copy) NSString *pkid;
@property (nonatomic, copy) NSString *minunitname;
@end

#pragma mark -

@interface BaseUseCycleItem : BaseUseModel
@property (nonatomic, copy) NSString *pkid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *days;
@end

#pragma mark -

@interface BaseUseNumItem : BaseUseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *use_num_name;//用量名称 例如:一天一次
@property (nonatomic, copy) NSString *frequency_num;//周期数（每X天Y次的X）
@property (nonatomic, copy) NSString *frequency_cycle;//频次周期（小时、天、星期、月）
@property (nonatomic, copy) NSString *frequency;//频次（每X天Y次的Y）
@end


#pragma mark -

@interface BaseUseDuring : BaseUseModel
@property (nonatomic, copy) NSString *name;
@end


NS_ASSUME_NONNULL_END
