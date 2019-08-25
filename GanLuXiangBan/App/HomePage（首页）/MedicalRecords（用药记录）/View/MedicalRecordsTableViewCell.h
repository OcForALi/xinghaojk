//
//  MedicalRecordsTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalRecordsModel.h"
@interface MedicalRecordsTableViewCell : UITableViewCell

@property (nonatomic ,copy) MedicalRecordsModel *model;
//配方ID
@property (nonatomic ,strong) UILabel *recipeLabel;
///购买状态
@property (nonatomic ,strong) UILabel *statusLabel;
///头像
@property (nonatomic ,strong) UIImageView *headImageView;
///名字
@property (nonatomic ,strong) UILabel *patient_nameLabel;
///性别
@property (nonatomic ,strong) UILabel *patient_genderLebl;
///年龄
@property (nonatomic ,strong) UILabel *patient_ageLabel;
///药品名字
@property (nonatomic ,strong) UILabel *drug_namesLabel;
///创建时间
@property (nonatomic ,strong) UILabel *createtimeLabel;

@end
