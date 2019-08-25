//
//  MyPrescriptionView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"

#import "MedicalRecordsModel.h"

typedef void(^PushBlock)(MedicalRecordsModel *model);

@interface MyPrescriptionView : BaseTableView

@property (nonatomic ,copy) PushBlock pushBlock;

@end
