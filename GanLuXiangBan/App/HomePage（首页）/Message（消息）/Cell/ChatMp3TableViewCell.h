//
//  ChatMp3TableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface ChatMp3TableViewCell : UITableViewCell

@property (nonatomic ,copy) ChatModel *model;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *PlayLabel;

@property (nonatomic ,strong) UIImageView *PlayImageView;

@property (nonatomic,strong) UIView *contentBackView;

@end
