//
//  AppDelegate.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WXApi.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)initMainController;

- (void)initLogIn;

@property (nonatomic, assign) BOOL isLogined;

@end

