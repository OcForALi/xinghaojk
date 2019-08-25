//
//  PrescriptionAddViewController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "PrescriptionAddViewController.h"

#import "RecDrugsRequest.h"
#import "RecDrugsModel.h"
#import "PrescriptionAddView.h"
#import "AddDrugsViewController.h"
#import "DrugDosageModel.h"
#import "MedicationDetailsViewController.h"
//#import "SearchView.h"
#import "DiseaseLibraryView.h"
#import "DiseasesRequest.h"
#import "ContinueModel.h"
#import "ChatDrugsModel.h"
#import "PrescriptionRequest.h"

@interface PrescriptionAddViewController ()

@property (nonatomic ,strong) PrescriptionAddView *recDrugsView;

@property (nonatomic ,strong) UIButton *collectionButton;

@property (nonatomic ,retain) NSMutableArray *dataArray;

@property (nonatomic ,strong) AddDrugsViewController *addDrugsView;

#pragma mark  ------- 临床诊断 ----------

@property (nonatomic ,strong) UIView *clinicalDiagnosisView;

@property (nonatomic ,retain) DiseasesRequest *diseasesRequest;

//@property (nonatomic ,strong) SearchView *searchView;

@property (nonatomic ,strong) DiseaseLibraryView *diseaseLibraryView;

@property (nonatomic ,copy) NSString *keyString;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic ,assign) NSUInteger pagesize;

@property (nonatomic ,copy) NSString *check_id;

@property (nonatomic ,copy) NSString *recipelist_id;

@end

@implementation PrescriptionAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加常用处方";
    self.pagesize = 50;
    
    self.model = [RecDrugsModel new];
    
    [self initUI];
    
    if (self.type != 1) {
        
        [self requst];
        
    }
    
    if (self.initialRecipeInfoModel != nil) {
        [self requst:self.initialRecipeInfoModel];
    }
    
    [self block];
    
    self.dataArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDurgDosage:) name:@"AddDurgDosage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyDurgDosage:) name:@"ModifyDurgDosage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteDurgDosage:) name:@"DeleteDurgDosage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContinuePrescription:) name:@"ContinuePrescription" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeRecDrug:) name:@"CloseRecDrug" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCommonPrescription:) name:@"receiveCommonPrescription" object:nil];
}

-(void)initUI{
    
    self.recDrugsView = [PrescriptionAddView new];
    self.recDrugsView.type = self.type;
    [self.view addSubview:self.recDrugsView];
    
    self.recDrugsView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 50);
    
    self.collectionButton = [UIButton new];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.collectionButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton setBackgroundColor: [UIColor orangeColor]];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectionButton];
    
    self.collectionButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)requst{
    
    WS(weakSelf)
    
    [[RecDrugsRequest new] getInitialTmpRecipecomplete:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (genneralBackModel.retcode == 0) {
            
            [weakSelf.model setValuesForKeysWithDictionary:genneralBackModel.data];
            weakSelf.model.age = weakSelf.age;
            weakSelf.model.gender = weakSelf.gender;
            weakSelf.model.patient_name = weakSelf.name;
            
            weakSelf.recDrugsView.model = weakSelf.model;
            
            weakSelf.serialNumber = weakSelf.model.code;
            weakSelf.dataString = weakSelf.model.createtime;
            
        }
        
    }];
    
}

- (void)receiveCommonPrescription:(NSNotification *)center {
    NSDictionary *dic = center.object;
    if (dic) {
        [self resetModel:dic];
    }
}

- (void)resetModel:(NSDictionary *)dic {
    [self.model setValuesForKeysWithDictionary:dic];
    
    if (self.name != nil) {
        
        self.model.age = self.age;
        self.model.gender = self.gender;
        self.model.patient_name = self.name;
        
    }
    
    if ([dic objectForKey:@"current_check_id"]) {
        self.model.check_id = [dic objectForKey:@"current_check_id"];
    }
    
    if ([dic objectForKey:@"name"]) {
        self.model.patient_name = [dic objectForKey:@"name"];
    }
    
    if ([dic objectForKey:@"current_check_result"]) {
        self.model.check_result = [dic objectForKey:@"current_check_result"];
    }
    
    if ([dic objectForKey:@"druguses"]) {
        self.model.druguse_items = [dic objectForKey:@"druguses"];
    }
    if ([dic objectForKey:@"code"]) {
        self.model.code = [dic objectForKey:@"code"];
    }
    
    if ([dic objectForKey:@"createtime"]) {
        self.model.createtime = [dic objectForKey:@"createtime"];
    }
    
    self.recDrugsView.model = self.model;
    self.check_id = self.model.check_id;
    self.diseaseLibraryView.searchView.textField.text = self.model.check_result;
    self.recipelist_id = @"0";
    
    if (self.model.druguse_items.count != 0) {
        
        [self.dataArray removeAllObjects];
        
        for (NSDictionary *dict in self.model.druguse_items) {
            
            DrugDosageModel *drugDosageModel = [DrugDosageModel new];
            [drugDosageModel setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:drugDosageModel];
            
        }
        
        self.recDrugsView.dataSource = self.dataArray;
        
        NSMutableArray *drugArray = [NSMutableArray array];
        
        for (DrugDosageModel *drugDosageModel in self.dataArray) {
            
            [drugArray addObject:drugDosageModel.drugid];
            
        }
        
        self.addDrugsView.array = drugArray;
        
    }
}

