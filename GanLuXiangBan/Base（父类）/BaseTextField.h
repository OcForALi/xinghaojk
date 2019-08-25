//
//  BaseTextField.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

@property (nonatomic ,assign) NSIndexPath *indextPath;

+ (instancetype)textFieldWithPlaceHolder:(NSString *)placeHolder headerViewText:(NSString *)headerViewText;

+ (instancetype)textFieldWithPlaceHolder:(NSString *)placeHolder leftImage:(NSString *)leftImage;

@end
