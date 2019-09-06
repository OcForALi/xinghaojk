//
//  IntegralDetailsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "IntegralDetailsViewController.h"
#import "IntegralDetailsView.h"
#import "MyPointModel.h"
#import "MyPointsViewModel.h"
#import "MyPointDetailsModel.h"

@interface IntegralDetailsViewController ()

@property (nonatomic, strong) MyPointsViewModel *viewModel;
@property (nonatomic, strong) IntegralDetailsView *integralDetailsView;

@property (nonatomic, strong) NSString *recordType;
@property (nonatomic, strong) NSString *pointDate;
@property (nonatomic, assign) NSInteger page;

@end

@implementation IntegralDetailsViewController
@synthesize integralDetailsView;
@synthesize viewModel;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"积分明细";
    self.recordType = @"0";
    self.pointDate = @"";
    self.page = 1;
    [self getListWithPage:self.page];
    [self timeHeaderView];
}

- (void)timeHeaderView {
    
    UIView *timeHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    timeHeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeHeaderView];
    
    NSArray *titles = @[@"积分类型", @"记录类型", @"积分时间"];//@"近6个月"];
    NSInteger count = titles.count;
    WS(weakSelf)
    for (int i = 0; i < count; i++) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(ScreenWidth / count * i, 0, ScreenWidth / count, timeHeaderView.height);
        bgButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [bgButton setTitle:titles[i] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor colorWithHexString:@"0x333333"] forState:UIControlStateNormal];
        [bgButton setImage:[UIImage imageNamed:@"SubscriptImg"] forState:UIControlStateNormal];
        [bgButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -bgButton.imageView.size.width, 0, bgButton.imageView.size.width)];
        [bgButton setImageEdgeInsets:UIEdgeInsetsMake(0, bgButton.titleLabel.bounds.size.width, 0, -bgButton.titleLabel.bounds.size.width)];
        [timeHeaderView addSubview:bgButton];
        if (self.showZTPoint && i == 0) {
            [bgButton setTitle:@"在途积分" forState:UIControlStateNormal];
        }
        
        [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            UIButton *tempBtn = (UIButton *)x;
            
            NSArray *titles = @[@"所有记录", @"收入记录", @"支出记录"];
            if (i == 0) {
                titles = @[@"所有积分", @"在途积分"];
            }
            else if (i == 2) {
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
                NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
                NSInteger year = [components year];
                NSInteger month = [components month];
                
                NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"近6个月", @"本月"]];
                for (int i = 1; i < 6; i++) {
                    month--;
                    if (month < 1) {
                        year--;
                        month = 12;
                    }
                    [arr addObject:[NSString stringWithFormat:@"%zd年%zd月", year, month]];
                }
                titles = arr;
            }
            
            [self actionSheetWithTitle:nil titles:titles isCan:YES completeBlock:^(NSInteger index) {
                
                if (index != 0) {
                    
                    [tempBtn setTitle:titles[index - 1] forState:UIControlStateNormal];
                    [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -tempBtn.imageView.size.width, 0, tempBtn.imageView.size.width)];
                    [tempBtn setImageEdgeInsets:UIEdgeInsetsMake(0, tempBtn.titleLabel.bounds.size.width, 0, -tempBtn.titleLabel.bounds.size.width)];
                    
                    if (i == 0) {
                        weakSelf.showZTPoint = index - 1 == 1;
                    }
                    else if (i == 1) {
                        weakSelf.recordType = [NSString stringWithFormat:@"%@", @(index - 1)];
                        weakSelf.recordType = index - 1 == 2 ? @"-1" : self.recordType;
                    }
                    else {
                        if (index == 1) {
                            weakSelf.pointDate = @"";
                        }
                        else if (index == 2) {
                            weakSelf.pointDate = @"0";
                        }
                        else {
                            weakSelf.pointDate = [NSString stringWithFormat:@"-%@", @(index - 2)];
                        }
                    }
                    
                    weakSelf.page = 1;
                    weakSelf.integralDetailsView.keys = @[];
                    weakSelf.integralDetailsView.dictDataSource = @{};
                    weakSelf.integralDetailsView.mj_footer.hidden = YES;
                    [weakSelf getListWithPage:weakSelf.page];
                }
            }];
        }];
    }
    
    // 线
    for (NSInteger i = 1; i < titles.count; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / titles.count * i - 0.5, 5, 1, timeHeaderView.height - 10)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [timeHeaderView addSubview:lineView];
    }
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, timeHeaderView.height - 1, ScreenWidth, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [timeHeaderView addSubview:bottomLineView];
}

