//
//  MyTextField.h
//  CustomTextView
//
//  Created by DongXiaoKun on 2017/5/24.
//  Copyright © 2017年 xieyunheqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView: UITextView

/**占位文字*/
@property (nonatomic,copy) NSString* placeholder;
/**占位文字颜色*/
@property (nonatomic, strong) UIColor *placeholderColor;

@end