-(void)requst:(InitialRecipeInfoModel *)model{
    WS(weakSelf);
    
    [[RecDrugsRequest new] postInitialRecipeInfo:model :^(HttpGeneralBackModel *genneralBackModel) {
        
        if (genneralBackModel.retcode == 0) {
            [weakSelf resetModel:genneralBackModel.data];
        }
        
    }];
    
}

-(void)block{
    WS(weakSelf)
    
    self.recDrugsView.pushBlock = ^(NSArray *pushVC) {
        
//        if (!weakSelf.check_id || !weakSelf.recipelist_id) {
//            [weakSelf.view makeToast:@"请选择临床诊断"];
//        }
//        else {
            NSMutableArray *drugArray = [NSMutableArray array];
            
            for (DrugDosageModel *model in pushVC) {
                
                [drugArray addObject:model.drugid];
                
            }
            
            weakSelf.addDrugsView = [[AddDrugsViewController alloc] init];
            weakSelf.addDrugsView.array = drugArray;
            [weakSelf.navigationController pushViewController:weakSelf.addDrugsView animated:YES];
//        }
    };
    
    self.recDrugsView.useBlock = ^(UIViewController *vc) {
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.recDrugsView.openBlock = ^(NSString *openString) {
        
        if ([openString isEqualToString:@"临床诊断"]) {
            
            weakSelf.clinicalDiagnosisView = [UIView new];
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.clinicalDiagnosisView];
            
            weakSelf.clinicalDiagnosisView.sd_layout
            .xIs(0)
            .yIs(0)
            .widthIs(ScreenWidth)
            .heightIs(ScreenHeight);
            
            [weakSelf openClinicalDiagnosis];
            
        }
        
    };
    
    self.recDrugsView.requestBlock = ^(NSString *check_id, NSString *recipelist_id) {
        
        if (!weakSelf.mid || weakSelf.mid.length == 0) {
            weakSelf.mid = [NSString stringWithFormat:@"%@", GetUserDefault(UserID)];
        }
        [[RecDrugsRequest new] getRecipeDruguse:weakSelf.mid recipeId:recipelist_id checkId:check_id complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            NSArray *array = genneralBackModel.data;
            
            if (array.count > 0) {
                
                [weakSelf.dataArray removeAllObjects];
                
                for (NSDictionary *dict in array) {
                    
                    DrugDosageModel *drugDosageModel = [DrugDosageModel new];
                    [drugDosageModel setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArray addObject:drugDosageModel];
                    
                }
                
                weakSelf.recDrugsView.dataSource = weakSelf.dataArray;
                
                NSMutableArray *drugArray = [NSMutableArray array];
                
                for (DrugDosageModel *drugDosageModel in weakSelf.dataArray) {
                    
                    [drugArray addObject:drugDosageModel.drugid];
                    
                }
                
                weakSelf.addDrugsView.array = drugArray;
                
            }
        }];
    };
    
}

-(void)addDurgDosage:(NSNotification *)sender{
    
    DrugDosageModel *model = sender.object;
    
    [self.dataArray addObject:model];
    
    self.recDrugsView.dataSource = self.dataArray;
    
    NSMutableArray *drugArray = [NSMutableArray array];
    
    for (DrugDosageModel *model in self.dataArray) {
        
        [drugArray addObject:model.drugid];
        
    }
    
    self.addDrugsView.array = drugArray;
    
}

