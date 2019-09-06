//
//  UIImage+Category.h
//  Oneyes
//
//  Created by 黄锡凯 on 2018/12/10.
//  Copyright © 2018 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Category)

/**
 *  更改图片颜色
 *
 *  @param color 颜色值
 */
- (UIImage *)imageChangeColor:(UIColor *)color;

/**
 *  更改图片大小
 *
 *  @param reSize 图片大小
 */
- (UIImage *)changeSize:(CGSize)reSize;

/**
 *  圆角
 */
- (UIImage *)drawCircle;

/**
 *  生成二维码
 *
 *  @param msg 内容
 *  @param size 大小
 */
+ (UIImage *)generateCodeWithMsg:(NSString *)msg size:(CGSize)size;

/**
 *  创建颜色图片
 *
 *  @param color 颜色
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
