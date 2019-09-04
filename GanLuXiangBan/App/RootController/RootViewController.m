//
//  RootViewController.m
//  MizheDemo
//
//  Created by Kai on 15/6/25.
//  Copyright (c) 2015年 Kai. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LogInRequest.h"
#import "MessageRequest.h"
#import "MessageViewController.h"

#import <MBProgressHUD.h>

@interface RootViewController ()

@property (nonatomic ,retain) LogInRequest *logInRequest;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSTimer *noreplyTimer;

@property (nonatomic, assign) BOOL autoLogining;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self initViewController];

    [self request];
    
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = kMainColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackgroundStopTimer) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterForegroundStartTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)loginTimeExpiredToLogin {
    if (!self.autoLogining) {
        self.autoLogining = YES;
        [self showHudAnimated];
        NSString *phone = GetUserDefault(UserPhone);
        NSString *pwd = GetUserDefault(UserPwd);
        if (phone && pwd) {
            WS(weakSelf)
            [[LogInRequest new] getLogInfoWithloginname:phone loginpwd:pwd complete:^(HttpGeneralBackModel *generalBackModel) {
                
                LogInModel *model = [LogInModel new];
                [model setValuesForKeysWithDictionary:generalBackModel.data];
                
                [[LogInRequest new] getBearToken];
                
                if (model.check_status == 0) {
                    if([GetUserDefault(UserID) isEqualToString:model.pkid]){
                        GLAppDelegate.isLogined = YES;
                    }
                }
                else if (generalBackModel.retcode == 1) {
                    [weakSelf.view makeToast:generalBackModel.retmsg];
                    [weakSelf loginTimeExpired];
                }
                [weakSelf hideHudAnimated];
            }];
        }
        else {
            [self loginTimeExpired];
        }
    }
}

- (void)loginTimeExpired {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录超时，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    WS(weakSelf)
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [GLAppDelegate initLogIn];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.autoLogining = NO;
        });
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showHudAnimated {
    
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        @strongify(self);
        if (self.hud && self.hud.superview == self.view) {
            return;
        }
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = @"正在加载中";
    });
    
}

- (void)hideHudAnimated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

#pragma mark - 初始化
- (void)initViewController {
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];

    // 控制器名字
    NSArray *viewControllerNames = @[@"HomeViewController", @"PatientsViewController", @"PersonalViewController"];
    
    // 标题
    NSArray *titles = @[@"首页", @"医生", @"个人中心"];
    
    // 图标
    NSArray *imgs = @[@"tabbar_home", @"tabbar_patients", @"tabbar_me"];
    
    // 选中图片
    NSArray *selectImgs = @[@"tabbar_home_select", @"tabbar_patients_select", @"tabbar_me_select"];
    
    for (int i = 0; i < viewControllerNames.count; i++) {
        
        RTRootNavigationController *nav = [self NavigationControllerWithControllerName:viewControllerNames[i]];
        nav.tabBarItem.image = [[UIImage imageNamed:imgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.title = titles[i];
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;
}

- (void)request {
    
    self.logInRequest = [LogInRequest new];
    
    [self loginTimeExpiredToLogin];
    
    [self.logInRequest getBearToken];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self loginTimeExpiredToLogin];
        
        [self.logInRequest getBearToken];
        
    });
    
    //上传个推clientId到服务器
    NSString *clientId = GetUserDefault(GeTuiDeviceId);
    if (clientId && clientId.length > 0) {
        [[LogInRequest new] postSaveClientCid:clientId complete:^(LogInModel *model) {
            
        }];
    }
    
    [[LogInRequest new] getVersionUpdateInfoComplete:^(HttpGeneralBackModel *model) {
       
        if ([model.data objectForKey:@"version"]) {
            SetUserDefault(UserVersion, [model.data objectForKey:@"version"]);
        }
        
    }];
#if 1
    [self applicationEnterForegroundStartTimer];
#endif
}

- (void)requestNoReplyAlert {
    WS(weakSelf)
    [[MessageRequest new] noReplyChatAlert:^(HttpGeneralBackModel *model) {
        if (model.data) {
            NSDictionary *dic = model.data;
            BOOL alert = [[dic valueForKey:@"is_alert"] boolValue];
            if (alert) {
                NSString *content = [dic valueForKey:@"content"];
                NSString *recordId = [NSString stringWithFormat:@"%@", dic[@"record_id"]];
                
                if (content && ![content isKindOfClass:NSNull.class] && content.length > 0 && recordId) {
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"重要提醒" message:content preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [vc addAction:cancel];
                    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[MessageRequest new] confirmNoReplyAlert:recordId complete:^(HttpGeneralBackModel *genneralBackModel) {
                            
                            NSDictionary *dic = genneralBackModel.data;
                            if (dic && dic.count >= 4) {
                                MessageViewController *messageView = [[MessageViewController alloc] init];
                                messageView.mid = [NSString stringWithFormat:@"%@", dic[@"mid"]];
                                messageView.msg_source = [NSString stringWithFormat:@"%@",dic[@"msg_source"]];
                                messageView.patientName = [NSString stringWithFormat:@"%@",dic[@"member_name"]];
                                messageView.msg_flag = [NSString stringWithFormat:@"%@",dic[@"msg_source"]];
                                messageView.msgId = [NSString stringWithFormat:@"%@",dic[@"msg_id"]];
                                messageView.title = messageView.patientName;
                                messageView.hidesBottomBarWhenPushed = YES;
                                UINavigationController *nav = (UINavigationController *)(weakSelf.selectedViewController);
                                [nav pushViewController:messageView animated:YES];
                            }
                            
                        }];
                        
                    }];
                    [vc addAction:confirm];
                    [weakSelf presentViewController:vc animated:YES completion:nil];
                }
            }
        }
    }];
}

