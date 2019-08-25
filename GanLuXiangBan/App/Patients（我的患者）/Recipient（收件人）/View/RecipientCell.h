//
//  RecipientCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipientCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isSelect;

@end
