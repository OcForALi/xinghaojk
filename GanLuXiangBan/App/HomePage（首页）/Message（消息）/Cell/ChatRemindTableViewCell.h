//
//  ChatRemindTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface ChatRemindTableViewCell : UITableViewCell

@property (nonatomic ,copy) ChatModel *model;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UIButton *detailsButton;

@property (nonatomic ,strong) UIView *drugContentView;

@property (nonatomic,strong) UIView *contentBackView;

@end
