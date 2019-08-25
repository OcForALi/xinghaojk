//
//  PatientsCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientsModel.h"

@interface PatientsCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) PatientsModel *model;

@property (nonatomic, strong) void (^collectBlock)(BOOL isCollect);

@end
