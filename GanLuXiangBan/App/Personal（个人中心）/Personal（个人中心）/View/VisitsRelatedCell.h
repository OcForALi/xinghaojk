//
//  VisitsRelatedCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VisitsRelatedCellHeight 130

@interface VisitsRelatedCell : UITableViewCell

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
