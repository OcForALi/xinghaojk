//
//  PrescriptionView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

#import "PrescriptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrescriptionView : BaseTableView

@property (nonatomic, strong) void(^SelectedPrescriptionBlock)(PrescriptionModel *model);

@end

NS_ASSUME_NONNULL_END
