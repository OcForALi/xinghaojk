//
//  PatientInfoViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientInfoViewController.h"
#import "PatientInfoViewModel.h"
#import "PatientInfoView.h"
#import "EditUserInfoViewController.h"

@interface PatientInfoViewController ()

@property (nonatomic, strong) PatientInfoView *patientInfoView;

@end

@implementation PatientInfoViewController
@synthesize patientInfoView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"患者个人信息";
    self.patientInfoView.dataSources = @[@"备注名", @"昵称", @"性别", @"地址", @"电话", @"加入时间"];
    self.patientInfoView.model = self.model;
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
            
        @strongify(self);
        [self save];
    }];
}


#pragma mark - lazy
- (PatientInfoView *)patientInfoView {
    
    if (!patientInfoView) {
        
        patientInfoView = [[PatientInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:patientInfoView];
        
        @weakify(self);
        [patientInfoView setGoViewController:^(UIViewController *viewController) {
           
            @strongify(self);
            EditUserInfoViewController *vc = (EditUserInfoViewController *)viewController;
            [self.navigationController pushViewController:vc animated:YES];
            vc.completeBlock = ^(id object) {
                NSString *remark = (NSString *)object;
                self.model.remarks = remark;
                self.patientInfoView.model = self.model;
                [self save];
            };
            
        }];
    }
    
    return patientInfoView;
}


#pragma mark - request
- (void)save {
    
    PatientsDetailsModel *model = self.patientInfoView.model;
    [[PatientInfoViewModel new] savePatientRemark:model.remarks mid:model.pkid complete:^(id object) {
        [self.view makeToast:object];
//        if ([object isEqualToString:@"备注修改成功"]) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
    }];
}

@end
