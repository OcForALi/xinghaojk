//
//  PersonalViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalViewModel.h"
#import "PersonalView.h"

@interface PersonalViewController ()

@property (nonatomic, strong) PersonalView *personalView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PersonalViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"个人中心";
    
    [self setupSubviews];
    [self getDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getDataSource];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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


#pragma mark - request
- (void)getDataSource {
    
    PersonalViewModel *viewModel = [PersonalViewModel new];
    [viewModel getDataSource:^(PersonalModel * model) {
        
        if (model) {
            
            [model log];
        
            self.personalView.model = model;
        }
    }];
}

@end
