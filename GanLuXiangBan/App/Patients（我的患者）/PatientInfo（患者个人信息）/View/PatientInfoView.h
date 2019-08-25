//
//  PatientInfoView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "PatientsDetailsModel.h"

@interface PatientInfoView : BaseTableView

@property (nonatomic, strong) PatientsDetailsModel *model;
@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);

@end
