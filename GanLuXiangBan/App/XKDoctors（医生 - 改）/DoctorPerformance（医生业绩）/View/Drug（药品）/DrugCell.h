//
//  DrugCell.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrugCell : UITableViewCell

@property (nonatomic, strong) PerformanceDrugsModel *model;
@property (nonatomic, assign) float cellHeight;

@end

NS_ASSUME_NONNULL_END
