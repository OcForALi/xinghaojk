//
//  PrescriptionInfoCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrescriptionDetailsModel.h"

@interface PrescriptionInfoCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) PrescriptionDetailsModel *model;

@end
