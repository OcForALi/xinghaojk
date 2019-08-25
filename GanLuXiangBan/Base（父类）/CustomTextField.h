//
//  CustomTextField.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UIView

#pragma mark - 文本框
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic) UIKeyboardType keyboardType;

#pragma mark - 验证码按钮
@property (nonatomic, strong) UIColor *captchaBgColor;

#pragma mark - 图标
@property (nonatomic, strong) UIImageView *imgView;

#pragma mark - Block
@property (nonatomic, strong) void (^captchaBlock)();

#pragma mark - 方法
/// 开启倒计时效果
- (void)openCountdown;

- (instancetype)initWithFrame:(CGRect)frame leftImg:(NSString *)imgString isCaptcha:(BOOL)isCaptcha;

@end
