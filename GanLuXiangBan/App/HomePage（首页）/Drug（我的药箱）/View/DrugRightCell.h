//
//  DrugRightCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugModel.h"

@interface DrugRightCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DrugModel *model;

@end
