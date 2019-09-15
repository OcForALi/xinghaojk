//
//  AddProductViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AddProductViewController.h"
#import "SearchView.h"
#import "DrugModel.h"
#import "LeftMenuView.h"
#import "DrugRequest.h"
#import "AddProductView.h"
#import "DrugListModel.h"
#import "ReApplicationViewController.h"
#import "DrugDetailsViewController.h"

@interface AddProductViewController ()

@property (nonatomic ,strong) SearchView *searchView;

@property (nonatomic ,strong) UIView *classificationView;

@property (nonatomic ,retain) NSMutableArray *leftDataSource;

@property (nonatomic ,strong) LeftMenuView *leftMenuView;

@property (nonatomic ,retain) DrugRequest *drugRequest;

@property (nonatomic ,copy) NSString *keywordString;

@property (nonatomic ,copy) NSString *drugClassID;

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) AddProductView *addProductView;

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加代理产品";
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(rightBar:)];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    [self initUI];
    
    [self block];

    [self refresh];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.page = 1;
    
    self.keywordString = @"";
    
    self.drugClassID = @"";
    
    [self request];
    
}

- (void)block{
    WS(weakSelf)
    [self.searchView setSearchConfirm:^(NSString *key) {
        
        weakSelf.page = 1;
        weakSelf.keywordString = key;
        weakSelf.drugClassID = @"";
        [weakSelf.addProductView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    [self.addProductView setAddPushBlock:^(DrugListModel * _Nonnull model) {
       
        ReApplicationViewController *reApplicationVC = [[ReApplicationViewController alloc] init];
        reApplicationVC.addModel = model;
        [weakSelf.navigationController pushViewController:reApplicationVC animated:YES];
        
    }];
    
    [self.addProductView setDurgPushBlock:^(DrugListModel * _Nonnull model) {
        
        DrugDetailsViewController *drugDetailsVC = [[DrugDetailsViewController alloc] init];
        drugDetailsVC.drugID = model.drug_id;
        [weakSelf.navigationController pushViewController:drugDetailsVC animated:YES];
        
    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.addProductView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.addProductView.dataSource removeAllObjects];
        [weakSelf request];
        
    }];
    
    self.addProductView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request];
        
    }];
}

- (void)request{
    
    WS(weakSelf)
    self.drugRequest = [DrugRequest new];
    [self.drugRequest getSearchDrugClass_id:self.drugClassID key:self.keywordString sort_col:0 is_desc:YES pageindex:self.page :^(HttpGeneralBackModel *model) {
        
        NSArray *array = model.data;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            DrugListModel *drugModel = [DrugListModel new];
            [drugModel setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:drugModel];
            
        }
        
        [weakSelf.addProductView addData:dataArray];
        
        [weakSelf.addProductView.myTable.mj_header endRefreshing];
        [weakSelf.addProductView.myTable.mj_footer endRefreshing];
        
    }];
    
}

- (void)initUI{
    
    self.searchView = [SearchView new];
    self.searchView.textField.placeholder = @"可输入产品名称或者厂家名称";
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.addProductView = [AddProductView new];
    [self.view addSubview:self.addProductView];
    
    self.addProductView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(self.view, 0);
    
}

- (void)rightBar:(UIBarButtonItem *)sender{
    
    self.classificationView = [UIView new];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.classificationView];
    
    self.classificationView.sd_layout
    .xIs(0)
    .yIs(0)
    .widthIs(ScreenWidth)
    .heightIs(ScreenHeight);
    
    [self classification];
    
}

-(void)classification{
    
    self.leftDataSource = [NSMutableArray array];
    DrugModel *drugModel = [DrugModel new];
    drugModel.name = @"全部";
    [self.leftDataSource addObject:drugModel];
    
    UIView *bgView = [UIView new];
    bgView .backgroundColor = RGBA(51, 51, 51, 0.7);
    bgView .userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [bgView  addGestureRecognizer:backTap];
    [self.classificationView addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.classificationView, 0)
    .rightSpaceToView(self.classificationView, 0)
    .topSpaceToView(self.classificationView, 0)
    .bottomSpaceToView(self.classificationView, 0);
    
    UILabel *label = [UILabel new];
    label.text = @"分类";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = kMainColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.classificationView addSubview:label];
    
    label.sd_layout
    .rightSpaceToView(self.classificationView, 0)
    .topSpaceToView(self.classificationView, 0)
    .widthIs(ScreenWidth/3)
    .heightIs(64);
    
    self.leftMenuView = [[LeftMenuView alloc] initWithFrame:CGRectMake(ScreenWidth - ScreenWidth / 3, 64, ScreenWidth / 3, ScreenHeight - self.navHeight-50) style:UITableViewStyleGrouped];
    self.leftMenuView.showDisease = YES;
    self.leftMenuView.backgroundColor = [UIColor whiteColor];
    self.leftMenuView.showsVerticalScrollIndicator = NO;
    self.leftMenuView.showsHorizontalScrollIndicator = NO;
    [self.classificationView addSubview:self.leftMenuView];
    
    self.leftMenuView.sd_layout
    .rightSpaceToView(self.classificationView, 0)
    .topSpaceToView(self.classificationView, 64)
    .widthIs(ScreenWidth/3)
    .heightIs(ScreenHeight - self.navHeight);
    
    WS(weakSelf)
    self.leftMenuView.didSelectBlock = ^(DrugModel *sec, DrugModel *row) {

        NSString *idString = @"";
        if (row) {
            idString = row.id;
        }
        else if (sec) {
            idString = sec.id;
        }
        weakSelf.page = 1;
        weakSelf.keywordString = @"";
        weakSelf.drugClassID = idString;
        [weakSelf.addProductView.dataSource removeAllObjects];
        [weakSelf request];
        
        
    };
    
    self.drugRequest = [DrugRequest new];
    [self.drugRequest getDrug:^(HttpGeneralBackModel *genneralBackModel) {
        
        for (NSDictionary *dict in genneralBackModel.data) {
            
            DrugModel *model = [DrugModel new];
            [model setValuesForKeysWithDictionary:dict];
            model.itmeArray = dict[@"items"];
            if (model.itmeArray && model.itmeArray.count > 0) {
                NSMutableArray *sec = [NSMutableArray new];
                for (NSDictionary *dic in model.itmeArray) {
                    DrugModel *secItem = [DrugModel new];
                    [secItem setValuesForKeysWithDictionary:dic];
                    [sec addObject:secItem];
                }
                model.itmeArray = sec;
            }
            [self.leftDataSource addObject:model];
            
        }
        
        self.leftMenuView.dataSources = self.leftDataSource;
        
    }];
    
}

-(void)back{
    
    [self.classificationView removeFromSuperview];
    
}

@end
