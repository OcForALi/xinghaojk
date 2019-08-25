//
//  PersonalViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalViewController.h"

#import "AppDelegate.h"

#import "PersonalView.h"
#import "PersonalInfoViewModel.h"

#import "RootViewController.h"

@interface PersonalViewController ()

@property (nonatomic, strong) PersonalView *personalView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PersonalViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"个人中心";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackgroundStopTimer) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterForegroundStartTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self setupSubviews];
    [self getInfo];
}
-(void)action{
    [self getInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self applicationEnterForegroundStartTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self applicationEnterBackgroundStopTimer];
    
}

- (void)applicationEnterBackgroundStopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)applicationEnterForegroundStartTimer {
    [self applicationEnterBackgroundStopTimer];
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setupSubviews {
    
    self.personalView = [[PersonalView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.tabBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.personalView];
    
    WS(weakSelf);
    [self.personalView setGoViewControllerBlock:^(UIViewController *viewController) {
        [weakSelf goViewController:viewController];
    }];
}

- (void)goViewController:(UIViewController *)viewController {
    
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)getInfo {
    BOOL logined = GLAppDelegate.isLogined;
    if (!logined) {
        return;
    }
    
    WS(weakSelf)
    [[PersonalInfoViewModel new] getDoctorInfoWithId:GetUserDefault(UserID) complete:^(PersonalInfoModel *model) {
        
        if (model) {
            weakSelf.personalView.model = model;
            
            SetUserDefault(UserKSName, model.Title);
        }
        else {
            [weakSelf applicationEnterBackgroundStopTimer];
            
            RootViewController *root = (RootViewController *)(weakSelf.tabBarController);
            if (root) {
                [root loginTimeExpiredToLogin];
            }
        }
        
    }];
    
    [[PersonalInfoViewModel new] getDoctorStaticData:^(PersonalStaticModel *model) {
        weakSelf.personalView.dataModel = model;
    }];
}

@end
