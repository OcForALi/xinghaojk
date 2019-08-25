//
//  PrescriptionDetailsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PrescriptionDetailsViewController.h"
#import "PrescriptionDetailsViewModel.h"
#import "PrescriptionDetailsView.h"

#import "PrescriptionModel.h"
#import "PrescriptionRequest.h"

@interface PrescriptionDetailsViewController ()

@property (nonatomic, strong) PrescriptionDetailsView *prescriptionDetailsView;
@property (nonatomic, strong) UIView *infoView;
    
@end

@implementation PrescriptionDetailsViewController
@synthesize prescriptionDetailsView;
@synthesize infoView;
    
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getDataSource];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, 66, 45);
    saveBtn.backgroundColor = kMainColor;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [saveBtn setTitle:@"保存常用" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(touchAddCommonRescription) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
}

- (void)touchAddCommonRescription {
    PrescriptionDetailsModel *detail = self.prescriptionDetailsView.model;
    if (detail) {
        PrescriptionAddModel *model = [PrescriptionAddModel new];
        model.recipe_id = self.idString;
        model.check_id = [NSString stringWithFormat:@"%@", @(detail.check_id)];
        model.check_result = detail.check_result;
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in detail.dicDrugs) {
            PrescriptionAddDrugModel *drug = [PrescriptionAddDrugModel new];
            drug.pkid = 0;
            if (dic[@"drugid"]) {
                drug.drugid = [NSString stringWithFormat:@"%@", dic[@"drugid"]];
            }
            if (!drug.drugid || drug.drugid.length == 0) {
                drug.drugid = [NSString stringWithFormat:@"%@", dic[@"drug_id"]];
            }
            drug.use_num = [NSString stringWithFormat:@"%@",dic[@"use_num"]];
            drug.days = [dic[@"days"] integerValue];
            if (dic[@"use_type"]) {
                drug.use_type = [NSString stringWithFormat:@"%@", dic[@"use_type"]];
            }
            if (dic[@"use_cycle"]) {
                drug.use_cycle = [NSString stringWithFormat:@"%@", dic[@"use_cycle"]];
            }
            if (dic[@"day_use"]) {
                drug.day_use = [NSString stringWithFormat:@"%@", dic[@"day_use"]];
            }
            if (dic[@"day_use_num"]) {
                drug.day_use_num = [NSString stringWithFormat:@"%@",dic[@"day_use_num"]];
            }
            if (dic[@"unit_name"]) {
                drug.use_unit = [NSString stringWithFormat:@"%@", dic[@"unit_name"]];
            }
            if (dic[@"use_num_name"]) {
                drug.use_num_name = [NSString stringWithFormat:@"%@", dic[@"use_num_name"]];
            }
            if (!drug.day_use || drug.day_use.length == 0) {
                drug.day_use = drug.use_num_name;
            }
            [array addObject:drug];
        }
        model.drugs = array;
        WS(weakSelf)
        [[PrescriptionRequest new] postCommonRecipeInfo:model complete:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
            }
            else if (model.retmsg) {
                [weakSelf.view makeToast:model.retmsg];
            }
            else {
                [weakSelf.view makeToast:@"保存成功"];
            }
        }];
    }
}

#pragma mark - lazy
- (PrescriptionDetailsView *)prescriptionDetailsView {
    
    if (!prescriptionDetailsView) {
        
        prescriptionDetailsView = [[PrescriptionDetailsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 70) style:UITableViewStyleGrouped];
        prescriptionDetailsView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:prescriptionDetailsView];
    }
    
    return prescriptionDetailsView;
}


- (UIView *)infoView {
    
    if (!infoView) {
        
        infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(prescriptionDetailsView.frame), ScreenWidth, 70)];
        [self.view addSubview:infoView];
        
        CGFloat width = (ScreenWidth - 40) / 2;
        NSArray *titles = @[@"医       师: ", @"调配药师/士: ", @"审核药师: ", @"核对、发药药师: "];
        NSArray *contents = @[@"", @"", @"", @""];
        
        PrescriptionDetailsModel *model = self.prescriptionDetailsView.model;
        if (model != nil) {
            contents = @[[self isNull:model.recipe_drname],
                         [self isNull:model.allocate_drname],
                         [self isNull:model.check_drname],
                         [self isNull:model.medicine_drname]];
        }
        
        for (int i = 0; i < titles.count; i++) {
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + (width + 10) * (i % 2), 15 + 23 * (i / 2), width, 14)];
            titleLabel.tag = i + 1000;
            titleLabel.text = [NSString stringWithFormat:@"%@ %@", titles[i], contents[i]];
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
            [infoView addSubview:titleLabel];
        }
    }
    
    return infoView;
}

#pragma mark - request
- (void)getDataSource {
    
    [[PrescriptionDetailsViewModel new] getElectronRecipeDetail:self.idString complete:^(id object) {
        self.prescriptionDetailsView.model = object;
        self.infoView.backgroundColor = [UIColor whiteColor];
        
        if ([self.prescriptionDetailsView.model.channel integerValue] == 0) {
            self.title = @"鼎康慈桦互联网医院电子处方单";
        }else{
            self.title = @"广州东泰医疗门诊部电子处方单";
        }
        
    }];
}

// 是否为空
- (NSString *)isNull:(NSString *)string {
    
    if (!string) {
        return @"";
    }

    if ([string isKindOfClass:[NSString class]]) {
        
        if ([string isEqualToString:@"<null>"] ||
            [string isEqualToString:@"[null]"] ||
            [string isEqualToString:@"(null)"])
        {
            return @"";
        }
        else return string;
    }
    
    return @"";
}

@end
