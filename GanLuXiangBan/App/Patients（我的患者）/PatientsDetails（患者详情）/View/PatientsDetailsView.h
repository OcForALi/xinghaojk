//
//  PatientsDetailsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "PatientsDetailsModel.h"
#import "PatientInfoViewController.h"
#import "SelectGroupViewController.h"
#import "CheckListViewController.h"
#import "PrescriptionDetailsViewController.h"
#import "TreatmentViewController.h"
#import "PatientsVisitDetailsModel.h"

@interface PatientsDetailsView : BaseTableView

@property (nonatomic, strong) PatientsDetailsModel *model;
@property (nonatomic, strong) void (^goViewControlleBlock)(UIViewController *viewController);

@property (nonatomic, assign) NSInteger unread;

@property (nonatomic, strong) void(^patientsDetailViewImageBlock)(PatientsVisitDetailsModel *model, NSInteger index);

@end
