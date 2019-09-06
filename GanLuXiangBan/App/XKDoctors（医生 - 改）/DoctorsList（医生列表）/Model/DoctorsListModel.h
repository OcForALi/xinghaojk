//
//  DoctorsListModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoctorsListModel : NSObject

// 医生id
@property (nonatomic, copy) NSString *drid;
// 医生名称
@property (nonatomic, copy) NSString *drname;
// 职称
@property (nonatomic, copy) NSString *title;
// 医院名称
@property (nonatomic, copy) NSString *hospital_name;
// 头像
@property (nonatomic, copy) NSString *head;
// 姓名首字母
@property (nonatomic, copy) NSString *initils;

@end

NS_ASSUME_NONNULL_END
