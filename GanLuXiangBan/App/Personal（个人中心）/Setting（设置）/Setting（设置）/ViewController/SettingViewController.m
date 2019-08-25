//
//  SettingViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingView.h"
#import "AppDelegate.h"
#import "SettingViewModel.h"

@interface SettingViewController ()

@property (nonatomic, strong) SettingView *settingView;

@end

@implementation SettingViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self initSettingView];
    [self createExitBtn];
    [self getHelp];
}

- (void)initSettingView {
    
    self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
    self.settingView.dataSources = @[@[@"手机号"], @[@"修改密码"], @[@"关于", @"服务协议", @"联系我们"]];
    self.settingView.phoneString = GetUserDefault(UserPhone);
    [self.view addSubview:self.settingView];
    
    WS(weakSelf);
    [self.settingView setGoViewController:^(BaseViewController *viewController) {
        [weakSelf goViewController:viewController];
    }];
    
    [self.settingView setCallBlock:^{
        [weakSelf callPhone];
    }];
}

- (void)createExitBtn {
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(0, self.view.height - 50 - self.navHeight, ScreenWidth, 50);
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    exitBtn.backgroundColor = [UIColor colorWithHexString:@"0xcc3936"];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:exitBtn];
    
    @weakify(self);
    [[exitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     
        @strongify(self);
        [self exit];
    }];
}

#pragma mark - 方法
- (void)goViewController:(BaseViewController *)viewController {
    
    WS(weakSelf);
    [viewController setCompleteBlock:^(id object) {
        weakSelf.settingView.phoneString = GetUserDefault(UserPhone);
    }];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)callPhone {
    
    NSString *titleString = @"助理上班时间：7 * 8小时\n(09:00 - 18:00)";
    [self alertWithTitle:titleString msg:@"020-81978876" isShowCancel:YES complete:^{
        
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"020-81978876"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
}

- (void)exit {
    
    [self alertWithTitle:@"温馨提示" msg:@"是否退出登录" isShowCancel:YES complete:^{
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserID];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserPhone];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserGender];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHospital];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserIntroduction];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserRemark];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHead];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserCheck_status];
        [[NSUserDefaults standardUserDefaults] synchronize];
        GLAppDelegate.isLogined = NO;
//
//        if ([self.presentingViewController isKindOfClass:[NSClassFromString(@"LogInViewController") class]]) {
//
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//        else {
//
//            [self presentViewController:[NSClassFromString(@"LogInViewController") new] animated:YES completion:nil];
//        }
        
        [GLAppDelegate initLogIn];
    }];
}

#pragma mark - request
- (void)getHelp {
    
    [[SettingViewModel new] getHelpComplete:^(id object) {
        self.settingView.helpBodyString = object;
    }];
}

@end
