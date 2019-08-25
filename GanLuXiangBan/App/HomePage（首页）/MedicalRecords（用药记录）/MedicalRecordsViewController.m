//
//  MedicalRecordsViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/27.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MedicalRecordsViewController.h"
#import "MedicalRecordsRequset.h"
#import "MedicalRecordsModel.h"
#import "MedicalRecordsView.h"
#import "SearchView.h"
#import "MedicationDetailsViewController.h"
#import "RecDrugsViewController.h"

@interface MedicalRecordsViewController ()

@property (nonatomic ,retain) MedicalRecordsRequset *medicalRequest;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic ,strong) MedicalRecordsView *medicalRecordsView;

@property (nonatomic ,copy) NSString *keyString;

@property (nonatomic ,assign) NSUInteger page;

@end

@implementation MedicalRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用药记录";
    self.view.backgroundColor = kPageBgColor;
    
    [self initUI];
    
    self.keyString = @"";
    
    self.page = 1;
    
    [self request:self.keyString page:self.page];
    
    [self block];
    
    [self refresh];
    
}

-(void)request:(NSString *)key page:(NSInteger)page{
    
    self.medicalRequest = [MedicalRecordsRequset new];
    
    WS(weakSelf)
    [self.medicalRequest getMedicationRecordsKey:key page:page complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            MedicalRecordsModel *model = [MedicalRecordsModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.medicalRecordsView addData:array];
        
        [weakSelf.medicalRecordsView.myTable.mj_header endRefreshing];
        [weakSelf.medicalRecordsView.myTable.mj_footer endRefreshing];
        
    }];
    
}

-(void)initUI{
    
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(50);
    
    self.medicalRecordsView = [MedicalRecordsView new];
    [self.view addSubview:self.medicalRecordsView];
    self.medicalRecordsView.backgroundColor = kPageBgColor;
    
    self.medicalRecordsView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.medicalRecordsView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.medicalRecordsView.dataSource removeAllObjects];
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.medicalRecordsView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
}

-(void)block{
    
    WS(weakSelf)
    
    [self.searchView setSearchBlock:^(NSString *searchTextString) {
        
        weakSelf.keyString = searchTextString;

        weakSelf.page = 1;
        
        [weakSelf.medicalRecordsView.dataSource removeAllObjects];
        
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.medicalRecordsView.pushBlock = ^(MedicalRecordsModel *model) {
        
        if ([@"0" isEqualToString:model.status]) {
            [weakSelf getUnsendRecipeDatas:model];
        }
        else {
            MedicationDetailsViewController *medicationDetailsView = [[MedicationDetailsViewController alloc] init];
            medicationDetailsView.model = model;
            [weakSelf.navigationController pushViewController:medicationDetailsView animated:YES];
        }
        
    };
    
}

- (void)getUnsendRecipeDatas:(MedicalRecordsModel *)model {
    NSString *str = [NSString stringWithFormat:@"%@", @(model.recipe_id)];
    @weakify(self);
    [[MedicalRecordsRequset new] getUnsendRecipeDetail:str complete:^(HttpGeneralBackModel *genneralBackModel) {
        if (genneralBackModel.data) {
            NSDictionary *dic = genneralBackModel.data;
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
            [params setObject:model.patient_name forKey:@"name"];
            [params setObject:model.patient_gender forKey:@"gender"];
            [params setObject:[NSString stringWithFormat:@"%@", @(model.patient_age)] forKey:@"age"];
            @strongify(self);
            RecDrugsViewController *rec = [RecDrugsViewController new];
            rec.type = 10;
            rec.mid = [NSString stringWithFormat:@"%@", dic[@"mid"]];
            rec.name = model.patient_name;
            rec.age = [NSString stringWithFormat:@"%@", @(model.patient_age)];
            rec.gender = model.patient_gender;
            rec.recordDatas = dic;
            [self.navigationController pushViewController:rec animated:YES];
            rec.sendBlock = ^(BOOL success) {
                if (success) {
                    self.page = 1;
                    [self.medicalRecordsView.dataSource removeAllObjects];
                    [self request:self.keyString page:self.page];
                }
            };
        }
    }];
}

@end
