//
//  AppDelegate.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LogInViewController.h"
#import "FillInDataViewController.h"
#import "CertificationViewController.h"
#import "MessageViewController.h"
#import "SubscribeDetailsViewController.h"
#import "HelpWebViewController.h"
#import "ScheduleViewController.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#import <GTSDK/GeTuiSdk.h>

#import <Bugly/Bugly.h>

@interface AppDelegate () <GeTuiSdkDelegate, UNUserNotificationCenterDelegate>
@property (nonatomic, assign) BOOL showLogin;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    if (!GetUserDefault(UserPhone)) {
//        [self initLogIn];
//        SetUserDefault(UserCheck_status, @"3");
//    }else if ([GetUserDefault(UserCheck_status) integerValue] == 0  && GetUserDefault(UserCheck_status) != nil){
//        self.isLogined = YES;
//        [self initMainController];
//    }else if ([GetUserDefault(UserCheck_status) integerValue] == 1){
//        [self initFillInData];
//        SetUserDefault(UserCheck_status, @"3");
//    }else if ([GetUserDefault(UserCheck_status) integerValue] == 2){
//        [self initCertification];
//        SetUserDefault(UserCheck_status, @"3");
//    } else {
//        [self initLogIn];
//        SetUserDefault(UserCheck_status, @"3");
//    }
    
    [self initMainController];
    [WXApi registerApp:WeiXin_AppID];
    
#if DEBUG
    // for iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    // for tvOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
    // for masOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
#endif
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    
    [Bugly startWithAppId:@"01bf1fd179"];
    
    return YES;
}

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        // Fallback on earlier versions
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#pragma mark - Push

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //向个推服务器注册deviceToken 为了方便开发者，建议使用新方法
    [GeTuiSdk registerDeviceTokenData:deviceToken];
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    SetUserDefault(GeTuiDeviceId, token);
    KLog(@"注册token: %@ 【%@】", deviceToken, token);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 将收到的APNs信息传给个推统计
    KLog(@"============didReceiveRemoteNotification=====================");
    KLog(@"userInfo: %@", userInfo);
    KLog(@"didReceiveRemoteNotification end.");
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    
    KLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    KLog(@"didReceiveNotification：%@", userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    NSString *payload = [userInfo objectForKey:@"payload"];
    if (payload && payload.length > 0) {
        NSData *data = [payload dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (dic && [self.window.rootViewController isKindOfClass:RootViewController.class]) {
            /**
             1、2：{"type":"1", "mid":"4117","source":"1","msgid":"0","member_name":"患者Q"}
             3、4、9、10、11：{"type":"2", "pkid": 123}
             5：{"type":"3", "title":"", "url":""}
             6：{"type":"4", "uid": ""}
             7：不用传payload，提醒点击进入主页
             8：{"type":"5"}
             */
            NSInteger type = -1;
            if (dic[@"type"]) {
                type = [dic[@"type"] integerValue];
            }
            
            RootViewController *root = (RootViewController *)(self.window.rootViewController);
            UINavigationController *nav = (UINavigationController *)(root.selectedViewController);
            
            if (type == 1) {
                MessageViewController *messageView = [[MessageViewController alloc] init];
                messageView.mid = [NSString stringWithFormat:@"%@", dic[@"mid"]];
                messageView.msg_source = [NSString stringWithFormat:@"%@",dic[@"source"]];
                messageView.patientName = [NSString stringWithFormat:@"%@",dic[@"member_name"]];
                messageView.msg_flag = [NSString stringWithFormat:@"%@",dic[@"source"]];
                messageView.msgId = [NSString stringWithFormat:@"%@",dic[@"msg_id"]];
                messageView.title = messageView.patientName;
                messageView.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:messageView animated:YES];
            }
            else if (type == 2) {
                SubscribeDetailsViewController *detail = [SubscribeDetailsViewController new];
                detail.idString = [NSString stringWithFormat:@"%@", dic[@"pkid"]];
                detail.visitId = [NSString stringWithFormat:@"%@", dic[@"pkid"]];
                detail.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:detail animated:YES];
            }
            else if (type == 3) {
                HelpWebViewController *web = [HelpWebViewController new];
                web.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
                web.url = [NSString stringWithFormat:@"%@", dic[@"url"]];
                web.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:web animated:YES];
            }
            else if (type == 4) {
                NSString *uid = GetUserDefault(UserID);
                if (uid && uid.length > 0) {
                    CertificationViewController *certificationView = [[CertificationViewController alloc] init];
                    certificationView.title = @"资格认证";
                    certificationView.type = 1;
                    certificationView.hidesBottomBarWhenPushed = YES;
                    [nav pushViewController:certificationView animated:YES];
                }
            }
            else if (type == 5) {
                ScheduleViewController *schedule = [ScheduleViewController new];
                schedule.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:schedule animated:YES];
            }
        }
        else {
            NSInteger type = -1;
            if (dic[@"type"]) {
                type = [dic[@"type"] integerValue];
            }
            if (type == 4) {
                NSString *uid = GetUserDefault(UserID);
                if (uid && uid.length > 0) {
                    [self initCertification];
                }
            }
        }
    }
    
    completionHandler();
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    KLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

#pragma mark - 登录界面初始化

- (void)initLogIn {
    
    if (!self.showLogin) {
        LogInViewController *loginView = [[LogInViewController alloc] init];
        RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:loginView];
        self.window.rootViewController = nav;
        
        self.showLogin = YES;
    }
    
}

- (void)initMainController {
    self.window.rootViewController = [RootViewController new];
    self.showLogin = NO;
}

-(void)initFillInData{
    
    FillInDataViewController *fillInDataView = [[FillInDataViewController alloc] init];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:fillInDataView];
    self.window.rootViewController = nav;
    
    self.showLogin = NO;
    
}

-(void)initCertification{
    
    CertificationViewController *certificationView = [[CertificationViewController alloc] init];
    certificationView.title = @"资格认证";
    certificationView.type = 1;
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:certificationView];
    self.window.rootViewController = nav;
    
    self.showLogin = NO;
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
    
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WXApi handleOpenURL:url delegate:self];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
