//
//  MyPointsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyPointsViewController.h"
#import "IntegralDetailsViewController.h"
#import "MyPointsView.h"
#import "MyPointsViewModel.h"

@interface MyPointsViewController ()

@property (nonatomic, strong) MyPointsView *myPointsView;

@end

@implementation MyPointsViewController
@synthesize myPointsView;

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getPoints];
}

#pragma mark - lazy
- (MyPointsView *)myPointsView {
    
    if (!myPointsView) {
        
        myPointsView = [[MyPointsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height)];
        myPointsView.backgroundColor = kPageBgColor;
        [self.view addSubview:self.myPointsView];
        
        @weakify(self);
        [self.myPointsView setGoViewControllerBlock:^(UIViewController *viewController) {
            
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return myPointsView;
}

#pragma makr - request
/// 获取积分
- (void)getPoints {
    
    MyPointsViewModel *viewModel = [MyPointsViewModel new];
    [viewModel getPointWithPage:1 recordType:@"0" pointDate:@"0" detailType:@"all" complete:^(id object) {

        if (![object isKindOfClass:[NSError class]]) {
            self.myPointsView.model = object[0];
        }
    }];
}

@end
