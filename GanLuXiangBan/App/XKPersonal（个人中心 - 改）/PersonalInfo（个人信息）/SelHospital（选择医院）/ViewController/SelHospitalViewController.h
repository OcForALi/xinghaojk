//
//  SelHospitalViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

@interface SelHospitalViewController : BaseViewController

/**
 *  完成，返回包含 HospitalModel 数组
 */
@property (nonatomic, strong) void (^hospitalListBlock)(NSArray *list);

@end
