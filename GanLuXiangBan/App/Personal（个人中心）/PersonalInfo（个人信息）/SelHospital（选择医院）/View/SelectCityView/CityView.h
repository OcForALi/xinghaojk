//
//  CityView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *cityDict;
@property (nonatomic, assign) BOOL isShowCityList;

#pragma mark - Block
@property (nonatomic, strong) void (^selectCity)(NSString *provinceString, NSString *cityString);

@end
