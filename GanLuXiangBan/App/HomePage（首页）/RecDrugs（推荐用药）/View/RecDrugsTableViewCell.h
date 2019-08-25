//
//  RecDrugsTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDosageModel.h"

@interface RecDrugsTableViewCell : UITableViewCell

@property (nonatomic ,strong) DrugDosageModel *model;
//编辑
@property (nonatomic ,strong) UILabel *compileLabel;
//药品名字
@property (nonatomic ,strong) UILabel *drugNameLabel;
//使用
@property (nonatomic ,strong) UILabel *usageLabel;
//备注
@property (nonatomic ,strong) UILabel *remarksLabel;
//数量
@property (nonatomic ,strong) UILabel *amountLabel;

@end
