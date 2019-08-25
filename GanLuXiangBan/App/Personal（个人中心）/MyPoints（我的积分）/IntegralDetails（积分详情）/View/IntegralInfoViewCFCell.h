//
//  IntegralInfoViewCFCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyPointInfoModel.h"

@interface IntegralInfoCFBorderView : UIView

@property (nonatomic, assign) BOOL topLine;

@property (nonatomic, assign) BOOL bottomLine;

@property (nonatomic, assign) BOOL leftLine;

@property (nonatomic, assign) BOOL rightLine;

@end


#pragma mark -

@interface IntegralInfoViewCFUserCell : UITableViewCell

@property (nonatomic, strong) IntegralInfoCFBorderView *borderView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *sexLabel;

@property (nonatomic, strong) UILabel *ageLabel;

@property (nonatomic, strong) UILabel *lczdLabel;

@end


#pragma mark -

@interface IntegralInfoViewCFTitleCell : UITableViewCell

@property (nonatomic, strong) IntegralInfoCFBorderView *borderView;

@property (nonatomic, strong) UILabel *titleLabel;

@end


#pragma mark -

@interface IntegralInfoViewCFCell : UITableViewCell

@property (nonatomic, strong) IntegralInfoCFBorderView *borderView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *useLabel;

@property (nonatomic, strong) MyPointInfoDrugModel *model;

@end
