//
//  ForgotPasswordViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "BaseTextField.h"
#import "LogInRequest.h"
#import "LogInViewController.h"

@interface ForgotPasswordViewController ()

///手机号
@property (nonatomic ,retain) BaseTextField *phoneTextField;
///验证码
@property (nonatomic ,retain) BaseTextField *captchaTextField;
///验证码按钮
@property (nonatomic ,retain) UIButton *captchaButton;
///密码
@property (nonatomic ,retain) BaseTextField *passwordTextField;

@property (nonatomic ,retain) LogInRequest *logInRequest;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.title || self.title.length == 0) {
        self.title = @"忘记密码";
    }
    
    [self initUI];
    
}

-(void)initUI{
    
    self.phoneTextField = [BaseTextField textFieldWithPlaceHolder:@"输入11位手机号" leftImage:@"Login_Phone"];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTextField];
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.view, 30)
    .heightIs(50);
    
    self.captchaTextField = [BaseTextField textFieldWithPlaceHolder:@"输入验证码" leftImage:@"Login_Captcha"];
    self.captchaTextField.backgroundColor = [UIColor whiteColor];
    self.captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    self.captchaButton = [UIButton new];
    [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.captchaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.captchaButton.layer setMasksToBounds:YES];
    [self.captchaButton.layer setCornerRadius:5.0];
    [self.captchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.captchaButton setBackgroundColor: RGB(255, 145, 0)];
    [self.captchaButton addTarget:self action:@selector(captcha:) forControlEvents:UIControlEventTouchUpInside];
    [self.captchaTextField addTarget:self action:@selector(captchaTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:self.captchaButton];
    
    self.captchaButton.sd_layout
    .rightSpaceToView(view, 10)
    .centerYEqualToView(view)
    .heightIs(40);
    [self.captchaButton setupAutoSizeWithHorizontalPadding:20 buttonHeight:40];
    
    self.captchaTextField.rightViewMode = UITextFieldViewModeAlways;
    self.captchaTextField.rightView = view;
    [self.view addSubview:self.captchaTextField];
    
    self.captchaTextField.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.phoneTextField, 10)
    .heightIs(50);
    
    self.passwordTextField = [BaseTextField textFieldWithPlaceHolder:@"输入新的密码" leftImage:@"Login_Password"];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    self.passwordTextField.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.captchaTextField, 10)
    .heightIs(50);
    
    UIButton *sendButton = [UIButton new];
    sendButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [sendButton setTitle:@"确定" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundColor: kMainColor];
    [sendButton addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    sendButton.sd_layout
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(50);
    
}

-(void)phoneTextFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 11) {
        //截取
        textField.text = [textField.text substringToIndex:11];
    }
    
}

-(void)captchaTextFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 6) {
        //截取
        textField.text = [textField.text substringToIndex:6];
    }
    
}

-(void)passwordTextFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 18) {
        //截取
        textField.text = [textField.text substringToIndex:18];
    }
    
}

-(void)captcha:(UIButton *)sender{
    
    if(self.phoneTextField.text.length == 11){
        
        if ([self validateMobile:self.phoneTextField.text] == YES) {
            
            self.logInRequest = [LogInRequest new];
            WS(weakSelf)
            [self.logInRequest getMasterDataCaptchaWithmobileno:self.phoneTextField.text type:2 complete:^(HttpGeneralBackModel *generalBackModel) {
                
                [self.view makeToast:generalBackModel.retcode == 0 ? @"发送验证码成功" : generalBackModel.retmsg];
                
                if (generalBackModel.retcode == 0) {
                    [weakSelf openCountdown];
                }
                
            }];
            
        }else{
            
        }
        
    }else{
        
    }
    
}

-(void)sendButton:(UIButton *)sender{
    
    if(self.captchaTextField.text.length != 6){
        
        [self.view makeToast:@"请输入正确的验证码"];
        
        return;
    }
    if(self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 18){
        
        [self.view makeToast:@"密码长度过短"];
        
        return;
    }
    
    WS(weakSelf)
    [self.logInRequest postForgetPwdMobileNo:self.phoneTextField.text Password:self.passwordTextField.text Code:self.captchaTextField.text complete:^(HttpGeneralBackModel *model) {
       
        
        if (model.retcode == 0) {
            
            [weakSelf.view makeToast:@"修改成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[LogInViewController class]]) {
                        [weakSelf.navigationController popToViewController:controller animated:YES];
                    }
                }
                
            });
            
        }else{
            [weakSelf.view makeToast:model.retmsg];
        }

    }];
    
}

- (BOOL)validateMobile:(NSString *)mobile{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,170,177,180,181,189
     */
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.captchaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.captchaButton.userInteractionEnabled = YES;
                [self.captchaButton setBackgroundColor: RGB(255, 145, 0)];
                
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.captchaButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                self.captchaButton.userInteractionEnabled = NO;
                [self.captchaButton setBackgroundColor: [UIColor lightGrayColor]];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
