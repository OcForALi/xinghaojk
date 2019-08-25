//
//  DrugListTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugListModel.h"

@interface DrugListTableViewCell : UITableViewCell

@property (nonatomic ,copy) DrugListModel *model;

@property (nonatomic ,strong) UIImageView *drugImageView;

@property (nonatomic ,strong) UILabel *drugLabel;

@property (nonatomic ,strong) UILabel *drugStandardLabel;

@property (nonatomic ,strong) UILabel *drugProducerLabel;

@property (nonatomic ,strong) UILabel *priceLabel;

@property (nonatomic ,strong) UILabel *six_RaterLabel;

@property (nonatomic ,strong) UIButton *collectButton;

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,copy) NSArray *drug_idArray;

@property (nonatomic ,strong) UIButton *selectedButton;

@end
