//
//  RecDrugsViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecDrugsViewController.h"
#import "RecDrugsRequest.h"
#import "RecDrugsModel.h"
#import "RecDrugsView.h"
#import "AddDrugsViewController.h"
#import "DrugDosageModel.h"
#import "MedicationDetailsViewController.h"
#import "DiseaseLibraryView.h"
#import "DiseasesRequest.h"
#import "ContinueModel.h"
#import "PrescriptionRequest.h"
#import "ChatDrugsModel.h"
#import "SaveMedicalRcdModel.h"
#import "MessageRequest.h"
#import "PatientsDetailsViewModel.h"

@interface RecDrugsViewController ()

@property (nonatomic ,strong) RecDrugsView *recDrugsView;

@property (nonatomic ,strong) UIButton *collectionButton;

@property (nonatomic ,retain) NSMutableArray *dataArray;

@property (nonatomic ,strong) AddDrugsViewController *addDrugsView;

#pragma mark  ------- 临床诊断 ----------

@property (nonatomic ,strong) UIView *clinicalDiagnosisView;

@property (nonatomic ,retain) DiseasesRequest *diseasesRequest;

@property (nonatomic ,strong) DiseaseLibraryView *diseaseLibraryView;

@property (nonatomic ,copy) NSString *keyString;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic ,assign) NSUInteger pagesize;

@property (nonatomic ,copy) NSString *check_id;

@property (nonatomic ,copy) NSString *recipelist_id;

@property (nonatomic ,copy) NSString *recipe_id;

@end

@implementation RecDrugsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐用药";
    
    self.pagesize = 50;
    
    if (!self.model) {
        self.model = [RecDrugsModel new];
    }
    WS(weakSelf)
    if (self.type != 0) {
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame = CGRectMake(0, 0, 66, 45);
        saveBtn.backgroundColor = kMainColor;
        saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [saveBtn setTitle:@"保存常用" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(touchNavSaveCommon) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    }
    else {
        [self addNavRightTitle:@"帮助？" complete:^{
            [weakSelf touchNavRightHelp];
        }];
    }
    
    [self getPatientDetails];
    
    [self initUI];
    
    if (self.type != 1) {
        
        [self requst];
        
    }
    else {
        if (self.initialRecipeInfoModel != nil) {
            [self requst:self.initialRecipeInfoModel];
        }
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.recordDatas) {
        [self resetModel:self.recordDatas];
    }
}

- (void)getPatientDetails {
    if (self.mid && !self.name) {
        WS(weakSelf)
        [[PatientsDetailsViewModel new] getDetailWithMidString:self.mid complete:^(id object) {
            PatientsDetailsModel *model = object;
            if (model) {
                if (model.name && model.name.length > 0) {
                    weakSelf.name = model.name;
                    weakSelf.recDrugsView.nameTextField.text = model.name;
                }
                NSString *age = [NSString stringWithFormat:@"%@", model.age];
                if (age && age.length > 0) {
                    weakSelf.age = age;
                    weakSelf.recDrugsView.ageTextField.text = age;
                }
                if (model.gender && model.gender.length > 0) {
                    weakSelf.gender = model.gender;
                    weakSelf.recDrugsView.genderTextField.text = model.gender;
                }
            }
        }];
    }
}

