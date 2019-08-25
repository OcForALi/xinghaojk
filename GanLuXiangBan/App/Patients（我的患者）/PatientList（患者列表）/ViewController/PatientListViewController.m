//
//  PatientListViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientListViewController.h"
#import "PatientsViewModel.h"
#import "PatientListView.h"
#import "SearchView.h"
#import "PatientGroupRightView.h"
#import "GroupEditorViewModel.h"

@interface PatientListViewController ()

@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) PatientListView *patientListView;
@property (nonatomic, strong) NSDictionary *allDatas;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *allButton;

@end

@implementation PatientListViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"患者列表";
    [self setupUI];
    [self getDataSource];
    
    @weakify(self);
    [self addNavRightTitle:@"确定" complete:^{
        
        @strongify(self);
        if (self.completeBlock) {
            
            NSArray *keys = self.allDatas.allKeys;
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i < keys.count; i++) {
                
                NSArray *values = self.allDatas[keys[i]];
                for (PatientsModel *model in values) {
                    
                   if (model.isSelect) {
                        
                        GroupAddModel *groupAddModel = [GroupAddModel new];
                        groupAddModel.mid = model.mid;
                        groupAddModel.head = model.head;
                        groupAddModel.patient_name = model.membername;
                        [arr addObject:groupAddModel];
                    }
                }
            }
            
            self.completeBlock(arr);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)touchSelectAll {
    BOOL sel = ![self.allButton isSelected];
    self.allButton.selected = sel;
    NSDictionary *dic = self.patientListView.dictDataSource;
    if (dic) {
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            NSArray *list = [dic objectForKey:key];
            for (PatientsModel *user in list) {
                user.isSelect = sel;
            }
        }
    }
    self.patientListView.dictDataSource = dic;
    [self countSelectUser];
}

- (void)resetSelectCount {
    BOOL all = YES;
    NSDictionary *dic = self.patientListView.dictDataSource;
    if (dic) {
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            NSArray *list = [dic objectForKey:key];
            for (PatientsModel *user in list) {
                if (!user.isSelect) {
                    all = NO;
                }
            }
        }
    }
    self.allButton.selected = all;
    [self countSelectUser];
}

- (void)countSelectUser {
    NSInteger count = 0;
    if (self.allDatas) {
        NSArray *keys = [self.allDatas allKeys];
        for (NSString *key in keys) {
            NSArray *list = [self.allDatas objectForKey:key];
            for (PatientsModel *user in list) {
                if (user.isSelect) {
                    count++;
                }
            }
        }
    }
    self.countLabel.text = [NSString stringWithFormat:@"已选择 %@ 个患者", @(count)];
}

#pragma mark - patientListView

