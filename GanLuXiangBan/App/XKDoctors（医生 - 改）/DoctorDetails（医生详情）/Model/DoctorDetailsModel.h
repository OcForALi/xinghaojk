//
//  DoctorDetailsModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoctorDetailsModel : NSObject

/** 医生id */
@property (nonatomic, strong) NSString *drid;
/** 推荐人 */
@property (nonatomic, strong) NSString *refenence_person;
/** 跟进人 */
@property (nonatomic, strong) NSString *follow_up_person;
/** 医生名称 */
@property (nonatomic, strong) NSString *drname;
/** 职称 */
@property (nonatomic, strong) NSString *title;
/** 医院名称 */
@property (nonatomic, strong) NSString *hospital_name;
/** 科室 */
@property (nonatomic, strong) NSString *cust_name;
/** 加入时间 */
@property (nonatomic, strong) NSString *join_date;
/** 联系电话 */
@property (nonatomic, strong) NSString *mobile;

@end

NS_ASSUME_NONNULL_END
