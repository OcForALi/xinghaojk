//
//  ScheduleTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

@interface ScheduleTableViewCell : UITableViewCell

@property (nonatomic ,copy) ScheduleModel *model;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *statusLabel;

@end
