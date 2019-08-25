//
//  ExchangeCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeCell : UITableViewCell

@property (nonatomic, strong) NSString *pointString;
@property (nonatomic, strong) void (^echangeBlock)(NSString *number);

@end
