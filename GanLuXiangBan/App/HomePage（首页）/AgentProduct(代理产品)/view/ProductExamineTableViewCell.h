//
//  ProductExamineTableViewCell.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductExamineTableViewCell : UITableViewCell

@property (nonatomic ,copy) ProductModel *model;
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
///审核不通过原因
@property (nonatomic ,strong) UILabel *noPassLabel;
///重新提交
@property (nonatomic ,strong) UIButton *reconsiderButton;

@end

NS_ASSUME_NONNULL_END
