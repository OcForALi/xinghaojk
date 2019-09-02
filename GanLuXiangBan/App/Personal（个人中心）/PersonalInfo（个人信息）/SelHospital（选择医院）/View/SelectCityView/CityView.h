//
//  CityView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface CityView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *cityDict;
@property (nonatomic, assign) BOOL isShowCityList;

#pragma mark - Block

/**
 *  选择城市
 */
@property (nonatomic, strong) void (^selectCity)(NSString *province, NSString *city);

/**
 *  删除
 */
@property (nonatomic, strong) void (^removeBlock)(void);

/**
 *  选择城市
 *
 *  province 省份
 *  city 城市
 */
@property (nonatomic, strong) void (^selCityModelBlock)(CityModel *province, CityModel *city);

@end
