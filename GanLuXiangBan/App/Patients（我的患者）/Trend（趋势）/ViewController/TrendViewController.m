//
//  TrendViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TrendViewController.h"
#import "TrendView.h"
#import "TrendViewModel.h"
#import "ScreeningViewController.h"
#import "CheckListDetailsViewModel.h"

@interface TrendViewController ()

@property (nonatomic, strong) TrendView *trendView;

@end

@implementation TrendViewController
@synthesize trendView;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"趋势图";
    [self getDataSource];
    
    @weakify(self);
    [self addNavRightTitle:@"筛选" complete:^{
       
        @strongify(self);
        
        ScreeningViewController *vc = [ScreeningViewController new];
        vc.allTypes = self.items;
        vc.title = @"筛选";
        [self.navigationController pushViewController:vc animated:YES];
        vc.didBackToTrendVCBlock = ^{
            
            NSMutableArray *codes = [NSMutableArray new];
            for (CheckDemoModel *demo in self.items) {
                if (demo.isSelect) {
                    [codes addObject:demo.chk_item_code];
                }
            }
            [self getTrendDatas:codes];

        };
        
    }];
}


- (TrendView *)trendView {
    
    if (!trendView) {
        
        trendView = [[TrendView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight)];
        trendView.backgroundColor = kPageBgColor;
        [self.view addSubview:trendView];
    }
    
    return trendView;
}


#pragma mark - request

- (void)getTrendDatas:(NSArray *)items {
    [[TrendViewModel new] getChkTrend:self.midString chkTypeId:self.chkTypeId items:items complete:^(id object) {
        self.trendView.model = object;
    }];
}

- (void)getDataSource {
    WS(weakSelf)
    [[CheckListDetailsViewModel new] getDemoItems:self.chkTypeId complete:^(HttpGeneralBackModel *model) {
        
        if (model.data) {
            NSArray *res = model.data;
            NSMutableArray *list = [NSMutableArray new];
            NSMutableArray *codes = [NSMutableArray new];
            for (NSDictionary *dic in res) {
                CheckDemoModel *demo = [CheckDemoModel new];
                [demo setValuesForKeysWithDictionary:dic];
                demo.isSelect = YES;
                [list addObject:demo];
                [codes addObject:demo.chk_item_code];
            }
            weakSelf.items = list;
            weakSelf.trendView.items = list;
            [weakSelf getTrendDatas:codes];
        }
        
    }];
}


@end