- (void)touchNavRightHelp {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"帮助" message:@"推荐用药此功能用于患者还没有入驻到平台，同时还没有在系统上与医生形成绑定的场景下为患者开具处方。开具完处方后，可通过生成二维码的方式，由患者扫码进行平台的入驻及与医生建立绑定关系" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchNavSaveCommon {
    NSMutableArray *array = [NSMutableArray array];
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
    PrescriptionAddModel *add = [PrescriptionAddModel new];
    add.recipe_id = @"0";
    if (self.recordDatas) {
        add.recipe_id = [NSString stringWithFormat:@"%@", self.recordDatas[@"recipe_id"]];
    }
    add.check_id = [NSString stringWithFormat:@"%@", self.check_id];
    add.check_result = result;
    add.drugs = array;
    WS(weakSelf)
    [[PrescriptionRequest new] postCommonRecipeInfo:add complete:^(HttpGeneralBackModel *model) {
        if (model && model.retcode == 0) {
            [weakSelf.view makeToast:@"添加处方成功"];
        }
        else {
            NSString *msg = model.retmsg;
            if (!msg || msg.length == 0) {
                msg = @"添加处方失败";
            }
            [weakSelf.view makeToast:model.retmsg];
        }
    }];
}

-(void)initUI{
    
    self.recDrugsView = [RecDrugsView new];
    self.recDrugsView.type = self.type;
    self.recDrugsView.canEdit = YES;
    [self.view addSubview:self.recDrugsView];
    
    self.recDrugsView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 50);
    
    self.collectionButton = [UIButton new];
    [self.collectionButton setBackgroundColor: [UIColor orangeColor]];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    NSString *title = @"保存并生成二维码";
    if (self.type == 10) {
        title = @"发送处方";
    }
    else if (self.type != 0) {
        title = @"保存";
    }
    [self.collectionButton setTitle:title forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectionButton];
    
    self.collectionButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
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
        
        if (weakSelf.initialRecipeInfoModel != nil) {
            [weakSelf requst:weakSelf.initialRecipeInfoModel];
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
    
    if (self.type == 10 && [dic objectForKey:@"recipe_id"]) {
        NSString *rid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"recipe_id"]];
        if (rid && rid.length > 0) {
            self.recipe_id = rid;
        }
    }
    
    if (self.name && self.name.length > 0) {
        self.model.patient_name = self.name;
    }
    if (self.age && self.age.length > 0) {
        self.model.age = self.age;
    }
    if (self.gender && self.gender.length > 0) {
        self.model.gender = self.gender;
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
            if (!drugDosageModel.unit_name || drugDosageModel.unit_name.length == 0) {
                drugDosageModel.unit_name = [dict valueForKey:@"use_unit"];
            }
            [self.dataArray addObject:drugDosageModel];
            
        }
        
        [self.recDrugsView reloadDatas:self.dataArray];
        
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
        
        NSMutableArray *drugArray = [NSMutableArray array];
        
        for (DrugDosageModel *model in pushVC) {
            
            [drugArray addObject:model.drugid];
            
        }
        
        weakSelf.addDrugsView = [[AddDrugsViewController alloc] init];
        weakSelf.addDrugsView.array = drugArray;
        weakSelf.addDrugsView.mid = weakSelf.mid;
        [weakSelf.navigationController pushViewController:weakSelf.addDrugsView animated:YES];
        
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
        
        [weakSelf requestRecDrugsByCheckId:check_id recipeId:recipelist_id];
        
    };
    
    
    self.recDrugsView.RecDrugsEditBlock = ^{
      
        if (weakSelf.type != 0) {
            weakSelf.recordDatas = nil;
            [weakSelf.collectionButton setTitle:@"保存" forState:UIControlStateNormal];
        }
        
    };
}

- (void)requestRecDrugsByCheckId:(NSString *)checkId recipeId:(NSString *)recipeId {
    if (!self.mid || self.mid.length == 0) {
        self.mid = [NSString stringWithFormat:@"%@", GetUserDefault(UserID)];
    }
    WS(weakSelf)
    [[RecDrugsRequest new] getRecipeDruguse:self.mid recipeId:recipeId checkId:checkId complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSArray *array = genneralBackModel.data;
        
        if (array.count > 0) {
            NSMutableArray *off = [[NSMutableArray alloc] init];
            NSMutableArray *res = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in array) {
                DrugDosageModel *drugDosageModel = [DrugDosageModel new];
                [drugDosageModel setValuesForKeysWithDictionary:dict];
                if (drugDosageModel.status != 1) {
                    [off addObject:drugDosageModel.drug_name];
                }
                else {
                    [res addObject:drugDosageModel];
                }
            }
            
            
            [weakSelf.dataArray removeAllObjects];
            if (off.count == 0) {
                [weakSelf.dataArray addObjectsFromArray:res];
            }
            [weakSelf.recDrugsView reloadDatas:weakSelf.dataArray];
            
            if (off.count == 0) {
                NSMutableArray *drugArray = [NSMutableArray array];
                for (DrugDosageModel *drugDosageModel in weakSelf.dataArray) {
                    [drugArray addObject:drugDosageModel.drugid];
                }
                
                weakSelf.addDrugsView.array = drugArray;
            }
            else {
                NSString *title = [off componentsJoinedByString:@"、"];
                title = [NSString stringWithFormat:@"%@，没有上架，可能没有库存，不能进行续方", title];
                [weakSelf.view makeToast:title];
            }
        }
        
    }];
}

