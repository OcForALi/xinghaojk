//
//  ContinuePrescriptionTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/21.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContinueModel.h"

@interface ContinuePrescriptionTableViewCell : UITableViewCell

@property (nonatomic ,copy) ContinueModel *model;

@property (nonatomic ,strong) UIView *BGView;

@property (nonatomic ,strong) UILabel *RPLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *check_result;

@property (nonatomic ,strong) UILabel *OKLabel;

@end