- (void)setupUI {
    self.searchView = [[SearchView alloc] init];
    [self.view addSubview:self.searchView];
    self.searchView.sd_layout.topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(50);
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    self.bottomView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(50+kTabbarSafeBottomMargin);
    
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allButton.backgroundColor = kMainColor;
    [self.allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allButton setTitle:@"全选" forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(touchSelectAll) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.allButton];
    self.allButton.sd_layout.rightSpaceToView(self.bottomView, 0).topSpaceToView(self.bottomView, 0).heightIs(50).widthIs(88);
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.textColor = kMainTextColor;
    self.countLabel.font = kFontRegular(15);
    self.countLabel.text = @"已选择 0 个患者";
    [self.bottomView addSubview:self.countLabel];
    self.countLabel.sd_layout.leftSpaceToView(self.bottomView, 0).rightSpaceToView(self.allButton, 0).heightIs(30).centerYEqualToView(self.allButton);
    
    self.patientListView = [[PatientListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.patientListView];
    self.patientListView.showFee = self.showConsultFee;
    self.patientListView.sd_layout.topSpaceToView(self.searchView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.bottomView, 0);
    
    GroupEditorModel *all = [GroupEditorModel new];
    all.name = @"全部患者";
    self.patientListView.currentGroup = all;
    
    WS(weakSelf)
    self.searchView.searchConfirm = ^(NSString *key) {
        [weakSelf searchPatient:key];
    };
    
    self.patientListView.didSelectPatientGroupBlock = ^(GroupEditorModel *model) {
        [weakSelf getGroups];
    };
    
    self.patientListView.didSelectPatientBlock = ^(NSDictionary *dic) {
        [weakSelf resetSelectCount];
    };
}


#pragma mark - request

- (void)searchPatient:(NSString *)key {
    if (key && key.length > 0 && self.allDatas) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        NSArray *keys = [self.allDatas allKeys];
        for (NSString *sec in keys) {
            NSArray *list = [self.allDatas objectForKey:sec];
            NSMutableArray *datas = [[NSMutableArray alloc] init];
            for (PatientsModel *user in list) {
                if ([user.membername containsString:key]) {
                    [datas addObject:user];
                }
            }
            if (datas.count > 0) {
                [result setObject:datas forKey:sec];
            }
        }
        if (result.count <= 0) {
            [self.view makeToast:@"没有搜索到相关患者"];
        }
        self.patientListView.dictDataSource = result;
        [self resetSelectCount];
    }
    else if (self.allDatas) {
        self.patientListView.dictDataSource = self.allDatas;
    }
    else {
        self.patientListView.dictDataSource = [NSDictionary dictionary];
    }
}

- (void)searchPatientGroups:(GroupEditorModel *)group {
    if (group && group.name && ![group.name isEqualToString:@"全部患者"] && self.allDatas) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        NSArray *keys = [self.allDatas allKeys];
        for (NSString *sec in keys) {
            NSArray *list = [self.allDatas objectForKey:sec];
            NSMutableArray *datas = [[NSMutableArray alloc] init];
            for (PatientsModel *user in list) {
                if ([user.label_name containsString:group.name]) {
                    [datas addObject:user];
                }
            }
            if (datas.count > 0) {
                [result setObject:datas forKey:sec];
            }
        }
        if (result.count <= 0) {
            [self.view makeToast:@"没有搜索到相关患者"];
        }
        self.patientListView.currentGroup = group;
        self.patientListView.dictDataSource = result;
        [self resetSelectCount];
    }
    else if (self.allDatas) {
        self.patientListView.currentGroup = group;
        self.patientListView.dictDataSource = self.allDatas;
        [self resetSelectCount];
    }
    else {
        GroupEditorModel *all = [GroupEditorModel new];
        all.name = @"全部患者";
        self.patientListView.currentGroup = all;
        self.patientListView.dictDataSource = [NSDictionary dictionary];
    }
}

- (void)getDataSource {
    
    WS(weakSelf)
    [[PatientsViewModel new] getDrPatientWithIds:self.selectIdArray complete:^(id object) {
        NSDictionary *dic = object;
        weakSelf.allDatas = [NSDictionary dictionaryWithDictionary:dic];
        weakSelf.patientListView.dictDataSource = object;
        [weakSelf resetSelectCount];
    }];
}

- (void)getGroups {
    WS(weakSelf)
    [[GroupEditorViewModel new] getLabelListComplete:^(id object) {
        NSArray *groups = object;
        GroupEditorModel *all = [GroupEditorModel new];
        all.name = @"全部患者";
        NSMutableArray *res = [NSMutableArray new];
        [res addObject:all];
        if (groups && groups.count > 0) {
            [res addObjectsFromArray:groups];
        }
        [weakSelf showGroups:res];
    }];
}

- (void)showGroups:(NSArray *)groups {
    WS(weakSelf)
    [PatientGroupRightView show:groups complete:^(BOOL cancel, GroupEditorModel *model) {
        if (!cancel && model) {
            [weakSelf searchPatientGroups:model];
        }
    }];
}

@end