-(void)addDurgDosage:(NSNotification *)sender{
    
    DrugDosageModel *model = sender.object;
    
    [self.dataArray addObject:model];
    
    [self.recDrugsView reloadDatas: self.dataArray];
    
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
    
    [self.recDrugsView reloadDatas:self.dataArray];
    
    NSMutableArray *drugArray = [NSMutableArray array];
    
    for (DrugDosageModel *model in self.dataArray) {
        
        [drugArray addObject:model.drugid];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.addDrugsView.array = drugArray;
    });
    
}

-(void)deleteDurgDosage:(NSNotification *)sender{
    
    DrugDosageModel *drugDosageModel = sender.object;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        DrugDosageModel *model = self.dataArray[i];
        
        if ([model.drugid isEqualToString:drugDosageModel.drugid]) {
            [self.dataArray removeObjectAtIndex:i];
        }
        
    }
    
    [self.recDrugsView reloadDatas: self.dataArray];
    
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
        
        NSString *string = [NSString stringWithFormat:@"%@",dict[@"qty"]];
        
        [array addObject:@{@"drug_code":dict[@"drug_code"],@"qty":string}];
        
    }
    
    self.initialRecipeInfoModel.drugs = array;
    
    [self requst:self.initialRecipeInfoModel];
    
}

-(void)setInitialRecipeInfoModel:(InitialRecipeInfoModel *)initialRecipeInfoModel{
    
    _initialRecipeInfoModel = initialRecipeInfoModel;

}