-(void)modifyDurgDosage:(NSNotification *)sender{
    
    DrugDosageModel *drugDosageModel = sender.object;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        DrugDosageModel *model = self.dataArray[i];
        
        if ([model.drugid isEqualToString:drugDosageModel.drugid]) {
            
            [self.dataArray replaceObjectAtIndex:i withObject:drugDosageModel];
            
        }
        
    }
    
    self.recDrugsView.dataSource = self.dataArray;
    
    NSMutableArray *drugArray = [NSMutableArray array];
    
    for (DrugDosageModel *model in self.dataArray) {
        
        [drugArray addObject:model.drugid];
        
    }
    
    self.addDrugsView.array = drugArray;
    
}

-(void)deleteDurgDosage:(NSNotification *)sender{
    
    DrugDosageModel *drugDosageModel = sender.object;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        DrugDosageModel *model = self.dataArray[i];
        
        if ([model.drugid isEqualToString:drugDosageModel.drugid]) {
            [self.dataArray removeObjectAtIndex:i];
        }
        
    }
    
    self.recDrugsView.dataSource = self.dataArray;
    
    NSMutableArray *drugArray = [NSMutableArray array];
    
    for (DrugDosageModel *model in self.dataArray) {
        
        [drugArray addObject:model.drugid];
        
    }
    
    self.addDrugsView.array = drugArray;
    
}

-(void)ContinuePrescription:(NSNotification *)sender{
    
    [self.recDrugsView.dataSource removeAllObjects];
    
    [self.dataArray removeAllObjects];
    
    ContinueModel *model = sender.object;
    
    self.initialRecipeInfoModel = [InitialRecipeInfoModel new];
    self.initialRecipeInfoModel.mid = model.mid;
    self.initialRecipeInfoModel.medical_id = model.medical_id;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in model.items) {
        
        NSString *string = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qty"]];
        
        [array addObject:@{@"drug_code":dict[@"drug_code"],@"qty":string}];
        
    }
    
    self.initialRecipeInfoModel.drugs = array;
    
    [self requst:self.initialRecipeInfoModel];
    
}

-(void)setInitialRecipeInfoModel:(InitialRecipeInfoModel *)initialRecipeInfoModel{
    
    _initialRecipeInfoModel = initialRecipeInfoModel;
    
}

