//
//  HomeMessgeTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMessgeModel.h"

@interface HomeMessgeTableViewCell : UITableViewCell

@property (nonatomic ,copy) HomeMessgeModel *model;
///头像
@property (nonatomic ,strong) UIImageView *headImage;
///名字
@property (nonatomic ,strong) UILabel *nameLabel;
///内容
@property (nonatomic ,strong) UILabel *contentLabel;
///时间
@property (nonatomic ,strong) UILabel *timeLabel;
///会话状态
@property (nonatomic ,strong) UILabel *sessionLabel;

@end
