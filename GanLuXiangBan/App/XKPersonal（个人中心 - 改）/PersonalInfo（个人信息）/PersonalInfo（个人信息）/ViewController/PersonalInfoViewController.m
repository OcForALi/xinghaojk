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
#import "CertificationViewController.h"

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
        personalInfoView.dataSources = @[@[@"姓名", @"性别", @"身份证号", @"代理区域"], @[@"身份认证", @"资格验证"]];
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
        if (model.pkid != nil) {
            
            if (!model.title) {
                model.title = @"";
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
            
            [[UIApplication sharedApplication].keyWindow makeToast:@"保存用户信息成功"];
            
            SetUserDefault(UserName, self.personalInfoView.model.name);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - push
- (void)goViewControllerWith:(BaseViewController *)viewController {
    
    __weak typeof(viewController)weakVC = viewController;
    [viewController setCompleteBlock:^(id object) {
        
        if ([weakVC isKindOfClass:[NSClassFromString(@"EditUserInfoViewController") class]]) {
            
            if ([weakVC.title isEqualToString:@"身份证号"]) {
                self.personalInfoView.model.idcard = object;
            }
            else {
                self.personalInfoView.model.name = object;
            }
        }
        else if ([weakVC isKindOfClass:[NSClassFromString(@"CertificationViewController") class]]) {
            
            if ([weakVC.title isEqualToString:@"身份认证"]) {
                
                self.personalInfoView.model.auth_status = object;
            }
            else {
                
                
                self.personalInfoView.model.certification_status = object;
            }
        }
        
        [self.personalInfoView reloadData];
    }];
    
    if ([viewController isKindOfClass:[CertificationViewController class]]) {
        
        CertificationViewController *vc = (CertificationViewController *)viewController;
        if ([vc.title isEqualToString:@"身份认证"]) {
            
            NSMutableArray *arr = [NSMutableArray array];
            if ([self.personalInfoView.model.auth_items isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in self.personalInfoView.model.auth_items) {
                    [arr addObject:dict[@"file_path"]];
                }
            }
            
            vc.state = [self.personalInfoView.model.auth_status intValue];
            vc.imgs = arr;
        }
        else {
            
            NSMutableArray *arr = [NSMutableArray array];
            if ([self.personalInfoView.model.certification_items isKindOfClass:[NSArray class]]) {
             
                for (NSDictionary *dict in self.personalInfoView.model.certification_items) {
                    [arr addObject:dict[@"file_path"]];
                }
            }
            
            vc.state = [self.personalInfoView.model.certification_status intValue];
            vc.imgs = arr;
        }
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
