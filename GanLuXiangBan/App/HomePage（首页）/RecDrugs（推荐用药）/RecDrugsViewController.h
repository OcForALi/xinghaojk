//
//  RecDrugsViewController.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "RecDrugsModel.h"
#import "InitialRecipeInfoModel.h"

typedef void(^RecDrugsSaveBlock)(RecDrugsModel *recDrugsModel);

typedef void(^RecDrugSendBlock)(BOOL success);

@interface RecDrugsViewController : BaseViewController

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,retain) RecDrugsModel *model;

@property (nonatomic ,retain) InitialRecipeInfoModel *initialRecipeInfoModel;

@property (nonatomic ,copy) NSString *mid;

@property (nonatomic ,copy) NSString *msgId;

@property (nonatomic ,copy) NSString *msgFlag;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *age;

@property (nonatomic ,copy) NSString *gender;

@property (nonatomic ,copy) NSString *serialNumber;

@property (nonatomic ,copy) NSString *dataString;

@property (nonatomic ,copy) RecDrugsSaveBlock recDrugsSaveBlock;

@property (nonatomic, strong) NSDictionary *recordDatas;

@property (nonatomic, copy) RecDrugSendBlock sendBlock;

@end
