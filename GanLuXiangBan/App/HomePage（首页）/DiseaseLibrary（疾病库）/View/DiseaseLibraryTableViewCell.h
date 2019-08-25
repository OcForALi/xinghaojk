//
//  DiseaseLibraryTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiseaseLibraryModel.h"

@interface DiseaseLibraryTableViewCell : UITableViewCell

@property (nonatomic ,copy) DiseaseLibraryModel *model;

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UIButton *collectButton;

@property (nonatomic ,strong) UIImageView *collectImage;

@end
