//
//  SubscribeViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeView.h"
#import "SubscribeViewModel.h"

@interface SubscribeViewController ()

@property (nonatomic, strong) SubscribeView *subscribeView;
/// 类型 - 默认 2、电话预约   3、线下预约
@property (nonatomic, strong) NSString *preType;
/// 状态 - 默认 0、全部    1、成功 2、待处理 3、失败
@property (nonatomic, strong) NSString *opStatus;
/// 页数 - 默认 1
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) SubscribeCountModel *model;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.preType = @"2";
    self.opStatus = @"0";
    self.page = 1;
    [self setNavTitleView];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.subscribeView];
    self.subscribeView.sd_layout.topSpaceToView(self.headerView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getCount:self.preType];
}

- (void)setNavTitleView {
    
    NSArray *titles = @[@"电话预约", @"线下预约"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:titles];
    segment.frame = CGRectMake(0, 0, 120, 30);
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    
    @weakify(self);
    [[segment rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
     
        @strongify(self);
        UISegmentedControl *segment = (UISegmentedControl *)x;
        self.page = 1;
        self.opStatus = @"0";
        self.preType = [NSString stringWithFormat:@"%zd", segment.selectedSegmentIndex + 2];
        self.subscribeView.offlinePoint = segment.selectedSegmentIndex == 1;
        [self getCount:self.preType];
    }];
}

- (void)resetCount {
    if (self.model != nil) {
        
        NSArray *numbers = @[self.model.success_num, self.model.pend_num, self.model.fail_num];
        for (int i = 0; i < 3; i++) {
            
            UILabel *numberLabel = [self.headerView viewWithTag:i + 100];
            numberLabel.text = numbers[i];
        }
    }
}

#pragma mark - lazy
- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titles = @[@"预约成功", @"待处理", @"预约失败"];
        for (int i = 0; i < titles.count; i++) {
            
            UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            bgBtn.frame = CGRectMake(ScreenWidth / 3 * i, 0, ScreenWidth / 3, self.headerView.height);
            [_headerView addSubview:bgBtn];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, bgBtn.width, 15)];
            titleLabel.text = titles[i];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [bgBtn addSubview:titleLabel];
            
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 15, bgBtn.width, 25)];
            numberLabel.tag = i + 100;
            numberLabel.text = @"0";
            numberLabel.font = [UIFont boldSystemFontOfSize:20];
            numberLabel.textColor = kMainColor;
            numberLabel.textAlignment = NSTextAlignmentCenter;
            numberLabel.height = [numberLabel getTextHeight];
            [bgBtn addSubview:numberLabel];
            
            @weakify(self);
            [[bgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                self.opStatus = [NSString stringWithFormat:@"%@", @(i + 1)];
                [self getDataSource:self.preType opStatus:self.opStatus page:self.page];
                
                for (int i = 0; i < 3; i++) {
                    
                    UILabel *numberLabel = [self.headerView viewWithTag:i + 100];
                    numberLabel.textColor = kMainColor;
                }
                
                numberLabel.textColor = [UIColor redColor];
            }];
            
            _headerView.height = bgBtn.height = CGRectGetMaxY(numberLabel.frame) + 15;
            
            if (i > 0) {
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * i, 15, 0.5, bgBtn.height - 30)];
                lineView.backgroundColor = kLineColor;
                [_headerView addSubview:lineView];
            }
        }
    }
    return _headerView;
}

- (SubscribeView *)subscribeView {
    
    if (!_subscribeView) {
        
        _subscribeView = [[SubscribeView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        @weakify(self);
//        [self.subscribeView setSelectTypeBlock:^(NSInteger type) {
//
//            @strongify(self);
//            self.opStatus = [NSString stringWithFormat:@"%zd", type + 1];
//            [self getDataSource:self.preType opStatus:self.opStatus page:self.page];
//        }];
        
        [self.subscribeView setGoViewController:^(UIViewController *viewController) {
           
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
        self.subscribeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            [self getDataSource:self.preType opStatus:self.opStatus page:self.page];
        }];
        MJRefreshAutoNormalFooter *footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            @strongify(self);
            self.page++;
            [self getDataSource:self.preType opStatus:self.opStatus page:self.page];
            
        }];
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        self.subscribeView.mj_footer = footer;
    }
    
    return _subscribeView;
}


#pragma mark - request
- (void)getDataSource:(NSString *)preType opStatus:(NSString *)opStatus page:(NSInteger)page {
    
    NSString *p = [NSString stringWithFormat:@"%@", @(page)];
    WS(weakSelf)
    [[SubscribeViewModel new] getOrderApps:preType opStatus:opStatus page:p complete:^(id object) {
        
        if ([weakSelf.subscribeView.mj_header isRefreshing]) {
            [weakSelf.subscribeView.mj_header endRefreshing];
        }
        if ([weakSelf.subscribeView.mj_footer isRefreshing]) {
            [weakSelf.subscribeView.mj_footer endRefreshing];
        }
        
        NSArray *res = object;
        NSMutableArray *list = [[NSMutableArray alloc] init];
        if (page > 1) {
            [list addObjectsFromArray:weakSelf.subscribeView.dataSources];
        }
        if (res && res.count > 0) {
            [list addObjectsFromArray:res];
        }
        weakSelf.subscribeView.dataSources = list;
//        BOOL flag = weakSelf.subscribeView.dataSources.count >= 10*page;
//        if (flag) {
//            [weakSelf.subscribeView.mj_footer endRefreshingWithNoMoreData];
//        }
        NSInteger count = res ? res.count : 0;
        BOOL hidden = count <= 0 || (page == 1 && count < 10);
        weakSelf.subscribeView.mj_footer.hidden = hidden;
        
    }];
}


- (void)getCount:(NSString *)preType {
    WS(weakSelf)
    [[SubscribeViewModel new] getAppCount:preType complete:^(id object) {
        weakSelf.model = object;
        [weakSelf resetCount];
        [weakSelf getDataSource:preType opStatus:weakSelf.opStatus page:weakSelf.page];
    }];
}

@end
