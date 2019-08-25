//
//  MyPrescriptionController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyPrescriptionController.h"

#import "MyPrescriptionModel.h"
#import "MyPrescriptionView.h"
#import "MedicalRecordsRequset.h"
#import "MedicationDetailsViewController.h"
#import "RecDrugsViewController.h"

@interface MyPrescriptionController ()
@property (nonatomic, strong) MyPrescriptionView *tableView;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *haveBuyLabel;
@property (nonatomic, strong) UILabel *noBuyLabel;
@property (nonatomic, strong) UILabel *haveDeliveryLabel;
@property (nonatomic, strong) UILabel *haveGoodsLabel;
@property (nonatomic, strong) UILabel *noEffectLabel;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation MyPrescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我开具的处方";
    self.pageNo = 1;
    [self setupUI];
    [self requestStatic];
    [self requestList];
}

- (void)requestStatic {
    WS(weakSelf)
    [[MedicalRecordsRequset new] getMedicalStatic:^(HttpGeneralBackModel *model) {
        if (model && model.data) {
            MyPrescriptionModel *obj = [MyPrescriptionModel new];
            [obj setValuesForKeysWithDictionary:model.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.totalLabel.text = [NSString stringWithFormat:@"%@", obj.total];
                weakSelf.haveBuyLabel.text = [NSString stringWithFormat:@"%@", obj.purchased_count];
                weakSelf.noBuyLabel.text = [NSString stringWithFormat:@"%@", obj.nopurchase_count];
                weakSelf.haveDeliveryLabel.text = [NSString stringWithFormat:@"%@", obj.shipped_count];
                weakSelf.haveGoodsLabel.text = [NSString stringWithFormat:@"%@", obj.received_count];
                weakSelf.noEffectLabel.text = [NSString stringWithFormat:@"%@", obj.ineffective_count];
            });
        }
    }];
}

- (void)requestList {
    WS(weakSelf)
    [[MedicalRecordsRequset new] getMedicationRecordsKey:@"" page:self.pageNo complete:^(HttpGeneralBackModel *model) {
        if ([weakSelf.tableView.mj_header isRefreshing]) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        if ([weakSelf.tableView.mj_footer isRefreshing]) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        NSMutableArray *list = [[NSMutableArray alloc] init];
        if (weakSelf.pageNo > 1) {
            [list addObjectsFromArray:weakSelf.tableView.dataSources];
        }
        if (model && model.data) {
            for (NSDictionary *dic in model.data) {
                MedicalRecordsModel *gift = [MedicalRecordsModel new];
                [gift setValuesForKeysWithDictionary:dic];
                [list addObject:gift];
            }
        }
        weakSelf.tableView.mj_footer.hidden = list.count < weakSelf.pageNo * 10;
        weakSelf.tableView.dataSources = list;
    }];
}

- (UILabel *)setupLabel:(NSString *)title type:(NSInteger)type view:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontRegular(14);
    label.textColor = type == 1 ? kMainColor : kSixColor;
    label.text = title;
    [view addSubview:label];
    return label;
}

- (void)setupUI {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    UILabel *left = [self setupLabel:@"总开具" type:0 view:headerView];
    UILabel *middle = [self setupLabel:@"已购买" type:0 view:headerView];
    UILabel *right = [self setupLabel:@"未购买" type:0 view:headerView];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right);
        make.top.height.width.equalTo(left);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(middle.mas_right);
        make.top.height.width.equalTo(left);
    }];
    self.totalLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.haveBuyLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.noBuyLabel = [self setupLabel:@"0" type:1 view:headerView];;
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(left.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.haveBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalLabel.mas_right);
        make.top.height.width.equalTo(self.totalLabel);
    }];
    [self.noBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(self.haveBuyLabel.mas_right);
        make.top.height.width.equalTo(self.totalLabel);
    }];
    UILabel *del = [self setupLabel:@"已发货" type:0 view:headerView];
    UILabel *rec = [self setupLabel:@"已收货" type:0 view:headerView];
    UILabel *infect = [self setupLabel:@"未生效" type:0 view:headerView];
    [del mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.haveBuyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [rec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(del.mas_right);
        make.top.height.width.equalTo(del);
    }];
    [infect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(rec.mas_right);
        make.top.height.width.equalTo(del);
    }];
    self.haveDeliveryLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.haveGoodsLabel = [self setupLabel:@"0" type:1 view:headerView];
    self.noEffectLabel = [self setupLabel:@"0" type:1 view:headerView];;
    [self.haveDeliveryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(del.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.haveGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.haveDeliveryLabel.mas_right);
        make.top.height.width.equalTo(self.haveDeliveryLabel);
    }];
    [self.noEffectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.equalTo(self.haveGoodsLabel.mas_right);
        make.top.height.width.equalTo(self.haveDeliveryLabel);
    }];
    
    self.tableView = [MyPrescriptionView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
    }];
    
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf requestList];
    }];
    self.tableView.pushBlock = ^(MedicalRecordsModel *model) {
        
        if ([@"0" isEqualToString:model.status]) {
            [weakSelf getUnsendRecipeDatas:model];
        }
        else {
            MedicationDetailsViewController *medicationDetailsView = [[MedicationDetailsViewController alloc] init];
            medicationDetailsView.model = model;
            [weakSelf.navigationController pushViewController:medicationDetailsView animated:YES];
        }
//        MedicationDetailsViewController *medicationDetailsView = [[MedicationDetailsViewController alloc] init];
//        medicationDetailsView.model = model;
//        [weakSelf.navigationController pushViewController:medicationDetailsView animated:YES];
        
    };
}

- (void)getUnsendRecipeDatas:(MedicalRecordsModel *)model {
    NSString *str = [NSString stringWithFormat:@"%@", @(model.recipe_id)];
    WS(weakSelf)
    [[MedicalRecordsRequset new] getUnsendRecipeDetail:str complete:^(HttpGeneralBackModel *genneralBackModel) {
        if (genneralBackModel.data) {
            RecDrugsViewController *rec = [RecDrugsViewController new];
            rec.type = 10;
            rec.name = model.patient_name;
            rec.age = [NSString stringWithFormat:@"%@", @(model.patient_age)];
            rec.gender = model.patient_gender;
            rec.recordDatas = genneralBackModel.data;
            [weakSelf.navigationController pushViewController:rec animated:YES];
        }
    }];
}

@end