-(void)collection:(UIButton *)button{
    
    if (self.recDrugsView.model.patient_name == nil) {
        [self.view makeToast:@"名字为必填项"];
        return;
    }
    if (self.recDrugsView.model.check_result == nil) {
        [self.view makeToast:@"临床诊断为必填项"];
        return;
    }
    if (self.recDrugsView.model.gender == nil) {
        [self.view makeToast:@"性别为必填项"];
        return;
    }
    if (self.recDrugsView.model.age == nil) {
        [self.view makeToast:@"年龄为必填项"];
        return;
    }

    NSMutableArray *array = [NSMutableArray array];
    
    for (DrugDosageModel *model in self.dataArray) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        unsigned int count = 0;
        objc_property_t *properList = class_copyPropertyList([model class], &count);
        
        for (int i = 0; i < count; i++) {
            
            objc_property_t property = properList[i];
            
            NSString *keyString = [NSString stringWithUTF8String:property_getName(property)];
            NSString *valueString = [NSString stringWithFormat:@"%@",[model valueForKey:keyString]];
            valueString = valueString.length == 0 ? @"" : valueString;
            [parameters setValue:valueString forKey:keyString];
            
        }
        
        free(properList);
        
        [array addObject:parameters];
        
    }
    
    self.recDrugsView.model.druguse_items = array;
    
    if (self.recDrugsView.model.druguse_items.count == 0) {
        [self.view makeToast:@"您还没添加药品"];
        return;
    }
    
    NSString *text = button.titleLabel.text;
    self.collectionButton.enabled = NO;
    
    WS(weakSelf);
    
    if ([text isEqualToString:@"保存并生成二维码"]) {
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:date];
        
        self.recDrugsView.model.createtime = DateTime;
        
        [[RecDrugsRequest new] postSaveTmpRecipe:self.recDrugsView.model :^(HttpGeneralBackModel *genneralBackModel) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MedicationDetailsViewController *medicationDetailsView = [[MedicationDetailsViewController alloc] init];
                MedicalRecordsModel *medicalModel = [MedicalRecordsModel new];
                medicalModel.recipe_id = [genneralBackModel.data integerValue];
                medicalModel.status = @"-1";
                medicationDetailsView.model = medicalModel;
                [weakSelf.navigationController pushViewController:medicationDetailsView animated:YES];
                
                weakSelf.collectionButton.enabled = YES;
            });
            
        }];
        
    }
    else if ([text isEqualToString:@"发送处方"]) {
        if (self.recipe_id && self.recipe_id.length > 0) {
            [self showHudAnimated:YES];
            SendRecipePost *post = [SendRecipePost new];
            post.recipe_id = [self.recipe_id integerValue];
            post.druguse_items = array;
            [[PrescriptionRequest new] postRecipeMessage:post complete:^(HttpGeneralBackModel *model) {
                [weakSelf hideHudAnimated];
                weakSelf.collectionButton.enabled = YES;
                if (model.retcode == 0) {
                    if (weakSelf.sendBlock) {
                        weakSelf.sendBlock(YES);
                    }
                    [weakSelf.view makeToast:@"处方发送成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }
                else if (model.retmsg) {
                    [weakSelf.view makeToast:model.retmsg];
                    if (weakSelf.sendBlock) {
                        weakSelf.sendBlock(NO);
                    }
                }
            }];
        }
        else {
            weakSelf.collectionButton.enabled = YES;
        }
    }
    else if ([@"保存" isEqualToString:text]) {
        if (self.recipe_id && self.recipe_id.length > 0) {
            [self updateRecDrugs:self.recDrugsView.model drugs:array];
        }
        else {
            [self saveRecDrugs:self.recDrugsView.model];
        }
    }
    else{
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveRecDrugs" object:self.recDrugsView.model];
        
        if (self.recDrugsSaveBlock) {
            self.recDrugsSaveBlock(self.recDrugsView.model);
        }
        
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
 
}

- (void)updateRecDrugs:(RecDrugsModel *)model drugs:(NSArray *)drugs {
    if (!model.check_result || [model.check_result isKindOfClass:NSNull.class] || model.check_result.length == 0) {
        [self.view makeToast:@"请选择临床诊断"];
        self.collectionButton.enabled = YES;
        return;
    }
    
    UpdateMedicalRcdModel *update = [UpdateMedicalRcdModel new];
    update.recipe_id = [self.recipe_id integerValue];
    update.check_id = [model.check_id integerValue];
    update.check_result = model.check_result;
    update.patient_age = [model.age integerValue];
    update.patient_name = [NSString stringWithFormat:@"%@", model.patient_name];
    update.patient_gender = [NSString stringWithFormat:@"%@", model.gender];
    update.druguse_items = drugs;
    WS(weakSelf)
    [[MessageRequest new] postUpdateMedicalRcd:update complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.collectionButton.enabled = YES;
            if (genneralBackModel && genneralBackModel.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
                [weakSelf.collectionButton setTitle:@"发送处方" forState:UIControlStateNormal];
            }
            else {
                [weakSelf.view makeToast:@"保存失败"];
            }
        });
        
    }];
}

