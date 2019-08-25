//
//  AppMacro.h
//  DingBell
//
//  Created by M on 2018/4/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//
//  App的相关宏定义

#import "HttpMacro.pch"
#import "NotiMacro.h"
#import "VendorMacro.h"
#import "UserDefaultsMacro.h"

#ifndef AppMacro_h
#define AppMacro_h

/*** 常用 ***/
/** app主色调 */
#define kMainColor [UIColor colorWithHexString:@"0x4671f3"]
#define kMainTextColor [UIColor colorWithHexString:@"0x333333"]
/** 页面背景色 */
#define kPageBgColor [UIColor colorWithHexString:@"0xF5F5F5"]
/** 线条的颜色 */
#define kLineColor [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
#define kThreeColor [UIColor colorWithHexString:@"0x333333"]
#define kSixColor [UIColor colorWithHexString:@"0x666666"]
#define kNightColor [UIColor colorWithHexString:@"0x999999"]
#define KRedColor [UIColor colorWithHexString:@"0xF6733E"]

/*** 日志 ***/
#ifdef DEBUG
#define KLog(...) NSLog(@"%s 第%d行 %@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define KLog(...)
#endif

#define kFontRegular(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define kFontLight(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define kFontMedium(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]

// 沙盒路径
#define kDocumentPath   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

// 系统版本
#define System_Version          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IsHigherIOS(version)    [[[UIDevice currentDevice]systemVersion]floatValue] > version

// App信息
#define App_Name                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define App_Version             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define App_BundleID            ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

// UserDefaults
#define GetUserDefault(key)         [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
#define SetUserDefault(key,value)   [[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)]
#define RemoveUserDefault(key)      [[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)]

// 颜色
#define RGB(r,g,b)      [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:(double)a]

// 宽高
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define NavHeight       self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define  kTabbarSafeBottomMargin        (IS_iPhoneX ? 34.f : 0.f)
#define  kNavbarSafeHeight        (IS_iPhoneX ? 24.f : 0.f)

// Cell右间距
#define kCellSpacing ScreenWidth == 320 ? 15 : 20

// 弱引用
#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self;
// 当前导航控制器
#define NavController   (UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController)
//全局AppDelegate
#define GLAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
// 判断是否空字符串
#define NullString(str) ((str && [str isKindOfClass:[NSString class]] && [value length]) ? str : @"")

#endif /* AppMacro_h */

//---------------------- Debug模式下打印日志和当前行数 ----------------------
#if DEBUG
#define DebugLog(FORMAT, ...) fprintf(stderr,"╭═════════════════════════════════════════════════════════╮ \n║方法:%s 行:%d \n║详情:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DebugLog(FORMAT, ...) nil
#endif


typedef NS_ENUM(NSInteger, DiseaseLibraryType) {
    DiseaseLibraryTypeAll = 0,
    DiseaseLibraryTypeCommon = 1
};


typedef NS_ENUM(NSInteger, PickerType) {
    PickerTypeInfo,//用法
    PickerTypeNum,//用量
    PickerTypeUnit,//用量单位
    PickerTypeCycle,//用药周期
    PickerTypeDuring//周期列表
};


#define kGtAppId           @"mfyIbnrpGF6kbtsbv1FOQ8"
#define kGtAppKey          @"qv6llCyHbO6QVJW1b3I2Z5"
#define kGtAppSecret       @"hoR2iVB5mf8QifxWRjZ9q8"

#define kChattingMid       @"glxbChattingMide"
