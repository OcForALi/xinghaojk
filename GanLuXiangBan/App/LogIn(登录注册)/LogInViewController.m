//
//  LogInViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "LogInViewController.h"
#import "BaseTextField.h"
#import "LogInRequest.h"
#import "AppDelegate.h"
#import "LogOnViewController.h"
#import "ForgotPasswordViewController.h"
#import "FillInDataViewController.h"
#import "LogInModel.h"
#import "CertificationViewController.h"

@interface LogInViewController ()

@property (nonatomic ,retain) BaseTextField *phoneTextField;

@property (nonatomic ,retain) BaseTextField *passwordTextField;

@property (nonatomic ,retain) UILabel *logonLabel;

@property (nonatomic ,retain) UILabel *forgetPasswordLabel;

@property (nonatomic ,retain) LogInRequest *logInRequest;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self block];
    
}

-(void)initUI{
    
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = [UIImage imageNamed:@"Login_BG"];
    [self.view addSubview:bgImageView];
    
    bgImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 0)
    .heightRatioToView(self.view, 0.7)
    .widthIs(ScreenWidth);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGBA(255, 255, 255, 0.9);
    [self.view addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .topSpaceToView(self.view, 40)
    .bottomSpaceToView(self.view, ScreenHeight * 0.2);
    
    UIImageView *iconImage = [UIImageView new];
    iconImage.image = [UIImage imageNamed:@"Login_IconBG"];
    iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:iconImage];
    
    iconImage.sd_layout
    .centerXEqualToView(bgView)
    .topSpaceToView(bgView, 30)
    .widthIs(ScreenWidth *0.29)
    .heightEqualToWidth();
    
    self.phoneTextField = [BaseTextField textFieldWithPlaceHolder:@"手机号" headerViewText:nil];
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    if (GetUserDefault(UserPhone)) {
        self.phoneTextField.text = GetUserDefault(UserPhone);
    }
    
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.phoneTextField];
    
    self.phoneTextField.sd_layout
    .topSpaceToView(iconImage, 40)
    .heightIs(50)
    .leftSpaceToView(bgView, 30)
    .rightSpaceToView(bgView, 30);
    
    self.passwordTextField = [BaseTextField textFieldWithPlaceHolder:@"密码" headerViewText:nil];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.passwordTextField];
    
    self.passwordTextField.sd_layout
    .topSpaceToView(self.phoneTextField, 10)
    .heightIs(50)
    .leftSpaceToView(bgView, 30)
    .rightSpaceToView(bgView, 30);
    
    UIButton *logInButton = [UIButton new];
    [logInButton setTitle:@"登录" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logInButton.backgroundColor = kMainColor;
    [logInButton addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:logInButton];
    
    logInButton.sd_layout
    .widthRatioToView(self.passwordTextField, 1)
    .heightRatioToView(self.passwordTextField, 1)
    .bottomSpaceToView(bgView, 40)
    .centerXEqualToView(bgView);
    
    self.logonLabel = [UILabel new];
    self.logonLabel.font = [UIFont systemFontOfSize:14];
    self.logonLabel.textColor = [UIColor blueColor];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:@"我要注册"attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.logonLabel.attributedText = attribtStr;
    self.logonLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *logonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logonTap:)];
    [self.logonLabel addGestureRecognizer:logonTap];
    [self.view addSubview:self.logonLabel];
    
    self.logonLabel.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view, 10)
    .heightIs(14);
    [self.logonLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.forgetPasswordLabel = [UILabel new];
    self.forgetPasswordLabel.text = @"忘记密码？";
    self.forgetPasswordLabel.font = [UIFont systemFontOfSize:14];
    self.forgetPasswordLabel.textColor = [UIColor lightGrayColor];
    self.forgetPasswordLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetPasswordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPasswordTap:)];
    [self.forgetPasswordLabel addGestureRecognizer:forgetPasswordTap];
    [self.view addSubview:self.forgetPasswordLabel];
    
    self.forgetPasswordLabel.sd_layout
    .xIs(ScreenWidth/2 + 5)
    .centerYEqualToView(self.logonLabel)
    .heightIs(14);
    [self.forgetPasswordLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
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
    
-(void)block{
    
    WS(weakSelf);
    self.logonLabel.didFinishAutoLayoutBlock = ^(CGRect frame) {
        
        weakSelf.logonLabel.sd_resetLayout
        .xIs(ScreenWidth/2 - frame.size.width - 5)
        .yIs(frame.origin.y)
        .heightIs(frame.size.height)
        .widthIs(frame.size.width);
        
    };
    
}

-(void)logIn:(UIButton *)sender{

    [self showHudAnimated:YES];
    
    self.logInRequest = [LogInRequest new];
    
    NSString *pwd = self.passwordTextField.text;
    WS(weakSelf)
    [self.logInRequest getLogInfoWithloginname:self.phoneTextField.text loginpwd:pwd complete:^(HttpGeneralBackModel *generalBackModel) {
        
        SetUserDefault(UserPwd, pwd);
        
        if (generalBackModel.retcode != 0) {
            [self.view makeToast:generalBackModel.retmsg];
            [self hideHudAnimated];
            return ;
        }
        
        if ([generalBackModel.data isKindOfClass:[NSNull class]] || [generalBackModel.data isKindOfClass:[NSString class]] || generalBackModel.data == nil) {
            [self.view makeToast:@"“登录账号或密码不正确”或 账号密码不能为空"];
            [self hideHudAnimated];
            return ;
        }
        
        LogInModel *model = [LogInModel new];
        [model setValuesForKeysWithDictionary:generalBackModel.data];
        
        [weakSelf.logInRequest getBearToken];
        
        if (model.check_status == 1) {
            
            FillInDataViewController *fillInVC = [[FillInDataViewController alloc] init];
            [self.navigationController pushViewController:fillInVC animated:YES];
            
            SetUserDefault(UserCheck_status, @"3");
            
        }
        else if (model.check_status == 2){
            
            CertificationViewController *certificationView = [[CertificationViewController alloc] init];
            certificationView.title = @"资格认证";
            certificationView.type = 1;
            [self.navigationController pushViewController:certificationView animated:YES];
            
            SetUserDefault(UserCheck_status, @"3");
            
        }
        else if (model.check_status == 0) {

            if([GetUserDefault(UserID) isEqualToString:model.pkid]){
                GLAppDelegate.isLogined = YES;
                [GLAppDelegate initMainController];
            }
            
        }else if (model.check_status == -1){
            [self.view makeToast:@"待审核中"];
        }
        
        [self hideHudAnimated];
        
    }];
    
}

-(void)logonTap:(UITapGestureRecognizer *)sender{
    
    LogOnViewController *logOnView = [[LogOnViewController alloc] init];
    [self.navigationController pushViewController:logOnView animated:YES];
    
}

-(void)forgetPasswordTap:(UITapGestureRecognizer *)sender{
    
    ForgotPasswordViewController *forgotPasswordVC = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideHudAnimated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



@end
