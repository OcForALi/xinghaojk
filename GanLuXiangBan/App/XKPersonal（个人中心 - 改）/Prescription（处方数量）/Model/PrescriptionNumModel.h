//
//  PrescriptionNumModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrescriptionNumModel : NSObject

/** 医生名 */
@property (nonatomic, strong) NSString *dr_name;
/** 医院名 */
@property (nonatomic, strong) NSString *hospital_name;
/** 数量 */
@property (nonatomic, strong) NSString *num;

@end

NS_ASSUME_NONNULL_END
