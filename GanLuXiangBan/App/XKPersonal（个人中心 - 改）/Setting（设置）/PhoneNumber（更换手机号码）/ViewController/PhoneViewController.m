//
//  PhoneViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PhoneViewController.h"
#import "CustomTextField.h"
#import "PhoneViewModel.h"

@interface PhoneViewController ()

@property (nonatomic, strong) CustomTextField *phoneTextField;
@property (nonatomic, strong) CustomTextField *captchaTextFile;

@end

@implementation PhoneViewController
@synthesize captchaTextFile;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"更改手机号";
    
    WS(weakSelf);
    [self addNavRightTitle:@"保存" complete:^{
        [weakSelf updateMobileno];
    }];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    
    self.phoneTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, 50) leftImg:@"Login_Phone" isCaptcha:NO];
    self.phoneTextField.placeholder = @"请输入11位手机号";
    [self.view addSubview:self.phoneTextField];
    
    [self.phoneTextField.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@11);
        make.height.equalTo(@15);
    }];
    
    CGRect frame = CGRectMake(15, CGRectGetMaxY(self.phoneTextField.frame) + 10, ScreenWidth - 30, self.phoneTextField.height);
    captchaTextFile = [[CustomTextField alloc] initWithFrame:frame leftImg:@"Login_Captcha" isCaptcha:YES];
    captchaTextFile.placeholder = @"请输入验证码";
    [self.view addSubview:captchaTextFile];
    
    [captchaTextFile.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@13);
        make.height.equalTo(@15);
    }];
    
    @weakify(self);
    [captchaTextFile setCaptchaBlock:^{
     
        @strongify(self);
        if (self.phoneTextField.text.length != 11) {
            return [self.view makeToast:@"请输入正确手机号码"];
        }
        
        [self sendCodeWithPhone:self.phoneTextField.text];
    }];
}

- (void)sendCodeWithPhone:(NSString *)phone {
//    [self.view endEditing:YES];
    WS(weakSelf)
    [[PhoneViewModel new] getMobileCodeWithPhone:phone complete:^(HttpGeneralBackModel *obj) {
        
        if (obj.retcode == 0) {
            [weakSelf.view makeToast:@"发送验证码成功"];
            [weakSelf.captchaTextFile openCountdown];
        }
        else {
            [weakSelf.view makeToast:obj.retmsg];
        }
        
    }];
}

- (void)updateMobileno {
    
    [[PhoneViewModel new] updateWithMobileno:self.phoneTextField.text code:self.captchaTextFile.text complete:^(id object) {
        
        if ([object isEqualToString:@"修改成功"]) {
            SetUserDefault(UserPhone, self.phoneTextField.text);
        }
        
        [self.view makeToast:object];
    }];
}

@end
