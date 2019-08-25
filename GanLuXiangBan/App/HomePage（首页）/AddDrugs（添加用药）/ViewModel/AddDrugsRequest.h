//
//  AddDrugsRequest.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/26.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

#import "AddDrugsModel.h"

@interface AddDrugsRequest : HttpRequest

/**
 获取用法列表
 */
- (void)getBaseUseInfoList:(void(^)(HttpGeneralBackModel *model))complete;

/**
 保存用法
 */
- (void)saveBaseUseInfo:(BaseUseInfoItem *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 获取用量单位列表
 */
- (void)getBaseUnitMinList:(void(^)(HttpGeneralBackModel *model))complete;

/**
 保存用量单位
 */
- (void)saveBaseUnitMin:(BaseUnitMinItem *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 获取用药周期列表
 */
- (void)getBaseUseCycleList:(void(^)(HttpGeneralBackModel *model))complete;

/**
 保存用药周期
 */
- (void)saveBaseUseCycle:(BaseUseCycleItem *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 获取用量列表
 */
- (void)getBaseUseNumList:(void(^)(HttpGeneralBackModel *model))complete;

/**
 保存用量
 */
- (void)saveBaseUseNum:(BaseUseNumItem *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

@end