-(void)collection:(UIButton *)button{
//    if (!self.recipelist_id || !self.check_id) {
//        [self.view makeToast:@"请选择临床诊断"];
//        return;
//    }
//    if (self.model && self.model.druguse_items && self.model.druguse_items.count > 0) {
//        [self.view makeToast:@"您还没添加药品"];
//        return;
//    }
    NSMutableArray *array = [NSMutableArray array];
//    for (NSDictionary *dic in self.model.druguse_items) {
//        PrescriptionAddDrugModel *drug = [PrescriptionAddDrugModel new];
//        drug.pkid = 0;
//        drug.drugid = [dic[@"drugid"] integerValue];
//        drug.use_num = [dic[@"use_num"] integerValue];
//        drug.days = [dic[@"days"] integerValue];
//        drug.use_type = [NSString stringWithFormat:@"%@", dic[@"use_type"]];
//        drug.use_cycle = [NSString stringWithFormat:@"%@", dic[@"use_cycle"]];
//        drug.day_use = [NSString stringWithFormat:@"%@", dic[@"day_use"]];
//        drug.day_use_num = [NSString stringWithFormat:@"%@", dic[@"day_use_num"]];
//        drug.use_unit = [NSString stringWithFormat:@"%@", dic[@"unit_name"]];
//        drug.use_num_name = [NSString stringWithFormat:@"%@", dic[@"use_num_name"]];
//        [array addObject:drug];
//    }
    for (DrugDosageModel *dosage in self.dataArray) {
        PrescriptionAddDrugModel *drug = [PrescriptionAddDrugModel new];
        drug.pkid = 0;
//        drug.drugid = 130334;//[dic[@"drugid"] integerValue];
//        drug.use_num = 1;//[dic[@"use_num"] integerValue];
//        drug.days = 1;//[dic[@"days"] integerValue];
//        drug.use_type = @"口服";//[NSString stringWithFormat:@"%@", dic[@"use_type"]];
//        drug.use_cycle = @"1天";//[NSString stringWithFormat:@"%@", dic[@"use_cycle"]];
//        drug.day_use = @"每天1次";//[NSString stringWithFormat:@"%@", dic[@"day_use"]];
//        drug.day_use_num = 1;//[dic[@"day_use_num"] integerValue];
//        drug.use_unit = @"粒";//[NSString stringWithFormat:@"%@", dic[@"unit_name"]];
//        drug.use_num_name = @"每天1次";//[NSString stringWithFormat:@"%@", dic[@"use_num_name"]];
        drug.drugid = [NSString stringWithFormat:@"%@",dosage.drugid];
        drug.use_num = [NSString stringWithFormat:@"%@", dosage.use_num];
        drug.days = [dosage.days integerValue];
        drug.use_type = [NSString stringWithFormat:@"%@", dosage.use_type];
        drug.use_cycle = [NSString stringWithFormat:@"%@", dosage.use_cycle];
        drug.day_use = [NSString stringWithFormat:@"%@", dosage.day_use];
        drug.day_use_num = dosage.day_use_num;
        drug.use_unit = [NSString stringWithFormat:@"%@", dosage.unit_name];
        drug.use_num_name = [NSString stringWithFormat:@"%@", dosage.use_num_name];
        [array addObject:drug];
    }
    if (array.count == 0) {
        [self.view makeToast:@"您还没添加药品"];
        return;
    }
    NSString *result = self.recDrugsView.diagnosisContentLabel.text;
    if (!result || result.length == 0) {
        result = self.model.check_result;
    }
    if (!result || result.length == 0) {
        [self.view makeToast:@"请选择临床诊断"];
        return;
    }
    self.collectionButton.userInteractionEnabled = NO;
    PrescriptionAddModel *add = [PrescriptionAddModel new];
    add.recipe_id = @"0";
    add.check_id = [NSString stringWithFormat:@"%@",self.check_id];
    add.check_result = result;
    add.drugs = array;
    WS(weakSelf);
    if ([button.titleLabel.text isEqualToString:@"保存"]) {
        [self showHudAnimated:YES];
        [[PrescriptionRequest new] postCommonRecipeInfo:add complete:^(HttpGeneralBackModel *model) {
            [weakSelf hideHudAnimated];
            if (model && model.retcode == 0) {
                [weakSelf.view makeToast:@"添加处方成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                NSString *msg = model.retmsg;
                if (!msg || msg.length == 0) {
                    msg = @"添加处方失败";
                }
                [weakSelf.view makeToast:model.retmsg];
                weakSelf.collectionButton.userInteractionEnabled = YES;
            }
        }];
    }
    else{
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveRecDrugs" object:self.recDrugsView.model];
        
        if (self.recDrugsSaveBlock) {
            self.recDrugsSaveBlock(self.recDrugsView.model);
        }
        
        //        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
    
}

-(void)openClinicalDiagnosis{
    
    UIView *bgView = [UIView new];
    bgView .backgroundColor = RGBA(51, 51, 51, 0.7);
    bgView .userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [bgView  addGestureRecognizer:backTap];
    [self.clinicalDiagnosisView addSubview:bgView];
    
    bgView.sd_layout.topSpaceToView(self.clinicalDiagnosisView, 0).leftSpaceToView(self.clinicalDiagnosisView, 0).rightSpaceToView(self.clinicalDiagnosisView, 0).heightIs(150);
    
//    self.searchView = [SearchView new];
//    [self.searchView.searchBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [self.searchView.textField addTarget:self action:@selector(searchViewTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [self.clinicalDiagnosisView addSubview:self.searchView];
//
//    self.searchView.sd_layout
//    .leftSpaceToView(self.clinicalDiagnosisView, 0)
//    .rightSpaceToView(self.clinicalDiagnosisView, 0)
//    .topSpaceToView(self.clinicalDiagnosisView, 150)
//    .heightIs(50);
    
    self.diseaseLibraryView = [DiseaseLibraryView new];
    self.diseaseLibraryView.typeInteger = 1;
    [self.clinicalDiagnosisView addSubview:self.diseaseLibraryView];
    
    self.diseaseLibraryView.sd_layout
    .leftSpaceToView(self.clinicalDiagnosisView, 0)
    .rightSpaceToView(self.clinicalDiagnosisView, 0)
    .topSpaceToView(self.clinicalDiagnosisView, 150)
    .bottomSpaceToView(self.clinicalDiagnosisView, 0);
    
    self.keyString = @"";
    
    self.page = 1;
    
    [self request:self.keyString page:self.page];
    
    [self refresh];
    
    WS(weakSelf);
    [self.diseaseLibraryView.searchView setSearchBlock:^(NSString *searchTextString) {

        weakSelf.keyString = searchTextString;
        weakSelf.page = 1;
        [weakSelf request:searchTextString page:weakSelf.page];
    
    }];
    self.diseaseLibraryView.searchView.searchConfirm = ^(NSString *key) {
        weakSelf.model.check_result = weakSelf.diseaseLibraryView.searchView.textField.text;
        
        weakSelf.recDrugsView.model = weakSelf.model;
        
        if (!weakSelf.mid || weakSelf.mid.length == 0) {
            weakSelf.mid = [NSString stringWithFormat:@"%@", GetUserDefault(UserID)];
        }
        [[RecDrugsRequest new] getRecipeDruguse:weakSelf.mid recipeId:@"0" checkId:@"0" complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            weakSelf.check_id = weakSelf.recipelist_id;
            NSArray *array = genneralBackModel.data;
            
            if (array.count > 0) {
                [weakSelf.dataArray removeAllObjects];
                
                for (NSDictionary *dict in array) {
                    
                    DrugDosageModel *drugDosageModel = [DrugDosageModel new];
                    [drugDosageModel setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArray addObject:drugDosageModel];
                    
                }
                
                weakSelf.recDrugsView.dataSource = weakSelf.dataArray;
                
                NSMutableArray *drugArray = [NSMutableArray array];
                
                for (DrugDosageModel *drugDosageModel in weakSelf.dataArray) {
                    
                    [drugArray addObject:drugDosageModel.drugid];
                    
                }
                
                weakSelf.addDrugsView.array = drugArray;
                
            }
            
        }];
        
        [weakSelf back];
    };
    
    self.diseaseLibraryView.changeShowTypeBlock = ^(DiseaseLibraryType type) {
        weakSelf.page = 1;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
    };
    self.diseaseLibraryView.collectBlock = ^(DiseaseLibraryModel *model) {
        
        weakSelf.diseaseLibraryView.searchView.textField.text = model.name;
        
        weakSelf.check_id = [NSString stringWithFormat:@"%@",@(model.id)];
        
        weakSelf.recipelist_id = [NSString stringWithFormat:@"%@",@(model.pkid)];
        
        if (weakSelf.model) {
            weakSelf.model.check_result = model.name;
            weakSelf.model.check_id = weakSelf.check_id;
        }
        //        weakSelf.model.check_id = [NSString stringWithFormat:@"%ld",model.pkid];
        
    };
    
}

-(void)searchViewTextFieldDidChange:(UITextField *)textField{
    
    [self.diseaseLibraryView.dataSource removeAllObjects];
    
    self.keyString = textField.text;
    
    [self request:self.keyString page:self.page];
    
}

-(void)closeRecDrug:(NSNotification *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)request:(NSString *)key page:(NSInteger)page{
    
    self.diseasesRequest = [DiseasesRequest new];
    WS(weakSelf)
    [self.diseasesRequest getSearchMedicalDiseaseKey:key type:self.diseaseLibraryView.showType pageindex:page complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dict in genneralBackModel.data) {
            
            DiseaseLibraryModel *model = [DiseaseLibraryModel new];
            [model setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:model];
            
        }
        if (page <= 1) {
            [weakSelf.diseaseLibraryView.dataSource removeAllObjects];
        }
        [weakSelf.diseaseLibraryView addData:dataArray];
        
        [weakSelf.diseaseLibraryView.myTable.mj_header endRefreshing];
        [weakSelf.diseaseLibraryView.myTable.mj_footer endRefreshing];
        
    }];
//    WS(weakSelf)
//    [self.diseasesRequest getdrDiseaseLstKey:key pageindex:page pagesize:self.pagesize complete:^(HttpGeneralBackModel *genneralBackModel) {
//
//        NSMutableArray *dataArray = [NSMutableArray array];
//
//        for (NSDictionary *dict in genneralBackModel.data) {
//
//            DiseaseLibraryModel *model = [DiseaseLibraryModel new];
//            [model setValuesForKeysWithDictionary:dict];
//
//            [dataArray addObject:model];
//
//        }
//
//        [weakSelf.diseaseLibraryView addData:dataArray];
//
//        [weakSelf.diseaseLibraryView.myTable.mj_header endRefreshing];
//        [weakSelf.diseaseLibraryView.myTable.mj_footer endRefreshing];
//
//    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.diseaseLibraryView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.diseaseLibraryView.dataSource removeAllObjects];
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
    
    self.diseaseLibraryView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        weakSelf.pagesize = weakSelf.pagesize + 30;
        [weakSelf request:weakSelf.keyString page:weakSelf.page];
        
    }];
}

-(void)back{
    [self.clinicalDiagnosisView removeFromSuperview];
}

@end
