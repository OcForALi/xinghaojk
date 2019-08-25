//
//  CheckListViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListView.h"
#import "CheckListViewModel.h"

@interface CheckListViewController ()

@property (nonatomic, strong) CheckListView *checkListView;

@end

@implementation CheckListViewController
@synthesize checkListView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"检查单列表";
    
    [self getDataSource];
}


#pragma mark - lazy
- (CheckListView *)checkListView {
    
    if (!checkListView) {
        
        checkListView = [[CheckListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:checkListView];
        
        @weakify(self);
        [checkListView setGoViewController:^(UIViewController *viewController) {
           
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return checkListView;
}


#pragma mark - request
- (void)getDataSource {
    
    [[CheckListViewModel new] getChkTypeListWithMid:self.mid complete:^(id object) {
        self.checkListView.dataSources = object;
    }];
}

@end

