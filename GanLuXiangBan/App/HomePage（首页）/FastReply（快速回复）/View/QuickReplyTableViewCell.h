//
//  QuickReplyTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickReplyModel.h"
@interface QuickReplyTableViewCell : UITableViewCell

@property (nonatomic ,copy) QuickReplyModel *model;

@property (nonatomic ,strong) UIButton *button;

@property (nonatomic ,strong) UILabel *contentLabel;

@property (nonatomic ,assign) NSInteger typeInteger;

@end
