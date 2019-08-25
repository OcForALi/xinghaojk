//
//  DocCircleExtentionController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleExtentionController.h"

#import "DocCircleExtentionTableView.h"
#import "DocCircleRequest.h"
#import "DocCircleFilterView.h"

@interface DocCircleExtentionController ()
@property (nonatomic, strong) DocCircleExtentionTableView *tableView;
@property (nonatomic, strong) DocCircleFilterView *filterView;

@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *keyword;
@end

@implementation DocCircleExtentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(weakSelf)
    [self addNavRightTitle:@"筛选" complete:^{
        [weakSelf touchFilterDatas];
    }];
    
    self.tableView = [[DocCircleExtentionTableView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    if (self.model) {
        [self resetTitles:NO];
        [self loadExtentionDatas];
    }
}

- (void)touchFilterDatas {
    if (!self.filterView) {
        self.filterView = [[DocCircleFilterView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.filterView];
    }
    WS(weakSelf)
    [self.filterView showFilterView:^(NSString *start, NSString *end, NSString *keyword) {
        weakSelf.keyword = keyword;
        weakSelf.startDate = start;
        weakSelf.endDate = end;
        [weakSelf loadExtentionDatas];
    }];
}

- (void)loadExtentionDatas {
//    BOOL isScreen = NO;
//    if (self.keyword && self.keyword.length > 0) {
//        isScreen = YES;
//    }
//    else if (self.startDate && self.startDate.length > 0) {
//        isScreen = YES;
//    }
//    else if (self.endDate && self.endDate.length > 0) {
//        isScreen = YES;
//    }
    WS(weakSelf)
    [[DocCircleRequest new] doctors:self.keyword startDate:self.startDate endDate:self.endDate isScreen:YES complete:^(HttpGeneralBackModel *object) {
        if (object.retcode == 0 && object.data) {
            weakSelf.model = [DocCircleModel yy_modelWithJSON:object.data];
            [weakSelf resetTitles:YES];
            weakSelf.tableView.dataSources = weakSelf.model.dr_order_detail;
        }
        else if (object.retmsg) {
            [weakSelf.view makeToast:object.retmsg];
        }
    }];
}

- (void)resetTitles:(BOOL)isScreen {
    NSString *tt = @"扩展医生";
    if (self.type == DocCircleShowTypeMoney) {
        tt = @"开单金额";
        if (self.model) {
            if (isScreen) {
                tt = [tt stringByAppendingFormat:@"（%.2f）", self.model.sumAmount_query];
            }
            else {
                tt = [tt stringByAppendingFormat:@"（%@）", self.model.sumAmount];
            }
        }
    }
    else if (self.type == DocCircleShowTypeNum) {
        tt = @"开单数量";
        if (self.model) {
            if (isScreen) {
                tt = [tt stringByAppendingFormat:@"（%@）", @(self.model.sumOrder_query)];
            }
            else {
                tt = [tt stringByAppendingFormat:@"（%@）", self.model.sumOrder];
            }
        }
    }
    else if (self.model) {
        if (isScreen) {
            tt = [tt stringByAppendingFormat:@"（%@）", @(self.model.sumDoctor_query)];
        }
        else {
            tt = [tt stringByAppendingFormat:@"（%@）", self.model.sumDoctor];
        }
    }
    self.title = tt;
    
}

@end
