//
//  AddDrugUseController.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/5.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"

#import "DrugDosageModel.h"

typedef void(^AddDrugUseBlock)(DrugDosageModel *model);

@interface AddDrugUseController : BaseViewController

@property (nonatomic, assign) NSInteger type;

@property (nonatomic ,strong) DrugDosageModel *model;

@property (nonatomic, strong) AddDrugUseBlock useBlock;

@property (nonatomic, assign) BOOL showOne;

@end
