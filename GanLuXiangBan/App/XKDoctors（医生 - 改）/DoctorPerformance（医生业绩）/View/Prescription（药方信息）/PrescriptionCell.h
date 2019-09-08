//
//  PrescriptionCell.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrescriptionCell : UITableViewCell

@property (nonatomic, strong) PerformanceRecipesModel *model;
@property (nonatomic, assign) float cellHeight;

@end

NS_ASSUME_NONNULL_END
