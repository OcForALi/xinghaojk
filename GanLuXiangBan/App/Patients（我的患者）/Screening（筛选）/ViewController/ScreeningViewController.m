//
//  ScreeningViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ScreeningViewController.h"
#import "ScreeningView.h"

@interface ScreeningViewController ()

@property (nonatomic, strong) ScreeningView *screeningView;

@end

@implementation ScreeningViewController
@synthesize screeningView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.screeningView.dataSources = self.allTypes;
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    if (self.didBackToTrendVCBlock) {
        self.didBackToTrendVCBlock();
    }
}


- (ScreeningView *)screeningView {
    
    if (!screeningView) {
        
        screeningView = [[ScreeningView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:screeningView];
    }
    
    return screeningView;
}

@end
