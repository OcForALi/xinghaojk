//
//  BaseTextField.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

+ (instancetype)textFieldWithPlaceHolder:(NSString *)placeHolder headerViewText:(NSString *)headerViewText
{
    return [[self alloc] initWithPlaceHolder:placeHolder headerViewText:headerViewText];
}

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder headerViewText:(NSString *)headerViewText
{
    self = [super init];
    
    if (self) {
        
        if (headerViewText){
            
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = ({
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 13)];
                label.text = headerViewText;
                label.font = [UIFont systemFontOfSize:13];
                label;
            });
        }else{
            
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = ({
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
                
                view;
            });
            
        }
        
        self.placeholder = placeHolder;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    return self;
}

+ (instancetype)textFieldWithPlaceHolder:(NSString *)placeHolder leftImage:(NSString *)leftImage{
    return [[self alloc] initWithPlaceHolder:placeHolder leftImage:leftImage];
}

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder leftImage:(NSString *)leftImage{
    
    self = [super init];
    
    if (self) {
        
        if (leftImage){
            
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = ({
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
                imageView.image = [UIImage imageNamed:leftImage];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView;
            });
        }else{
            
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = ({
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
                
                view;
            });
            
        }
        
        self.placeholder = placeHolder;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    return self;
    
}

@end
