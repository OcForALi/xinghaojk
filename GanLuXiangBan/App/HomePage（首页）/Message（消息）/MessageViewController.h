//
//  MessageViewController.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageViewController : BaseViewController

@property (nonatomic ,copy) NSString *mid;

@property (nonatomic ,copy) NSString *msg_flag;

@property (nonatomic ,copy) NSString *msg_source;

@property (nonatomic ,copy) NSString *msgId;

@property (nonatomic ,copy) NSString *patientName;

@property (nonatomic ,copy) NSString *patientGender;

@property (nonatomic ,copy) NSString *patientAge;

@end
