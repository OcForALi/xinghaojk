//
//  PersonalModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalModel : NSObject

/** 医生数 */
@property (nonatomic, strong) NSString *dr_num;
/** 开单金额 */
@property (nonatomic, strong) NSString *order_amount;
/** 代理品种数 */
@property (nonatomic, strong) NSString *drug_num;
/** 处方数 */
@property (nonatomic, strong) NSString *recipe_num;

/** 可用积分 */
@property (nonatomic, strong) NSString *integral;
/** 总积分 */
@property (nonatomic, strong) NSString *totalIntegral;

@end

NS_ASSUME_NONNULL_END
