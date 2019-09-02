//
//  SelHospitalViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelHospitalViewController.h"
#import "SearchView.h"
#import "HospitalView.h"
#import "HospitalViewModel.h"

@interface SelHospitalViewController ()

@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) HospitalView *hospitalView;
@property (nonatomic, strong) HospitalViewModel *viewModel;
@property (nonatomic, assign) BOOL isQueryHospital;
@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation SelHospitalViewController
@synthesize hospitalView;
@synthesize viewModel;

- (void)viewDidLoad {

    [super viewDidLoad];

    [self createSearchView];
    self.pageNo = 1;
    [self getList];
}

// 创建搜索框
- (void)createSearchView {
    
    self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:self.searchView];
    
    @weakify(self);
    [self.searchView setSearchConfirm:^(NSString *key) {
        
        @strongify(self);
        if (self.hospitalView.cityString.length == 0) {
            
            if (!key || key.length == 0) {
                [self.view makeToast:@"请输入关键词进行搜索"];
            }
            else {
                self.pageNo = 1;
                [self queryHospitalWithTitle];
            }
        }
        else {
            self.pageNo = 1;
            [self queryHospitalWithTitle];
        }
        
    }];
}

#pragma mark - request
- (void)getList {
    
    WS(weakSelf)
    [self.viewModel getHospitalListComplete:^(id object) {
       
        if ([weakSelf.hospitalView.mj_header isRefreshing]) {
            [weakSelf.hospitalView.mj_header endRefreshing];
        }
        
        if (![object isKindOfClass:[NSError class]]) {
            weakSelf.hospitalView.dataSources = object;
        }
    }];
}

- (void)queryHospitalWithTitle {
    self.isQueryHospital = YES;
    
    NSString *title = self.searchView.textField.text;
    WS(weakSelf)
    [self.viewModel queryHospital:title city:self.hospitalView.cityString pageNo:self.pageNo complete:^(id object) {
        [weakSelf.hospitalView.mj_header endRefreshing];
        [weakSelf.hospitalView.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        if (weakSelf.pageNo > 1) {
            [array addObjectsFromArray:weakSelf.hospitalView.dataSources];
        }
        NSInteger page = 0;
        if (object && [object isKindOfClass:NSArray.class]) {
            NSArray *res = object;
            [array addObjectsFromArray:res];
            page = res.count;
        }
        
        if (array.count > 0) {
            weakSelf.hospitalView.mj_footer.hidden = NO;
            if (page < 10) {
                [weakSelf.hospitalView.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                [weakSelf.hospitalView.mj_footer setState:MJRefreshStateIdle];
            }
        }
        else if (array.count == 0) {
            weakSelf.hospitalView.mj_footer.hidden = YES;
        }
        weakSelf.hospitalView.dataSources = array;
        
    }];
}

#pragma mark - lazy
- (HospitalViewModel *)viewModel {
    
    if (!viewModel) {
        viewModel = [HospitalViewModel new];
    }
    
    return viewModel;
}

- (HospitalView *)hospitalView {
    
    if (!hospitalView) {
        
        hospitalView = [[HospitalView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), ScreenWidth, self.view.height - CGRectGetMaxY(self.searchView.frame)) style:UITableViewStyleGrouped];
        [self.view addSubview:hospitalView];
        
        @weakify(self);
        [hospitalView setDidSelectBlock:^(NSString *hid, NSString *string) {
         
            @strongify(self);
            NSDictionary *dic = @{@"hid":hid, @"name":string};
            self.completeBlock(dic);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [RACObserve(self.hospitalView, cityString) subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            if (self.hospitalView.cityString.length > 0) {
                self.pageNo = 1;
                [self queryHospitalWithTitle];
            }
        }];
        
        WS(weakSelf)
        self.hospitalView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if (weakSelf.isQueryHospital) {
                weakSelf.pageNo = 1;
                [weakSelf queryHospitalWithTitle];
            }
            else {
                [weakSelf getList];
            }
            
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            weakSelf.pageNo++;
            [weakSelf queryHospitalWithTitle];
            
        }];
        self.hospitalView.mj_footer = footer;
        footer.hidden = YES;
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    }
    
    return hospitalView;
}

@end
