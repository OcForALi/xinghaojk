//
//  PersonalInfoCell.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/8/28.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoCell : UITableViewCell

@property (nonatomic, strong) PersonalModel *model;

@property (nonatomic, assign) float cellHeight;

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end

NS_ASSUME_NONNULL_END
