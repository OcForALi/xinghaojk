//
//  RecipientViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

@interface RecipientViewController : BaseViewController

@property (nonatomic, strong) void (^selectType)(NSInteger index, NSArray *groupIds, NSArray *userIds, NSArray *users, NSString *nameString);

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *groupIds;

@property (nonatomic, strong) NSArray *users;

@end
