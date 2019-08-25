//
//  ConsultingView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "PaidConsultingModel.h"
#import "PaySetModel.h"

@interface ConsultingView : BaseTableView

@property (nonatomic, strong) PaySetModel *paySetModel;
@property (nonatomic, strong) PaidConsultingModel *model;
@property (nonatomic, strong) NSArray *patientsArray;
@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
