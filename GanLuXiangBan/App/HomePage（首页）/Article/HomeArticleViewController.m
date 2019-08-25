//
//  HomeArticleViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleViewController.h"

#import "HomeArticleView.h"
#import "SearchView.h"
#import "HomeArticleRequest.h"

#import "HomeArticlePreviewController.h"

@interface HomeArticleViewController ()
@property (nonatomic, strong) HomeArticleView *tableView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *publishedBtn;
@property (nonatomic, strong) UIButton *waitedBtn;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) BOOL showWaited;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, copy) NSString *searchWord;
@end

@implementation HomeArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"患教文章";
    [self setupViews];
    
    WS(weakSelf)
    [self addNavRightTitle:@"+新建" width:50 complete:^{
        
        UIViewController *add = [weakSelf loadVC:@"HomeAddArticleExplainController"];
        [weakSelf.navigationController pushViewController:add animated:YES];
        
    }];
    
    self.refresh = YES;
    [self refreshTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.refresh) {
        self.refresh = NO;
        self.pageNo = 1;
        [self loadArticles];
    }
}

- (void)loadArticles {
    NSInteger status = self.showWaited ? 0 : 1;
    if (!self.searchWord) {
        self.searchWord = @"";
    }
    
    WS(weakSelf)
    [[HomeArticleRequest new] articles:status pageNo:self.pageNo word:self.searchWord complete:^(HttpGeneralBackModel *model) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        NSMutableArray *array = [NSMutableArray array];
        if (weakSelf.pageNo > 1) {
            [array addObjectsFromArray:weakSelf.tableView.dataSources];
        }
        
        NSArray *list = model.data;
        if (list && list.count > 0) {
            list = [NSArray yy_modelArrayWithClass:HomeArticleModel.class json:list];
            [array addObjectsFromArray:list];
        }
        weakSelf.tableView.dataSources = array;
        
        NSInteger total = 10 * weakSelf.pageNo;
        NSDictionary *pageinfo = (NSDictionary *)(model.pageinfo);
        if (pageinfo && pageinfo[@"total"]) {
            total = [pageinfo[@"total"] integerValue];
        }
        weakSelf.tableView.mj_footer.hidden = array.count <= 0;
        BOOL flag = weakSelf.tableView.dataSources.count >= total;
        if (flag) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
}

- (void)touchShowArticleStatus:(UIButton *)button {
    if (![button isSelected]) {
        button.selected = YES;
        if (button == self.publishedBtn) {
            self.waitedBtn.selected = NO;
            self.showWaited = NO;
        }
        else {
            self.publishedBtn.selected = NO;
            self.showWaited = YES;
        }
        self.tableView.showWaited = self.showWaited;
        self.lineView.center = CGPointMake(button.centerX, CGRectGetMaxY(button.frame)+1.5);
        
        self.pageNo = 0;
        [self loadArticles];
    }
}

- (void)setupViews {
    if (!self.tableView) {
        self.tableView = [[HomeArticleView alloc] initWithFrame:CGRectZero];
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    self.tableView.sd_layout.topSpaceToView(self.headerView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    if (!(self.tableView.dataSources)) {
        self.tableView.dataSources = @[];
    }
    [self.tableView resetEmptyTips:@"暂无发表任何文章"];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 94)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        self.searchView = [[SearchView alloc] init];
        [_headerView addSubview:self.searchView];
        self.searchView.sd_layout.topSpaceToView(_headerView, 0).leftSpaceToView(_headerView, 0).rightSpaceToView(_headerView, 0).heightIs(50);
        
        self.publishedBtn = [self setupButton:@"已发布" tag:10];
        [_headerView addSubview:self.publishedBtn];
        self.publishedBtn.selected = YES;
        self.publishedBtn.sd_layout.topSpaceToView(self.searchView, 0).leftSpaceToView(_headerView, 0).bottomSpaceToView(_headerView, 0).widthRatioToView(_headerView, 0.5);
        
        self.waitedBtn = [self setupButton:@"未发布" tag:11];
        [_headerView addSubview:self.waitedBtn];
        self.waitedBtn.sd_layout.topSpaceToView(self.searchView, 0).leftSpaceToView(self.publishedBtn, 0).bottomSpaceToView(_headerView, 0).widthRatioToView(_headerView, 0.5);
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kPageBgColor;
        [_headerView addSubview:line];
        line.sd_layout.topSpaceToView(self.publishedBtn, 0).leftSpaceToView(_headerView, 0).rightSpaceToView(_headerView, 0).heightIs(1);
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 3)];
        self.lineView.backgroundColor = kMainColor;
        [_headerView addSubview:self.lineView];
        self.lineView.center = CGPointMake(ScreenWidth/4, 92.5);
        
        WS(weakSelf)
        self.searchView.searchConfirm = ^(NSString *key) {
            weakSelf.searchWord = key;
            weakSelf.pageNo = 1;
            weakSelf.tableView.dataSources = @[];
            [weakSelf loadArticles];
        };
    }
    return _headerView;
}

-(void)refreshTableView {
    
    WS(weakSelf)
    self.tableView.articleListTapItemBlock = ^(HomeArticleModel *model) {
        NSDictionary *dic = [model yy_modelToJSONObject];
        HomeArticleSaveModel *save = [HomeArticleSaveModel yy_modelWithJSON:dic];
        
        HomeArticlePreviewController *preview = (HomeArticlePreviewController *)[weakSelf loadVC:@"HomeArticlePreviewController"];
        preview.model = save;
        preview.canEdit = weakSelf.showWaited;
        [weakSelf.navigationController pushViewController:preview animated:YES];
    };
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.pageNo = 1;
        weakSelf.tableView.dataSources = @[];
        [weakSelf loadArticles];
        
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageNo++;
        [weakSelf loadArticles];
        
    }];
    self.tableView.mj_footer = footer;
    
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
}

- (UIButton *)setupButton:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.tag = tag;
    [btn setTitleColor:[UIColor colorWithHexString:@"0x999999"] forState:UIControlStateNormal];
    [btn setTitleColor:kMainColor forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchShowArticleStatus:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
