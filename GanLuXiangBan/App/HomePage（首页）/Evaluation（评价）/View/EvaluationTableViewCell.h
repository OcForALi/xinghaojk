//
//  EvaluationTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluationModel.h"

@interface EvaluationTableViewCell : UITableViewCell

@property (nonatomic ,copy) EvaluationModel *model;

@property (nonatomic ,strong) UIImageView *iamgeView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *contentLaebl;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIImageView *zsImageView;

@property (nonatomic ,strong) UILabel *zsLabel;

@property (nonatomic ,strong) UIView *evaluationDetailsView;

@end
