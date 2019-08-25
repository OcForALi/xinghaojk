//
//  MedicationDetailsTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDetailModel.h"

@interface MedicationDetailsTableViewCell : UITableViewCell

@property (nonatomic ,copy) DrugDetailModel *model;

///药品名字
@property (nonatomic ,strong) UILabel *drug_nameLabel;
///单价
@property (nonatomic ,strong) UILabel *priceLabel;
///数量
//@property (nonatomic ,strong) UILabel *qtyLabel;
///小六指数
@property (nonatomic ,strong) UILabel *six_rateLabel;

@end
