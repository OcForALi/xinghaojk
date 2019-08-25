//
//  SubscribeContentCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeDetailsModel.h"

@interface SubscribeContentCell : UITableViewCell

@property (nonatomic, strong) SubscribeDetailsModel *model;
@property (nonatomic, assign) CGFloat cellHeight;

@end
