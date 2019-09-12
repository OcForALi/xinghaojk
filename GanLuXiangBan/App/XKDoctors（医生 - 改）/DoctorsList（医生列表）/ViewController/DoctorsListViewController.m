//
//  DoctorsListViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/6.
//  Copyright © 2019 CICI. All rights reserved.
//

// ViewController
#import "DoctorsListViewController.h"
#import "DoctorDetailsViewController.h"
// ViewModel
#import "DoctorsListViewModel.h"
// View
#import "DoctorsListView.h"
#import "SearchView.h"

@interface DoctorsListViewController ()

@property (nonatomic, strong) DoctorsListView *listView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) NSString *keyStr;
@property (nonatomic, assign) int page;

@end

@implementation DoctorsListViewController
@synthesize listView;
@synthesize searchView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的医生";
    self.keyStr = @"";
    self.page = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getList];
}


#pragma mark - lazy
- (DoctorsListView *)listView {
    
    if (!listView) {
        
        listView = [[DoctorsListView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        listView.y = self.searchView.maxY;
        listView.height = ScreenHeight - listView.y - self.tabBarHeight;
        [self.view addSubview:listView];
        
        @weakify(self);
        [self.listView setDidSelectBlock:^(DoctorsListModel * _Nonnull model) {
           
            @strongify(self);
            DoctorDetailsViewController *vc = [DoctorDetailsViewController new];
            vc.idStr = model.drid;
            vc.name = model.drname;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    
    return listView;
}

- (SearchView *)searchView {
    
    if (!searchView) {
        
        searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
        searchView.textField.placeholder = @"请输入医生的名字";
        [self.view addSubview:searchView];
        
        @weakify(self);
        [self.searchView setSearchConfirm:^(NSString *key) {
            
            @strongify(self);
            self.keyStr = key;
            [self getList];
        }];
        
        [self.searchView setSearchBlock:^(NSString *text) {
            
            @strongify(self);
            if (text.length == 0) {
                
                self.keyStr = @"";
                [self getList];
            }
        }];
    }
    
    return searchView;
}


#pragma mark - request
- (void)getList {
    
    DoctorsListViewModel *viewModel = [DoctorsListViewModel new];
    [viewModel getDataSourceWithKey:self.keyStr page:self.page complete:^(NSDictionary *dataSource) {
        self.listView.dataDict = dataSource;
        self.dataDict = dataSource;
    }];
}

@end
