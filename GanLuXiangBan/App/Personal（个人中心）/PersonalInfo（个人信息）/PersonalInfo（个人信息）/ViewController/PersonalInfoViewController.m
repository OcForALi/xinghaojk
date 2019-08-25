//
//  PersonalInfoViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalInfoView.h"
#import "PersonalInfoViewModel.h"
#import "DrugModel.h"

@interface PersonalInfoViewController ()

@property (nonatomic, strong) PersonalInfoView *personalInfoView;
@property (nonatomic, strong) PersonalInfoViewModel *viewModel;

@end

@implementation PersonalInfoViewController
@synthesize viewModel;
@synthesize personalInfoView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    [self getInfo];
    
    WS(weakSelf);
    [self addNavRightTitle:@"保存" complete:^{
        [weakSelf saveUserInfo];
    }];
    
    self.personalInfoView.model = [PersonalInfoModel new];
}

#pragma mark - lazy
- (PersonalInfoViewModel *)viewModel {
    
    if (!viewModel) {
        viewModel = [PersonalInfoViewModel new];
    }
    
    return viewModel;
}

- (PersonalInfoView *)personalInfoView {
    
    if (!personalInfoView) {
        
        personalInfoView = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height) style:UITableViewStyleGrouped];
        personalInfoView.dataSources = @[@[@"姓名", @"性别"], @[@"医院", @"科室", @"职称"], @[@"擅长", @"简介"], @[@"身份认证", @"资格认证"]];
        [self.view addSubview:personalInfoView];
        
        @weakify(self);
        [personalInfoView setGoViewControllerBlock:^(BaseViewController *viewController) {
            
            @strongify(self);
            [self goViewControllerWith:viewController];
        }];
    }
    
    return personalInfoView;
}

#pragma mark - request
// 获取用户信息
- (void)getInfo {
    
    @weakify(self);
    [self.viewModel getDoctorInfoWithId:GetUserDefault(UserID) complete:^(PersonalInfoModel *model) {
        
        @strongify(self);
        if (model.Pkid != nil) {
            if (!model.Title) {
                model.Title = @"";
            }
            self.personalInfoView.model = model;
            
        }
        else {
            
            [self.view makeToast:@"请求失败"];
        }
    }];
}

- (void)saveUserInfo {
    
    @weakify(self);
    [self.viewModel uploadUserInfoWithModel:self.personalInfoView.model complete:^(id object) {
     
        @strongify(self);
        if ([object isKindOfClass:[NSError class]]) {
            [self.view makeToast:@"修改用户信息失败"];
        }
        else {
            [self.view makeToast:@"保存用户信息成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - push
- (void)goViewControllerWith:(BaseViewController *)viewController {
    
    __weak typeof(viewController)weakVC = viewController;
    [viewController setCompleteBlock:^(id object) {
        
        if ([weakVC isKindOfClass:[NSClassFromString(@"EditUserInfoViewController") class]]) {
            self.personalInfoView.model.Name = object;
        }
        else if ([weakVC isKindOfClass:[NSClassFromString(@"SelHospitalViewController") class]]) {
            self.personalInfoView.model.HospitalName = object;
        }
        else if ([weakVC isKindOfClass:[NSClassFromString(@"SelDepartmentViewController") class]]) {
            
            DrugModel *model = object;
            self.personalInfoView.model.CustName = model.name;
        }
        else if ([weakVC isKindOfClass:[NSClassFromString(@"ModifyViewController") class]]) {
            
            if ([weakVC.title isEqualToString:@"擅长"]) {
                self.personalInfoView.model.Remark = object;
            }
            else {
                self.personalInfoView.model.Introduction = object;
            }
        }
        else if ([weakVC isKindOfClass:[NSClassFromString(@"CertificationViewController") class]]) {
            
            if ([weakVC.title isEqualToString:@"身份认证"]) {
                self.personalInfoView.model.idt_auth_status = object;
            }
            else {
                self.personalInfoView.model.Auth_Status = object;
            }
        }
        
        [self.personalInfoView reloadData];
    }];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
