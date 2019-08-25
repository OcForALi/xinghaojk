//
//  CollectionViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CollectionViewController.h"
#import "SearchView.h"
#import "DrugRequest.h"
#import "DrugList.h"
#import "DrugDetailsViewController.h"
#import "DrugListModel.h"
#import "DrugListViewController.h"

@interface CollectionViewController ()

@property (nonatomic ,retain) DrugRequest *drugRequest;

@property (nonatomic ,strong) SearchView *searchView;

@property (nonatomic, strong) DrugList *drugListView;

@property (nonatomic ,copy) NSString *keyString;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic ,assign) BOOL isEdit;

@property (nonatomic ,strong) UIBarButtonItem *rightBarBtn;

@property (nonatomic ,strong) UIButton *collectionButton;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常用药";
    
    [self initUI];
    
    [self block];
    
    [self refresh];
    
    [self initNav];
    
    self.keyString = @"";
    
    self.page = 1;
    
    [self request:self.keyString page:self.page];
    
}

-(void)initUI{
    
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    UIButton *add = [self setupBottomButton:@"新增常用药"];
    [add addTarget:self action:@selector(touchAddCommonlyDrug) forControlEvents:UIControlEventTouchUpInside];
    
    self.drugListView = [DrugList new];
    self.drugListView.Type = 1;
    [self.view addSubview:self.drugListView];
    
    self.drugListView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(add, 0);
    
    self.collectionButton = [UIButton new];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.collectionButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton setBackgroundColor: [UIColor lightGrayColor]];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton.hidden = YES;
    [self.view addSubview:self.collectionButton];
    
    self.collectionButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
}

- (void)touchAddCommonlyDrug {
    DrugListViewController *vc = [[DrugListViewController alloc] init];
    vc.title = @"药品目录";
    [self.navigationController pushViewController:vc  animated:YES];
}

-(void)initNav{
    
    self.isEdit = NO;
    
    self.rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBar:)];
    self.rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.rightBarBtn;
    
}

-(void)rightBar:(UIBarButtonItem *)sender{
    
    if (self.isEdit == YES) {
        
        self.isEdit = NO;
        
        self.rightBarBtn.title = @"编辑";
        
        self.drugListView.Type = 1;
        
        self.collectionButton.hidden = YES;
        
    }else{
        
        self.isEdit = YES;
        
        self.rightBarBtn.title = @"完成";
        
        self.drugListView.Type = 3;
        
        self.collectionButton.hidden = NO;
        
    }
    
}

-(void)block{
    
    WS(weakSelf)
    
    [self.searchView setSearchConfirm:^(NSString *key) {
        
        weakSelf.page = 1;
        
        weakSelf.keyString = key;
        
        [weakSelf.drugListView.dataSource removeAllObjects];
        
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.drugListView.pushBlock = ^(NSString *drugID) {
        
        DrugDetailsViewController *drugDetailsView = [[DrugDetailsViewController alloc] init];
        drugDetailsView.drugID = drugID;
        [weakSelf.navigationController pushViewController:drugDetailsView animated:YES];
        
    };
    
    self.drugListView.selectedDeleteBlock = ^(NSArray *array) {
        
        if (array.count > 0) {
            [weakSelf.collectionButton setBackgroundColor:[UIColor redColor]];
        }else{
            [weakSelf.collectionButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        
    };
    
}

-(void)request:(NSString *)key page:(NSInteger)page{
    
    self.drugRequest = [DrugRequest new];
    
    WS(weakSelf)
    [self.drugRequest getDrFavDrugsclass_id:0 Key:key pageindex:page :^(HttpGeneralBackModel *model) {
       
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

-(void)refresh{
    
    WS(weakSelf)
    self.drugListView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.drugListView.dataSource removeAllObjects];
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.drugListView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
}

-(void)collection:(UIButton *)sender{
    
    if (self.drugListView.pkids.count > 0) {
        WS(weakSelf);
        [[DrugRequest new] postDelDrFavDrug:self.drugListView.pkids :^(HttpGeneralBackModel *model) {
            
            if (model.retcode == 0) {
                
                weakSelf.isEdit = NO;
                weakSelf.rightBarBtn.title = @"编辑";
                
                [weakSelf.drugListView.pkids removeAllObjects];
                [weakSelf.drugListView.dataSource removeAllObjects];
                weakSelf.drugListView.Type = 1;
                weakSelf.page = 1;
                weakSelf.collectionButton.hidden = YES;
                [weakSelf request:weakSelf.keyString page:weakSelf.page];
                
            }
            
        }];
        
    }
    
}

@end
