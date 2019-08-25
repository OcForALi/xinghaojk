//
//  BaseViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

/// actionSheet成功回调
typedef void(^ActionSheetCompleteBlock)(NSInteger index);

@interface BaseViewController : UIViewController

- (instancetype)loadVC:(NSString *)vcId;

/// 导航总高度
@property (nonatomic, assign) CGFloat navHeight;
/// 导航栏高度
@property (nonatomic, assign) CGFloat navBarHeight;
/// 状态栏高度
@property (nonatomic, assign) CGFloat statusBarHeight;
/// tabBar高度
@property (nonatomic, assign) CGFloat tabBarHeight;

#pragma mark - Block
/// actionSheet成功回调
@property (nonatomic, copy) ActionSheetCompleteBlock complete;
/// 完成回调
@property (nonatomic, strong) void (^completeBlock)(id object);

// 显示加载动画
- (void)showHudAnimated:(BOOL)animated;
// 隐藏加载动画
- (void)hideHudAnimated;

- (void)setNavigationItem;

/**
 添加导航右键文字

 @param titleString 文字标题
 @param complete    点击回调
 */
- (void)addNavRightTitle:(NSString *)titleString complete:(void (^)())complete;
- (void)addNavRightTitle:(NSString *)titleString width:(CGFloat)width complete:(void (^)())complete;

/**
 提示框

 @param title           标题
 @param msg             内容
 @param isShowCancel    是否显示取消按钮
 @param complete        成功回调
 */
- (void)alertWithTitle:(NSString *)title
                   msg:(NSString *)msg
          isShowCancel:(BOOL)isShowCancel
              complete:(void (^)())complete;


/**
 actionSheet提示框

 @param title                标题
 @param titles               内容
 @param isCan                是否有取消按钮
 @param actionSheetComplete  成功回调
 */
- (void)actionSheetWithTitle:(NSString *)title titles:(NSArray *)titles isCan:(BOOL)isCan completeBlock:(ActionSheetCompleteBlock)actionSheetComplete;

- (UIButton *)setupBottomButton:(NSString *)title;

@end
