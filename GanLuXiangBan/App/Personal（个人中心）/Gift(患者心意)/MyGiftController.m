//
//  MyGiftController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyGiftController.h"

#import "MyGiftView.h"
#import "MyGiftRequest.h"

@interface MyGiftController ()
@property (nonatomic, strong) MyGiftView *tableView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation MyGiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"患者心意";
    self.pageNo = 1;
    [self setupUI];
    [self requestStatic];
    [self requestList];
}

- (NSInteger)checkValue:(NSDictionary *)dic key:(NSString *)key {
    if (dic && dic[key] && ![dic[key] isKindOfClass:NSNull.class]) {
        return [dic[key] integerValue];
    }
    return 0;
}

- (void)requestStatic {
    WS(weakSelf)
    [[MyGiftRequest new] getStatic:^(HttpGeneralBackModel *model) {
        if (model && model.data) {
            NSDictionary *dic = model.data;
            NSInteger mind = [weakSelf checkValue:dic key:@"mind_count"];
            NSInteger flower = [weakSelf checkValue:dic key:@"flower_count"];
            NSInteger pennant = [weakSelf checkValue:dic key:@"pennant_count"];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.leftLabel.text = [NSString stringWithFormat:@"%@", @(mind)];
                weakSelf.middleLabel.text = [NSString stringWithFormat:@"%@", @(flower)];
                weakSelf.rightLabel.text = [NSString stringWithFormat:@"%@", @(pennant)];
            });
        }
    }];
}

- (void)requestList {
    WS(weakSelf)
    [[MyGiftRequest new] getPage:self.pageNo complete:^(HttpGeneralBackModel *model) {
        if ([weakSelf.tableView.mj_header isRefreshing]) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        if ([weakSelf.tableView.mj_footer isRefreshing]) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        NSMutableArray *list = [[NSMutableArray alloc] init];
        if (weakSelf.pageNo > 1) {
            [list addObjectsFromArray:weakSelf.tableView.dataSources];
        }
        if (model && model.data) {
            for (NSDictionary *dic in model.data) {
                MyGiftModel *gift = [MyGiftModel new];
                [gift setValuesForKeysWithDictionary:dic];
                [list addObject:gift];
            }
        }
        weakSelf.tableView.mj_footer.hidden = list.count < weakSelf.pageNo * 10;
        weakSelf.tableView.dataSources = list;
    }];
}

- (UILabel *)setupLabel:(NSString *)title type:(NSInteger)type view:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontRegular(14);
    label.textColor = type == 1 ? kMainColor : kSixColor;
    label.text = title;
    [view addSubview:label];
    return label;
}

- (void)setupUI {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    UILabel *left = [self setupLabel:@"心意" type:0 view:headerView];
    UILabel *middle = [self setupLabel:@"送花" type:0 view:headerView];
    UILabel *right = [self setupLabel:@"锦旗" type:0 view:headerView];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right);
        make.top.height.width.equalTo(left);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(middle.mas_right);
        make.top.height.width.equalTo(left);
    }];
    
    self.leftLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.middleLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.rightLabel = [self setupLabel:@"0" type:1 view:headerView];;
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(left.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right);
        make.top.height.width.equalTo(self.leftLabel);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(self.middleLabel.mas_right);
        make.top.height.width.equalTo(self.leftLabel);
    }];
    UIView *sep = [[UIView alloc] init];
    sep.backgroundColor = kPageBgColor;
    [headerView addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    self.tableView = [MyGiftView new];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
    }];
    
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestList];
    }];
    MJRefreshAutoNormalFooter *footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageNo++;
        [weakSelf requestList];
        
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
}

@end
