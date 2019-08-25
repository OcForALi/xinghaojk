//
//  PaySetCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaySetModel.h"

@interface PaySetCell : UITableViewCell

@property (nonatomic, strong) PaySetModel *model;
@property (nonatomic, strong) UILabel *priceLabel;

@end
