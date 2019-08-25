//
//  ChatTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatTableViewCell : UITableViewCell

@property (nonatomic ,copy) ChatModel *model;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *exportTextLabel;

@property (nonatomic ,strong) UIView *contentBackView;

@property (nonatomic ,strong) UIBezierPath *path;

@end
