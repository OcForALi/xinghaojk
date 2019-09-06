//
//  IntegralInfoViewCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralInfoViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@end



@interface IntegralInfoViewRemarkCell : IntegralInfoViewCell

@property (nonatomic, strong) UIView *lineView;

@end
