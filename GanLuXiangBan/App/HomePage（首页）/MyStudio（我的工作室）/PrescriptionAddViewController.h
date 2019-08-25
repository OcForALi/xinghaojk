//
//  PrescriptionAddViewController.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "RecDrugsModel.h"
#import "InitialRecipeInfoModel.h"

typedef void(^PrescriptionDrugsSaveBlock)(RecDrugsModel *recDrugsModel);

@interface PrescriptionAddViewController : BaseViewController

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,retain) RecDrugsModel *model;

@property (nonatomic ,retain) InitialRecipeInfoModel *initialRecipeInfoModel;

@property (nonatomic ,copy) NSString *mid;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *age;

@property (nonatomic ,copy) NSString *gender;

@property (nonatomic ,copy) NSString *serialNumber;

@property (nonatomic ,copy) NSString *dataString;

@property (nonatomic ,copy) PrescriptionDrugsSaveBlock recDrugsSaveBlock;

@end
