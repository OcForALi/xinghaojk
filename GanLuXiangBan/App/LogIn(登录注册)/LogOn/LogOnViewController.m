//
//  LogOnViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/6.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "LogOnViewController.h"
#import "BaseTextField.h"
#import "LogInRequest.h"
#import "FillInDataViewController.h"
#import "HelpWebViewController.h"

@interface LogOnViewController ()
///手机号
@property (nonatomic ,retain) BaseTextField *phoneTextField;
///验证码
@property (nonatomic ,retain) BaseTextField *captchaTextField;
///验证码按钮
@property (nonatomic ,retain) UIButton *captchaButton;
///密码
@property (nonatomic ,retain) BaseTextField *passwordTextField;
///再次确认密码
@property (nonatomic ,retain) BaseTextField *againPasswordTextField;

@property (nonatomic ,retain) LogInRequest *logInRequest;

//判断是否已注册成功 no = 未注册成功 yes = 注册成功
@property (nonatomic ,assign) BOOL isLogOn;

@end

@implementation LogOnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    self.isLogOn = NO;
    
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    self.captchaButton = [UIButton new];
    [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.captchaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.captchaButton.layer setMasksToBounds:YES];
    [self.captchaButton.layer setCornerRadius:5.0];
    [self.captchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.captchaButton setBackgroundColor: RGB(255, 145, 0)];
    [self.captchaButton addTarget:self action:@selector(captcha:) forControlEvents:UIControlEventTouchUpInside];
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
    
    self.passwordTextField = [BaseTextField textFieldWithPlaceHolder:@"输入6-18位密码" leftImage:@"Login_Password"];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    self.passwordTextField.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.captchaTextField, 10)
    .heightIs(50);
    
    self.againPasswordTextField = [BaseTextField textFieldWithPlaceHolder:@"再次输入密码" leftImage:@"Login_Password"];
    self.againPasswordTextField.backgroundColor = [UIColor whiteColor];
    self.againPasswordTextField.secureTextEntry = YES;
    [self.againPasswordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.againPasswordTextField];
    
    self.againPasswordTextField.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.passwordTextField, 10)
    .heightIs(50);
    
    UIButton *nextButton = [UIButton new];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor: kMainColor];
    [nextButton addTarget:self action:@selector(nextButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    nextButton.sd_layout
    .bottomSpaceToView(self.view, 0)
    .heightIs(50)
    .centerXEqualToView(self.view)
    .widthIs(ScreenWidth);
    
    UILabel *promptLabel = [UILabel new];
    promptLabel.text = @"点击下一步按钮，即表示同意";
    promptLabel.font = [UIFont systemFontOfSize:14];
    promptLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:promptLabel];
    
    promptLabel.sd_layout
    .leftSpaceToView(self.view, 30)
    .bottomSpaceToView(nextButton, 15)
    .heightIs(16);
    [promptLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    UILabel *tcpLabel = [UILabel new];
    tcpLabel.text = @"<幸好健康服务协议>";
    tcpLabel.textColor = kMainColor;
    tcpLabel.font = [UIFont systemFontOfSize:14];
    tcpLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tcpTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tcpTap:)];
    [tcpLabel addGestureRecognizer:tcpTap];
    [self.view addSubview:tcpLabel];
    
    tcpLabel.sd_layout
    .leftSpaceToView(promptLabel, 5)
    .centerYEqualToView(promptLabel)
    .heightIs(16);
    [tcpLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

-(void)phoneTextFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 11) {
        //截取
        textField.text = [textField.text substringToIndex:11];
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
            [self.logInRequest getCaptchaWithmobileno:self.phoneTextField.text type:1 complete:^(HttpGeneralBackModel *generalBackModel) {
                
                if (generalBackModel.retcode != 0) {
                    [weakSelf.view makeToast:generalBackModel.retmsg];
                }
                else {
                    [weakSelf.view makeToast:@"验证码发送成功"];
                    [weakSelf openCountdown];
                }
                
            }];
            
        }else{
            
        }
        
    }else{
        [self.view makeToast:@"请输入正确的手机号码"];
    }
    
}

-(void)nextButton{
//    FillInDataViewController *fillInVC = [[FillInDataViewController alloc] init];
//    [self.navigationController pushViewController:fillInVC animated:YES];
//    return;
    
    if(self.phoneTextField.text.length == 11){
        
        if ([self validateMobile:self.phoneTextField.text] == YES) {
            
        }else{
            [self.view makeToast:@"请输入正确的手机号码"];
        }
    }else{
        [self.view makeToast:@"请输入正确的手机号码"];
    }
    
    if(self.captchaTextField.text.length != 6){
        
        [self.view makeToast:@"请输入正确的验证码"];
        
        return;
    }
    if(self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 18){
        
        [self.view makeToast:@"密码长度过短"];
        
        return;
    }
    if(![self.passwordTextField.text isEqualToString:self.againPasswordTextField.text]){
        
        [self.view makeToast:@"两次密码不相同"];
        
        return;
    }
    
//    if (self.isLogOn == YES) {
//
//    }else{
    
        self.logInRequest = [LogInRequest new];
        
        [self.logInRequest postLogOnWithMobileNo:self.phoneTextField.text Password:self.passwordTextField.text Code:self.captchaTextField.text complete:^(HttpGeneralBackModel *generalBackModel) {
            
            NSLog(@"注册成功");
            
            if (generalBackModel == nil) {
                [self.view makeToast:@"接口报错"];
                return;
            }
            
            if (generalBackModel.retcode == 0) {
                
                FillInDataViewController *fillInVC = [[FillInDataViewController alloc] init];
                [self.navigationController pushViewController:fillInVC animated:YES];
                
                self.isLogOn = YES;
                
                SetUserDefault(UserID, generalBackModel.data);
                
                SetUserDefault(UserCheck_status, @"3");
                
            }else{
                
                [self.view makeToast:generalBackModel.retmsg];
                
            }
            
        }];
        
//    }
    
}

-(void)tcpTap:(UITapGestureRecognizer *)sender{
    
    self.logInRequest = [LogInRequest new];
    
    WS(weakSelf);
    
    [self.logInRequest getProtocolComplete:^(HttpGeneralBackModel *model) {
        
        HelpWebViewController *helpWebView = [[HelpWebViewController alloc] init];
        helpWebView.bodyString = model.data;
        helpWebView.title = @"幸好健康服务协议";
        [weakSelf.navigationController pushViewController:helpWebView animated:YES];
        
    }];;

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
