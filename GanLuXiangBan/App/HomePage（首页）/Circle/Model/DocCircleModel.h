//
//  DocCircleModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocCircleLevelBaseModel : NSObject
@property (nonatomic, assign) NSInteger yy_drid;
@property (nonatomic, assign) BOOL is_active;
@property (nonatomic, assign) NSInteger invited_drid;
@property (nonatomic, copy) NSString *invited_drid_name;
@property (nonatomic, strong) NSArray *childs;

@property (nonatomic, assign) BOOL expand;
@end

#pragma mark -

@interface DocCircleFirstLevelModel : DocCircleLevelBaseModel

@end

#pragma mark -

@interface DocCircleSecondLevelModel : DocCircleLevelBaseModel

@end


#pragma mark -

@interface DocCircleOrderModel : NSObject

@property (nonatomic, assign) NSInteger drid;

@property (nonatomic, assign) NSInteger sumOrder;

@property (nonatomic, copy) NSString *drName;

@property (nonatomic, assign) CGFloat sumAmount;

@end


#pragma mark -

@interface DocCircleModel : NSObject

/**
 医生总数量
 */
@property (nonatomic, copy) NSString *sumDoctor;

/**
  达到KPI医生人数
 */
@property (nonatomic, copy) NSString *sumPass;

/**
 医生历史开单总金额
 */
@property (nonatomic, copy) NSString *sumAmount;

/**
 医生历史总开单数
 */
@property (nonatomic, copy) NSString *sumOrder;

/**
 过滤查询之后的医生总数量
 */
@property (nonatomic, assign) NSInteger sumDoctor_query;

/**
 过滤查询之后的医生总开单数
 */
@property (nonatomic, assign) NSInteger sumOrder_query;

/**
 过滤查询之后的医生开单总金额
 */
@property (nonatomic, assign) CGFloat sumAmount_query;

/**
 3层树结构
 */
@property (nonatomic, strong) DocCircleFirstLevelModel *tree_3level;

/**
 受邀医生列表kpi集合
 */
@property (nonatomic, strong) NSArray *dr_kpi_item;

/**
 受邀医生业绩集合
 */
@property (nonatomic, strong) NSArray *dr_order_detail;

@end