- (void)requestPharmacyApplyAlert {
    NSString *mid = [NSString stringWithFormat:@"%@", GetUserDefault(UserID)];
    WS(weakSelf)
    [[MessageRequest new] pharmacyApplyAlert:mid complete:^(HttpGeneralBackModel *genneralBackModel) {
        if (genneralBackModel.data) {
            NSDictionary *dic = genneralBackModel.data;
            BOOL alert = [[dic valueForKey:@"is_alert"] boolValue];
            if (alert) {
                NSString *content = [dic valueForKey:@"content"];
                NSString *recordId = [NSString stringWithFormat:@"%@", dic[@"record_id"]];
                if (content && ![content isKindOfClass:NSNull.class] && content.length > 0 && recordId) {
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"重要提醒" message:content preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [vc addAction:cancel];
                    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[MessageRequest new] confirmPharmacyAppAlert:recordId complete:^(HttpGeneralBackModel *genneralBackModel) {
                            
                            NSDictionary *dic = genneralBackModel.data;
                            if (dic && dic.count >= 4) {
                                MessageViewController *messageView = [[MessageViewController alloc] init];
                                messageView.mid = [NSString stringWithFormat:@"%@", dic[@"mid"]];
                                messageView.msg_source = [NSString stringWithFormat:@"%@",dic[@"msg_source"]];
                                messageView.patientName = [NSString stringWithFormat:@"%@",dic[@"member_name"]];
                                messageView.msg_flag = [NSString stringWithFormat:@"%@",dic[@"msg_source"]];
                                messageView.msgId = [NSString stringWithFormat:@"%@",dic[@"msg_id"]];
                                messageView.title = messageView.patientName;
                                messageView.hidesBottomBarWhenPushed = YES;
                                UINavigationController *nav = (UINavigationController *)(weakSelf.selectedViewController);
                                [nav pushViewController:messageView animated:YES];
                            }
                            
                        }];
                        
                    }];
                    [vc addAction:confirm];
                    [weakSelf presentViewController:vc animated:YES completion:nil];
                }
            }
        }
    }];
}

- (void)applicationEnterBackgroundStopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.noreplyTimer) {
        [self.noreplyTimer invalidate];
        self.noreplyTimer = nil;
    }
}

- (void)applicationEnterForegroundStartTimer {
    BOOL logined = GLAppDelegate.isLogined;
    if (!logined) {
        return;
    }
    
    [self applicationEnterBackgroundStopTimer];

    self.timer = [NSTimer timerWithTimeInterval:120 target:self selector:@selector(loginAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.noreplyTimer = [NSTimer timerWithTimeInterval:300 target:self selector:@selector(requestNoReplyAlert) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.noreplyTimer forMode:NSRunLoopCommonModes];

    [self loginAction];
    [self performSelector:@selector(requestNoReplyAlert) withObject:nil afterDelay:3];
}

- (BOOL)chatWithMid {
    return YES;
}

-(void)loginAction {
    
    [self requestPharmacyApplyAlert];
    return;
    
    [[LogInRequest new] getClientInfoComplete:^(HttpGeneralBackModel *generalBackModel) {
        
//        if ([generalBackModel isEqual:[NSNull null]] || generalBackModel == nil) {
//
//            [self.timer invalidate];
//            self.timer = nil;
//
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserID];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserName];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserPhone];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserGender];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHospital];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserIntroduction];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserRemark];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHead];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserCheck_status];
//
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            [GLAppDelegate initLogIn];
//
//        }
        
        if ([generalBackModel.data objectForKey:@"cid"]) {
            NSString *clientId = GetUserDefault(GeTuiDeviceId);
            if (clientId && [[generalBackModel.data objectForKey:@"cid"] isEqualToString:clientId]) {
                
            }else{
                GLAppDelegate.isLogined = NO;
                
                NSString *messageString;

                if ([[generalBackModel.data objectForKey:@"device_type"] integerValue] == 1) {
                    messageString = @"你的账号在另一台安卓设备上登录";
                }else{
                    messageString = @"你的账号在另一台苹果设备上登录";
                }
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:messageString preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserID];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserName];
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserPhone];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserGender];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHospital];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserIntroduction];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserRemark];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserHead];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserCheck_status];

                    [[NSUserDefaults standardUserDefaults] synchronize];

                    [self.timer invalidate];
                    self.timer = nil;
                    [self.noreplyTimer invalidate];
                    self.noreplyTimer = nil;
                    
                    GLAppDelegate.isLogined = NO;
                    
                    [GLAppDelegate initLogIn];

                }];

                [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];

                //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
//                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//                    //开启定时器
//                    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
//
//                    [[LogInRequest new] postSaveClientCid:[[[UIDevice currentDevice] identifierForVendor] UUIDString] device_type:@"2" complete:^(LogInModel *model) {
//
//                    }];
//
//                }];

                [alert addAction:cancel];//添加取消按钮

//                [alert addAction:ok];//添加确认按钮

                //以modal的形式
                [NavController presentViewController:alert animated:YES completion:nil];

            }
            
        }
        else if (generalBackModel.retcode != 0) {
            [self loginTimeExpiredToLogin];
        }
        
    }];
    
}

// 创建导航控制器
- (RTRootNavigationController *)NavigationControllerWithControllerName:(NSString *)controllerName {
    
    Class cls = NSClassFromString(controllerName);
    
    UIViewController *vc = [[cls alloc] init];
    
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = kMainColor;
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    
    return nav;
    
}

@end
