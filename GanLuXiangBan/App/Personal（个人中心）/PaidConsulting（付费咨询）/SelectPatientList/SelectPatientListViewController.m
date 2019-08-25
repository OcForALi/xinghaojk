//
//  SelectPatientListViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/8/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelectPatientListViewController.h"
#import "PatientsViewModel.h"
#import "PatientListView.h"
#import "SearchView.h"
#import "CheckTimeListView.h"
#import "GroupEditorViewModel.h"
#import "CheckYearModel.h"

@interface SelectPatientListViewController ()

@property (nonatomic, strong) CheckTimeListView *checkTimeListView;
@property (nonatomic, strong) PatientListView *patientListView;
@property (nonatomic, strong) UILabel *gourpNameLabel;
@property (nonatomic, strong) id dataSource;
@property (nonatomic, strong) NSArray *gourpNames;

@end

@implementation SelectPatientListViewController
@synthesize patientListView;
@synthesize checkTimeListView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"患者列表";
    [self initSearchView];
    [self selectGroup];
    [self getDataSource];
    [self getLabelList];
    
    @weakify(self);
    [self addNavRightTitle:@"确定" complete:^{
        
        @strongify(self);
        if (self.completeBlock) {
            
            NSArray *keys = self.patientListView.dictDataSource.allKeys;
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i < keys.count; i++) {
                
                NSArray *values = self.patientListView.dictDataSource[keys[i]];
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

- (void)initSearchView {
    
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    searchView.textField.placeholder = @"请输入患者的名字";
    [self.view addSubview:searchView];
    
    [searchView setSearchBlock:^(NSString *searchTextString) {
        
        if (searchTextString.length > 0) {
            
            NSMutableArray *searchArray = [NSMutableArray array];
            
            NSArray *array = [self.dataSource allKeys];
            for (int i = 0; i < array.count; i++) {
                
                for (PatientsModel *model in [self.dataSource objectForKey:array[i]]) {
                    if ([model.membername containsString:searchTextString] || [model.mobile containsString:searchTextString]) {
                        [searchArray addObject:model];
                    }
                }
            }
            
            if (searchArray.count != 0) {
                
                NSDictionary *dict = @{@"initils" : searchArray};
                self.patientListView.dictDataSource = dict;
            }
            else {
                [self.view makeToast:@"没有搜索到该患者"];
            }
            
        }
        else {
            self.patientListView.dictDataSource = self.dataSource;
        }
    }];
}

// 选择组类型
- (void)selectGroup {
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = CGRectMake(0, 55, ScreenWidth, 45);
    bgBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgBtn];
    
    @weakify(self);
    [[bgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        @strongify(self);
        
        NSMutableArray *dataSource = [NSMutableArray array];
        CheckYearModel *model = [CheckYearModel new];
        for (NSString *name in self.gourpNames) {
            
            CheckYearItemsModel *model = [CheckYearItemsModel new];
            model.month_day = name;
            [dataSource addObject:model];
        }
        model.items = dataSource;
        
        self.checkTimeListView.navName = self.title;
        self.checkTimeListView.dataSource = @[model];
        self.checkTimeListView.isHidden = NO;
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    lineView.backgroundColor = kLineColor;
    [bgBtn addSubview:lineView];
 
    self.gourpNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 15, 45)];
    self.gourpNameLabel.text = @"全部患者";
    self.gourpNameLabel.font = [UIFont systemFontOfSize:14];
    self.gourpNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [bgBtn addSubview:self.gourpNameLabel];
}

#pragma mark - patientListView
- (CheckTimeListView *)checkTimeListView {
    
    if (!checkTimeListView) {
        
        checkTimeListView = [[CheckTimeListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [[UIApplication sharedApplication].keyWindow addSubview:checkTimeListView];
        
        @weakify(self);
        [checkTimeListView setDismissBlock:^{
            
            @strongify(self);
            
            [self.checkTimeListView removeFromSuperview];
            self.checkTimeListView = nil;
        }];
        
        [checkTimeListView setSelectBlock:^(NSString *selectTitle) {
           
            @strongify(self);
           
            self.gourpNameLabel.text = selectTitle;
            
            NSMutableArray *searchArray = [NSMutableArray array];
            NSArray *array = [self.dataSource allKeys];
            for (int i = 0; i < array.count; i++) {
                
                for (PatientsModel *model in [self.dataSource objectForKey:array[i]]) {
                    if ([model.label_name containsString:selectTitle]) {
                        [searchArray addObject:model];
                    }
                }
            }
            
            if (searchArray.count != 0) {
                
                NSDictionary *dict = @{@"" : searchArray};
                self.patientListView.dictDataSource = dict;
            }
            
            [self.checkTimeListView removeFromSuperview];
            self.checkTimeListView = nil;
        }];
    }
    
    return checkTimeListView;
}

- (PatientListView *)patientListView {
    
    if (!patientListView) {
        
        patientListView = [[PatientListView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight - self.navHeight - 100) style:UITableViewStyleGrouped];
        [self.view addSubview:patientListView];
    }
    
    return patientListView;
}


#pragma mark - request
- (void)getDataSource {
    
    [[PatientsViewModel new] getDrPatientWithIds:self.selectIdArray complete:^(id object) {
        self.patientListView.dictDataSource = object;
        self.dataSource = object;
    }];
}

#pragma mark - request
- (void)getLabelList {
    
    [[GroupEditorViewModel new] getLabelListComplete:^(id object) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (GroupEditorModel *model in object) {
            [arr addObject:model.name];
        }
        
        self.gourpNames = arr;
    }];
}

@end
