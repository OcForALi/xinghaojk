//
//  DrugListViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugListViewController.h"
#import "DrugRequest.h"
#import "DrugListModel.h"
#import "SortView.h"
#import "DrugList.h"
#import "DrugDetailsViewController.h"

@interface DrugListViewController ()

@property (nonatomic ,retain)DrugRequest *drugRequest;

@property (nonatomic, strong) SortView *sortView;

@property (nonatomic, strong) DrugList *drugListView;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) BOOL isDesc;

@property (nonatomic, assign) NSUInteger page;

@end

@implementation DrugListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"药品分类";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self block];
    
    [self refresh];
    
    self.idString = @"";
}

-(void)setSearchString:(NSString *)searchString{
    _searchString = searchString;
}

-(void)initUI{

    self.searchView = [SearchView new];
    if (self.searchString != nil) {
        [self.searchView setupSearchWord:self.searchString];
    }
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
//    self.sortView = [SortView new];
//    [self.view addSubview:self.sortView];
//
//    self.sortView.sd_layout
//    .leftSpaceToView(self.view, 0)
//    .rightSpaceToView(self.view, 0)
//    .topSpaceToView(self.searchView, 0)
//    .heightIs(50);
    
    self.drugListView = [DrugList new];
    [self.view addSubview:self.drugListView];
    
    self.drugListView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)setIdString:(NSString *)idString{
    
    _idString = idString;
    
    self.keyString = @"";
    
    self.sort = 0;
    
    self.isDesc = YES;
    
    self.page = 1;
    
    [self.drugListView.dataSource removeAllObjects];
    
    [self request:@"" sort:self.sort isDesc:self.isDesc];
    
}

-(void)request:(NSString *)key sort:(NSInteger)sort isDesc:(BOOL)isDesc{
    
    self.drugRequest = [DrugRequest new];
    WS(weakSelf)
    [self.drugRequest getSearchDrugClass_id:self.idString key:key sort_col:sort is_desc:isDesc pageindex:self.page :^(HttpGeneralBackModel *model) {
        
        NSArray *array = model.data;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            DrugListModel *drugModel = [DrugListModel new];
            [drugModel setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:drugModel];
            
        }
        
        [weakSelf.drugListView addData:dataArray];
        
        [weakSelf.drugListView.myTable.mj_header endRefreshing];
        [weakSelf.drugListView.myTable.mj_footer endRefreshing];
        
    }];
    
}

-(void)block{
    
    WS(weakSelf)
    
    [self.searchView setSearchConfirm:^(NSString *key) {
        
        weakSelf.keyString = key;
        
        weakSelf.sort = 0;
        
        weakSelf.isDesc = YES;
        
         weakSelf.page = 1;
        
        [weakSelf.drugListView.dataSource removeAllObjects];
        
        [weakSelf request:weakSelf.keyString sort:weakSelf.sort isDesc:weakSelf.isDesc];
        
    }];
    
    [self.sortView setSortBlock:^(NSInteger sort, BOOL isDesc) {

        weakSelf.sort = sort;
        
        weakSelf.isDesc = isDesc;
        
        weakSelf.page = 1;
        
        [weakSelf.drugListView.dataSource removeAllObjects];
        
        [weakSelf request:weakSelf.keyString sort:weakSelf.sort isDesc:weakSelf.isDesc];
        
    }];
    
    self.drugListView.pushBlock = ^(NSString *drugID) {
        
        DrugDetailsViewController *drugDetailsView = [[DrugDetailsViewController alloc] init];
        drugDetailsView.drugID = drugID;
        [weakSelf.navigationController pushViewController:drugDetailsView animated:YES];
        
    };
    
    self.drugListView.collectBlock = ^(DrugListModel *drugModel) {
        
        [[DrugRequest new] postFavDrugID:drugModel.drug_id :^(HttpGeneralBackModel *model) {
            
            if (model.retcode == 0) {

                drugModel.fav_id = 1;
                [weakSelf.drugListView.myTable reloadData];
//                weakSelf.page = 1;
//                [weakSelf.drugListView.dataSource removeAllObjects];
//                [weakSelf request:weakSelf.keyString sort:weakSelf.sort isDesc:weakSelf.isDesc];
                
            }
            
        }];
        
    };
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.drugListView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.drugListView.dataSource removeAllObjects];
        [weakSelf request:weakSelf.keyString sort:weakSelf.sort isDesc:weakSelf.isDesc];
        
    }];
    
    self.drugListView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        weakSelf.page++;
        [weakSelf request:weakSelf.keyString sort:weakSelf.sort isDesc:weakSelf.isDesc];
        
    }];
}

@end
