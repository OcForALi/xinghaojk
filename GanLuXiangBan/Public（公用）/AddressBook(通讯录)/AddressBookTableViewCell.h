//
//  AddressBookTableViewCell.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneContactModel.h"
#import "IndexPathButton.h"

@interface AddressBookTableViewCell : UITableViewCell

@property (nonatomic ,copy) PhoneContactModel *model;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) IndexPathButton *rightButton;

@end
