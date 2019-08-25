//
//  EditUserInfoViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EditUserInfoViewController.h"

@interface EditUserInfoViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation EditUserInfoViewController
@synthesize textField;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupSubviews];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
     
        @strongify(self);
        [self.view endEditing:YES];
        
        if (self.textField.text.length > 8) {
            
            [self.view makeToast:@"昵称不可超过8位"];
        }
        else {
            
            [self save];
        }
    }];
}

- (void)setupSubviews {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.y, ScreenWidth, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, bgView.height)];
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"请输入您的真实姓名";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:textField];
    
    if (self.placeholderString.length > 0) {
        self.textField.placeholder = self.placeholderString;
    }

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [bgView addSubview:line];
}

- (void)save {
    
    if (self.completeBlock) {
        self.completeBlock(textField.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