- (void)saveRecDrugs:(RecDrugsModel *)recDrugsModel {
    if (!recDrugsModel.check_result || [recDrugsModel.check_result isKindOfClass:NSNull.class] || recDrugsModel.check_result.length == 0) {
        [self.view makeToast:@"请选择临床诊断"];
        self.collectionButton.enabled = YES;
        return;
    }
    
    SaveMedicalRcdModel *saveModel = [SaveMedicalRcdModel new];
    saveModel.patient_name = [NSString stringWithFormat:@"%@", recDrugsModel.patient_name];
    saveModel.mid = self.mid;
    saveModel.patient_age = [NSString stringWithFormat:@"%@", recDrugsModel.age];
    saveModel.patient_gender = [NSString stringWithFormat:@"%@", recDrugsModel.gender];
    saveModel.code = [NSString stringWithFormat:@"%@",recDrugsModel.code];
    saveModel.check_id = [NSString stringWithFormat:@"%@",recDrugsModel.check_id];
    saveModel.rcd_result = [NSString stringWithFormat:@"%@", recDrugsModel.check_result];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in recDrugsModel.druguse_items) {
        NSDictionary *other = [NSDictionary dictionaryWithDictionary:dic];
        [list addObject:other];
    }
    saveModel.druguse_items = list;
    saveModel.msg_flag = self.msgFlag ? self.msgFlag : @"0";
    saveModel.msg_id = self.msgId ? self.msgId : @"0";
    saveModel.visit_id = @"0";
    saveModel.allergy_codes = @"";
    saveModel.allergy_names = @"";
    saveModel.analysis_result = @"";
    saveModel.analysis_suggestion = @"";
    WS(weakSelf)
    [[MessageRequest new] postSaveMedicalRcd:saveModel complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.collectionButton.enabled = YES;
            if (genneralBackModel.retcode == 0) {
                
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseRecDrug" object:nil];
                NSString *reid = [NSString stringWithFormat:@"%@", genneralBackModel.data];
                weakSelf.recordDatas = @{@"recipe_id": reid};
                weakSelf.recipe_id = [NSString stringWithFormat:@"%@", genneralBackModel.data];
                [weakSelf.view makeToast:@"保存成功"];
                [weakSelf.collectionButton setTitle:@"发送处方" forState:UIControlStateNormal];
                
//            [weakSelf.recDrugsView resetTouchEnable:NO];
                
            }
            else{
                [weakSelf.view makeToast:genneralBackModel.retmsg];
            }

        });
        
    }];
}

-(void)openClinicalDiagnosis{
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGBA(51, 51, 51, 0.7);
    bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [bgView  addGestureRecognizer:backTap];
    [self.clinicalDiagnosisView addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.clinicalDiagnosisView, 0)
    .rightSpaceToView(self.clinicalDiagnosisView, 0)
    .topSpaceToView(self.clinicalDiagnosisView, 0)
    .bottomSpaceToView(self.clinicalDiagnosisView, 0);
    
    self.diseaseLibraryView = [DiseaseLibraryView new];
    self.diseaseLibraryView.typeInteger = 1;
//    [self.diseaseLibraryView.searchView.textField addTarget:self action:@selector(searchViewTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
        if (!weakSelf.mid || weakSelf.mid.length == 0) {
            weakSelf.mid = [NSString stringWithFormat:@"%@", GetUserDefault(UserID)];
        }
        weakSelf.recDrugsView.model = weakSelf.model;
        [[RecDrugsRequest new] getRecipeDruguse:weakSelf.mid recipeId:@"0" checkId:@"0" complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            NSArray *array = genneralBackModel.data;
            
            if (array.count > 0) {
                
                //                [weakSelf.dataArray removeAllObjects];
                
                for (NSDictionary *dict in array) {
                    
                    DrugDosageModel *drugDosageModel = [DrugDosageModel new];
                    [drugDosageModel setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArray addObject:drugDosageModel];
                    
                }
                
                [weakSelf.recDrugsView reloadDatas: weakSelf.dataArray];
                
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
//        weakSelf.model.check_result = model.name;
        weakSelf.recipelist_id = [NSString stringWithFormat:@"%@",@(model.pkid)];
        if (weakSelf.model) {
            weakSelf.model.check_result = model.name;
            weakSelf.model.check_id = weakSelf.check_id;
        }
//        [weakSelf requestRecDrugsByCheckId:weakSelf.check_id recipeId:weakSelf.recipelist_id];
        
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
