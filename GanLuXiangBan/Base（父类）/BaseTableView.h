//
//  BaseTableView.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetCompleteBlock)(NSInteger index);

@interface BaseTableView : UITableView  <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UIView *defaultImgView;
@property (nonatomic, strong) NSArray *dataSources;

/// 状态栏高度
@property (nonatomic, assign) CGFloat statusBarHeight;

#pragma mark - Block
/// 提示框回调
@property (nonatomic, copy) ActionSheetCompleteBlock complete;

- (void)resetEmptyTips:(NSString *)tips;

#pragma mark - 提示框
/// 文本提示框
- (void)actionSheetWithTitle:(NSString *)title titles:(NSArray *)titles isCan:(BOOL)isCan completeBlock:(ActionSheetCompleteBlock)actionSheetComplete;
/// 输入提示框
- (void)showTitleAlertWithMsg:(NSString *)msg isCancel:(BOOL)isCancel completeBlock:(void (^)(id object))completeBlock;

@end
