//
//  AddProductTableViewCell.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddProductTableViewCell : UITableViewCell

@property (nonatomic ,copy) DrugListModel *model;

///产品图片
@property (nonatomic ,strong) UIImageView *productImageView;
///产品名字
@property (nonatomic ,strong) UILabel *productNameLabel;
///规格
@property (nonatomic ,strong) UILabel *specificationsLabel;
///厂家
@property (nonatomic ,strong) UILabel *manufactorLabel;
///价钱
@property (nonatomic ,strong) UILabel *priceLabel;
///添加状态
@property (nonatomic ,strong) UIButton *addButton;

@end

NS_ASSUME_NONNULL_END
