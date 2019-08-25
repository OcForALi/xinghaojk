//
//  CheckListTableViewCell.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/20.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseCircleView.h"

@interface CheckListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *date;

@property (nonatomic, strong) BaseCircleView *redPoints;

@end
