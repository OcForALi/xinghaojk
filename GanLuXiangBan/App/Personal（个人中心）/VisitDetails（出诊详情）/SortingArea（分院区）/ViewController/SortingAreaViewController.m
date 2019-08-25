//
//  SortingAreaViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SortingAreaViewController.h"
#import "SortingAreaView.h"
#import "SortingAreaViewModel.h"

@interface SortingAreaViewController ()

@property (nonatomic, strong) SortingAreaView *sortingAreaView;
@property (nonatomic, strong) SortingAreaViewModel *viewModel;

@end

@implementation SortingAreaViewController
@synthesize sortingAreaView;
@synthesize viewModel;

- (void)viewDidLoad {

    [super viewDidLoad];

    // 标题
    self.title = @"分院区";
    [self getSortingAreaList];
}

#pragma mark - lazy
- (SortingAreaView *)sortingAreaView {
    
    if (!sortingAreaView) {
        
        sortingAreaView = [[SortingAreaView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:sortingAreaView];
        
        @weakify(self);
        [sortingAreaView setDeleteBlock:^(SortingAreaModel *model) {
            
            @strongify(self);
            NSString *msgString = model.text;
            [self deleteAlertWithMsg:msgString idStirng:model.id];
        }];
        
        [sortingAreaView setAddBlock:^(NSString *textString) {
           
            @strongify(self);
            [self addaddHospitalWithName:textString];
        }];
    }
    
    return sortingAreaView;
}

#pragma mark - request
- (SortingAreaViewModel *)viewModel {
    
    if (!viewModel) {
        
        viewModel = [SortingAreaViewModel new];
    }
    
    return viewModel;
}

- (void)getSortingAreaList {
    
    @weakify(self);
    [self.viewModel getHospitalListComplete:^(id object) {
        
        @strongify(self);
        self.sortingAreaView.dataSources = object;
    }];
}

- (void)addaddHospitalWithName:(NSString *)nameString {
    
    @weakify(self);
    [self.viewModel addHospitalWithName:nameString Complete:^(id object) {
       
        @strongify(self);
        [self.view makeToast:object];
        [self getSortingAreaList];
    }];
}

- (void)deleteSortingAreaWithId:(NSString *)idString {
  
    @weakify(self);
    [self.viewModel deleteHospitalWithId:idString Complete:^(id object) {
        
        @strongify(self);
        [self.view makeToast:object];
        [self getSortingAreaList];
    }];
}

#pragma mark - Alert
- (void)deleteAlertWithMsg:(NSString *)msg idStirng:(NSString *)idStirng {
    
    NSString *msgString = [NSString stringWithFormat:@"\n您确定要删除%@", msg];
    [self alertWithTitle:@"温馨提示" msg:msgString isShowCancel:YES complete:^{
        [self deleteSortingAreaWithId:idStirng];
    }];
}

@end
