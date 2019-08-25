//
//  PatientListCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientsModel.h"

@interface PatientListCell : UITableViewCell

@property (nonatomic, strong) PatientsModel *model;
/// 选中
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, assign) BOOL showFee;

@end
