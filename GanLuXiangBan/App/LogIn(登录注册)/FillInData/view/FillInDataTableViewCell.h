//
//  FillInDataTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FillInDataModel.h"
#import "BaseTextField.h"
@interface FillInDataTableViewCell : UITableViewCell

@property (nonatomic ,copy) FillInDataModel *model;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *messageTextField;

@end