#pragma mark - request
- (void)getListWithPage:(NSInteger)page {
    NSString *type = self.showZTPoint ? @"zaiTu" : @"all";
    [self.viewModel getPointWithPage:page recordType:self.recordType pointDate:self.pointDate detailType:type complete:^(id object) {
       
        [self.integralDetailsView.mj_header endRefreshing];
        [self.integralDetailsView.mj_footer endRefreshing];
        
        if (![object isKindOfClass:[NSError class]]) {
            
            MyPointModel *model = object[0];
            NSInteger count = 0;
            if (self.page == 1) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                NSMutableArray *keys = [NSMutableArray array];
                for (MyPointDetailsModel *pointDetailsModel in model.detailList) {
                    
                    if ([[dict allKeys] containsObject:pointDetailsModel.year_month]) {
                        
                        NSMutableArray *array = [NSMutableArray arrayWithArray:dict[pointDetailsModel.year_month]];
                        [array addObject:pointDetailsModel];
                        [dict setObject:array forKey:pointDetailsModel.year_month];
                        count += array.count;
                        
                        if (![keys containsObject:pointDetailsModel.year_month]) {
                            [keys addObject:pointDetailsModel.year_month];
                        }
                    }
                    else {
                        
                        [dict setObject:@[pointDetailsModel] forKey:pointDetailsModel.year_month];
                        [keys addObject:pointDetailsModel.year_month];
                    }
                }
                
                self.integralDetailsView.keys = keys;
                self.integralDetailsView.dictDataSource = dict;
                [self.integralDetailsView.mj_footer resetNoMoreData];
            }
            else {
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.integralDetailsView.dictDataSource];
                NSMutableArray *keys = [NSMutableArray arrayWithArray:self.integralDetailsView.keys];
                for (MyPointDetailsModel *pointDetailsModel in model.detailList) {
                    
                    if ([[dict allKeys] containsObject:pointDetailsModel.year_month]) {
                        
                        NSMutableArray *array = [NSMutableArray arrayWithArray:dict[pointDetailsModel.year_month]];
                        [array addObject:pointDetailsModel];
                        [dict setObject:array forKey:pointDetailsModel.year_month];
                        count += array.count;
                        if (![keys containsObject:pointDetailsModel.year_month]) {
                            [keys addObject:pointDetailsModel.year_month];
                        }
                    }
                    else {
                        
                        [dict setObject:@[pointDetailsModel] forKey:pointDetailsModel.year_month];
                        [keys addObject:pointDetailsModel.year_month];
                    }
                }
                
                self.integralDetailsView.keys = keys;
                self.integralDetailsView.dictDataSource = dict;
            }
            self.integralDetailsView.mj_footer.hidden = count < 10;
        }
    }];
}

#pragma mark - lazy
- (IntegralDetailsView *)integralDetailsView {
    
    if (!integralDetailsView) {
        
        integralDetailsView = [[IntegralDetailsView alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:integralDetailsView];
        
        WS(weakSelf)
        integralDetailsView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.page = 1;
            [weakSelf getListWithPage:weakSelf.page];
        }];
        
        integralDetailsView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           
            weakSelf.page += 1;
            [weakSelf getListWithPage:weakSelf.page];
        }];
        integralDetailsView.mj_footer.hidden = YES;
        
        integralDetailsView.goViewControllerBlock = ^(UIViewController *viewController) {
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
    }
    
    return integralDetailsView;
}

- (MyPointsViewModel *)viewModel {
    
    if (!viewModel) {
        viewModel = [MyPointsViewModel new];
    }
    
    return viewModel;
}

@end
