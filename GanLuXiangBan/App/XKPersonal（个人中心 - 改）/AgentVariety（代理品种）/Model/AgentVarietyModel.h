//
//  AgentVarietyModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentVarietyModel : NSObject

/** 药品ID */
@property (nonatomic, strong) NSString *drug_id;
/** 药品名 */
@property (nonatomic, strong) NSString *drug_name;
/** 规格 */
@property (nonatomic, strong) NSString *spec;
/** 厂家 */
@property (nonatomic, strong) NSString *producer;
/** 数量 */
@property (nonatomic, strong) NSString *num;

@end

NS_ASSUME_NONNULL_END
