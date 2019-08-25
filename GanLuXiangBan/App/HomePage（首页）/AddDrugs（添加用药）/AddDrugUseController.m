//
//  AddDrugUseController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/5.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AddDrugUseController.h"

#import "AddDrugsView.h"
#import "DrugRequest.h"
#import "AddDrugsCustomController.h"

@interface AddDrugUseController ()
@property (nonatomic, strong) AddDrugsView *addView;
@end

@implementation AddDrugUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑药品";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.model) {
        if (self.showOne) {
            self.model.buy_num = @"1";
        }
        if (self.model.producer && self.model.producer.length > 0) {
            [self setupUI];
        }
        else {
            [self getDrugDetails];
        }
    }
}

- (NSString *)parseDrugParam:(NSDictionary *)dic key:(NSString *)key {
    if (dic && dic[key]) {
        NSString *va = [NSString stringWithFormat:@"%@", dic[key]];
        if (va && va.length > 0 && ![[va lowercaseString] isEqualToString:@"null"] && ![[va lowercaseString] isEqualToString:@"<null>"]) {
            return va;
        }
    }
    return nil;
}

- (void)getDrugDetails {
    WS(weakSelf)
    [[DrugRequest new] getDrugDetailDrugID:self.model.drugid :^(HttpGeneralBackModel *model) {
        if (model.data) {
            NSDictionary *dic = (NSDictionary *)(model.data);
            NSDictionary *usage = [dic objectForKey:@"drug_usage"];
            if (weakSelf.type != 3 && usage) {
                NSString *unit = [weakSelf parseDrugParam:usage key:@"unit"];
                if (unit && unit.length > 0) {
                    weakSelf.model.unit_name = unit;
                }
                NSString *remark = [weakSelf parseDrugParam:usage key:@"remark"];
                if (remark && remark.length > 0) {
                    weakSelf.model.remark = remark;
                }
                NSString *numName = [weakSelf parseDrugParam:usage key:@"use_num_name"];
                if (numName && numName.length > 0) {
                    weakSelf.model.use_num_name = numName;
                }
                NSString *useType = [weakSelf parseDrugParam:usage key:@"use_type"];
                if (useType && useType.length > 0) {
                    weakSelf.model.use_type = useType;
                }
                NSString *useCycle = [weakSelf parseDrugParam:usage key:@"frequency_cycle"];
                if (useCycle && useCycle.length > 0) {
                    weakSelf.model.use_cycle = useCycle;
                }
                NSString *dayUse = [weakSelf parseDrugParam:usage key:@"frequency_num"];
                if (dayUse && dayUse.length > 0) {
                    weakSelf.model.day_use = dayUse;
                }
                NSString *useNum = [weakSelf parseDrugParam:usage key:@"use_num"];
                if (useNum && useNum.length > 0) {
                    weakSelf.model.use_num = useNum;
                }
                NSString *dayUseNum = [weakSelf parseDrugParam:usage key:@"frequency"];
                if (dayUseNum && dayUseNum.length > 0) {
                    weakSelf.model.day_use_num = dayUseNum;
                }
                NSString *buy_num = [weakSelf parseDrugParam:usage key:@"buy_num"];
                if (buy_num && buy_num.length > 0) {
                    weakSelf.model.buy_num = buy_num;
                }
            }
            NSString *com = [weakSelf parseDrugParam:dic key:@"producer"];
            if (com && com.length > 0) {
                weakSelf.model.producer = com;
            }
            [weakSelf setupUI];
        }
    }];
}

- (UILabel *)setupLabel:(NSString *)txt type:(NSInteger)type {
    UILabel *label = [[UILabel alloc] init];
    if (type == 1) {
        label.text = [NSString stringWithFormat:@"厂家: %@",txt];
    }
    else if (type == 2) {
        label.text = [NSString stringWithFormat:@"规格: %@",txt];
    }
    else {
        label.text = txt;
    }
    label.font = type == 0 ? kFontRegular(15) : kFontRegular(13);
    label.textColor = type == 0 ? kMainTextColor : kNightColor;
    [self.view addSubview:label];
    return label;
}

- (void)setupUI {
    UILabel *name = [self setupLabel:self.model.drug_name type:0];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
    }];
    UILabel *company = [self setupLabel:self.model.producer type:1];
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom);
        make.left.right.equalTo(name);
        make.height.mas_equalTo(28);
    }];
    UILabel *stand = [self setupLabel:self.model.standard type:2];
    [stand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(company.mas_bottom);
        make.left.right.equalTo(company);
        make.height.mas_equalTo(28);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(stand.mas_bottom).mas_offset(14);
        make.left.right.equalTo(stand);
        make.height.mas_equalTo(1);
    }];
    
    self.addView = [[AddDrugsView alloc] init];
    self.addView.model = self.model;
    self.addView.type = self.type;
    [self.view addSubview:self.addView];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.view);
    }];
    
    WS(weakSelf)
    self.addView.addDurgDosageBlock = ^(DrugDosageModel *drugModel) {
        weakSelf.model.use_num = drugModel.use_num;
        weakSelf.model.use_num_name = drugModel.use_num_name;
        weakSelf.model.day_use = drugModel.day_use;
        weakSelf.model.day_use_num = drugModel.day_use_num;
        weakSelf.model.unit_name = drugModel.unit_name;
        weakSelf.model.use_type = drugModel.use_type;
        weakSelf.model.use_cycle = drugModel.use_cycle;
        weakSelf.model.days = drugModel.days;
        if (weakSelf.useBlock) {
            weakSelf.useBlock(weakSelf.model);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.addView.pushBlock = ^(PickerType type) {
        AddDrugsCustomController *vc = [AddDrugsCustomController new];
        vc.pickerType = type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

@end
