//
//  GroupEditorViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

@interface GroupEditorViewController : BaseViewController

@property (nonatomic, assign) BOOL pickGroup;

@property (nonatomic, strong) NSArray *pickGroupIdS;

@property (nonatomic, strong) void(^pickerGroupBlock)(NSArray *groups);

@end
