//
//  CommonlyDrugViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/6.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CommonlyDrugViewController.h"
#import "DrugRequest.h"
#import "SearchView.h"
#import "DrugList.h"
#import "DrugListModel.h"

#import "AddDrugUseController.h"
#import "DrugDetailsViewController.h"
#import "DrugViewController.h"

@interface CommonlyDrugViewController ()

@property (nonatomic ,retain)DrugRequest *drugRequest;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, strong) DrugList *drugListView;

@property (nonatomic, assign) NSUInteger page;

//@property (nonatomic ,strong) AddDrugsView *addDrugsView;

@end

@implementation CommonlyDrugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self block];
    
    [self refresh];
    
    self.keyString = @"";
    
}

-(void)initUI{
    
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.drugListView = [DrugList new];
    self.drugListView.Type = 2;
    self.drugListView.showAll = self.showAll;
    [self.view addSubview:self.drugListView];
    
    UIButton *add = [self setupBottomButton:@"新增常用药"];
    [add addTarget:self action:@selector(touchAddCommonlyDrug) forControlEvents:UIControlEventTouchUpInside];
    
//    CGFloat height = ScreenHeight-90-64-kNavbarSafeHeight;
//    if (self.showAll) {
//        height = ScreenHeight-50-64-kNavbarSafeHeight;
//    }
    self.drugListView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(add, 0);
    
    if (!self.drugListView.drug_idArray) {
        self.drugListView.drug_idArray = self.array;
    }
}

- (void)touchAddCommonlyDrug {
    DrugViewController *vc = [[DrugViewController alloc] init];
    [self.navigationController pushViewController:vc  animated:YES];
}

-(void)setArray:(NSArray *)array{
    
    _array = array;
    
    self.drugListView.drug_idArray = array;
    
}

-(void)setKeyString:(NSString *)keyString{
    
    _keyString = keyString;
    
    self.page = 1;
    [self.drugListView.dataSource removeAllObjects];
    [self request:keyString page:self.page];
}

-(void)setIdString:(NSString *)idString{
    
    _idString = idString;
    
    self.page = 1;
    
    [self.drugListView.dataSource removeAllObjects];
    [self request:self.keyString page:self.page];
    
}

-(void)block{
    
    WS(weakSelf)
    
    [self.searchView setSearchConfirm:^(NSString *key) {
        
        weakSelf.keyString = key;
        
        weakSelf.page = 1;
        
        [weakSelf.drugListView.dataSource removeAllObjects];
        [weakSelf.drugListView.myTable reloadData];
        
//        [weakSelf.drugListView.dataSource removeAllObjects];
//
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.drugListView.collectBlock = ^(DrugListModel *model) {
        [weakSelf showEditDrug:model];
        
//
//        weakSelf.addDrugsView = [AddDrugsView new];
//        weakSelf.addDrugsView.model = drugDosageModel;
//        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.addDrugsView];
//
//        weakSelf.addDrugsView.sd_layout
//        .xIs(0)
//        .yIs(0)
//        .widthIs(ScreenWidth)
//        .heightIs(ScreenHeight);
//
//        weakSelf.addDrugsView.addDurgDosageBlock = ^(DrugDosageModel *drugModel) {
//            drugDosageModel.use_num = drugModel.use_num;
//            drugDosageModel.use_num_name = drugModel.use_num_name;
//            drugDosageModel.day_use = drugModel.day_use;
//            drugDosageModel.day_use_num = drugModel.day_use_num;
//            drugDosageModel.unit_name = drugModel.unit_name;
//            drugDosageModel.use_type = drugModel.use_type;
//            drugDosageModel.use_cycle = drugModel.use_cycle;
//            drugDosageModel.days = drugModel.days;
//            [weakSelf.addDrugsView removeFromSuperview];
//        };
//
//        weakSelf.addDrugsView.backBlock = ^(NSString *back) {
//            [weakSelf.addDrugsView removeFromSuperview];
//        };
    };
    
    weakSelf.drugListView.pushBlock = ^(NSString *drugID) {
        
        DrugDetailsViewController *vc = [DrugDetailsViewController new];
        vc.drugID = drugID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)addSelectedDrug:(DrugDosageModel *)model {
    NSMutableSet *res = [NSMutableSet new];
    if (self.array && self.array.count > 0) {
        [res addObjectsFromArray:self.array];
    }
    [res addObject:model.drugid];
    self.array = [res allObjects];
}

- (void)showEditDrug:(DrugListModel *)listModel {
    DrugDosageModel *drugDosageModel = [DrugDosageModel new];
    drugDosageModel.drug_name = [NSString stringWithFormat:@"%@(%@)",listModel.drug_name,listModel.common_name];
    drugDosageModel.drugid = listModel.drug_id;
    drugDosageModel.drug_code = listModel.drug_code;
    drugDosageModel.standard = listModel.standard;
    AddDrugUseController *use = [AddDrugUseController new];
    use.model = drugDosageModel;
    use.showOne = YES;
    [self.navigationController pushViewController:use animated:YES];
    WS(weakSelf)
    use.useBlock = ^(DrugDosageModel *model) {
        [weakSelf addSelectedDrug:model];
    };
}

-(void)request:(NSString *)key page:(NSInteger)page{
    
    self.drugRequest = [DrugRequest new];
    
    WS(weakSelf)
    [self.drugRequest getDrFavDrugsclass_id:[self.idString integerValue] Key:key pageindex:page :^(HttpGeneralBackModel *model) {
        
        NSArray *array = model.data;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            DrugListModel *drugModel = [DrugListModel new];
            [drugModel setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:drugModel];
            for (NSString *drugId in weakSelf.array) {
                if ([drugModel.drug_id isEqualToString:drugId]) {
                    drugModel.isAdded = YES;
                    break;
                }
            }
            
        }
        
        if (page < 2) {
            [weakSelf.drugListView.dataSource removeAllObjects];
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


@end
