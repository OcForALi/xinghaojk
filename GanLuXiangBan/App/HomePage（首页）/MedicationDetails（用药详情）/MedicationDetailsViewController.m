//
//  MedicationDetailsViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MedicationDetailsViewController.h"
#import "MedicalRecordsRequset.h"
#import "MedicationDetailsModel.h"
#import "MedicationDetailsView.h"

@interface MedicationDetailsViewController ()

@property (nonatomic ,retain) MedicalRecordsRequset *medicalRequest;

@property (nonatomic ,strong) MedicationDetailsView *medicationDetailsView;

@end

@implementation MedicationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用药详情";
    
    [self initUI];
    
}

-(void)setModel:(MedicalRecordsModel *)model{
    
    _model = model;
//    model.recipe_id = 1723;
//    model.status = @"1";
    [self request];

}

-(void)initUI{
    
    self.medicationDetailsView = [MedicationDetailsView new];
    self.medicationDetailsView.status = self.model.status;
    self.medicationDetailsView.recipeid = [NSString stringWithFormat:@"%@",@(self.model.recipe_id)];
    [self.view addSubview:self.medicationDetailsView];
    [self.medicationDetailsView reloadStatus:self.model.status payStatus:self.model.pay_status];
    
    self.medicationDetailsView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
}

-(void)request{
    
    self.medicalRequest = [MedicalRecordsRequset new];
    WS(weakSelf)
    [self.medicalRequest getMedicatinDetailRecipe_id:self.model.recipe_id status:self.model.status complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        MedicationDetailsModel *model = [MedicationDetailsModel new];
        [model setValuesForKeysWithDictionary:genneralBackModel.data];
        NSArray *list = model.logistics_list;
        if (list && list.count > 0) {
            NSArray *res = [NSArray yy_modelArrayWithClass:MedicationDetailsLogisticsModel.class json:list];
            model.logistics_list = res;
        }
        
        weakSelf.medicationDetailsView.model = model;
        
    }];
    
}

@end
