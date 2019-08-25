//
//  DiseasesViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DiseaseLibraryViewController.h"

#import "DiseasesRequest.h"
#import "SearchView.h"
#import "DiseaseLibraryModel.h"
#import "DiseasesView.h"

@interface DiseaseLibraryViewController ()

@property (nonatomic ,retain) DiseasesRequest *diseasesRequest;

@property (nonatomic ,strong) SearchView *searchView;

@property (nonatomic ,strong) DiseasesView *DiseasesView;

@property (nonatomic ,copy) NSString *keyString;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic ,assign) NSUInteger pagesize;

@end

@implementation DiseaseLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"疾病库";
    
    [self initUI];
    
    self.keyString = @"";
    
    self.page = 1;
    
    self.pagesize = 50;
    
    [self request:self.keyString page:self.page];
    
    [self block];
    
    [self refresh];
    
}

-(void)initUI{
    
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.DiseasesView = [DiseasesView new];
    [self.view addSubview:self.DiseasesView];
    
    self.DiseasesView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)request:(NSString *)key page:(NSInteger)page{
    
    self.diseasesRequest = [DiseasesRequest new];
    
    WS(weakSelf)
    [self.diseasesRequest getdrDiseaseLstKey:key pageindex:page pagesize:self.pagesize complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in genneralBackModel.data) {
            
            DiseaseLibraryModel *model = [DiseaseLibraryModel new];
            [model setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:model];
            
        }
        if (page <= 1) {
            weakSelf.DiseasesView.dataSources = @[];
        }
        [weakSelf.DiseasesView addData:dataArray];

        [weakSelf.DiseasesView.mj_header endRefreshing];
        [weakSelf.DiseasesView.mj_footer endRefreshing];
        BOOL hidden = weakSelf.DiseasesView.dataSources.count < page * weakSelf.pagesize;
        weakSelf.DiseasesView.mj_footer.hidden = hidden;
    }];
    
}

-(void)block{
    
    WS(weakSelf)
    
    [self.searchView setSearchBlock:^(NSString *searchTextString) {
        
        weakSelf.page = 1;
        
        weakSelf.keyString = searchTextString;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.DiseasesView.collectBlock = ^(DiseaseLibraryModel *model) {
        
        [[DiseasesRequest new] postCollectDiseaseId:model complete:^(HttpGeneralBackModel *genneralBackModel) {
           
            if (genneralBackModel.retcode == 0) {
                
                model.disease_id = 1;
                [weakSelf.DiseasesView reloadData];
//                weakSelf.page = 1;
//                [weakSelf request:weakSelf.keyString page:weakSelf.page];
                
            }
            
        }];
        
    };
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.DiseasesView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.DiseasesView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        weakSelf.pagesize = weakSelf.pagesize + 30;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
}

@end
