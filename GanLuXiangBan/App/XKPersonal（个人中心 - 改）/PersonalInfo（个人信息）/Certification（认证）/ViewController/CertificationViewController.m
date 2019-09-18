//
//  CertificationViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CertificationViewController.h"
#import "CertificationView.h"
#import "CertificationViewModel.h"
#import "CerImgModel.h"
#import "LogInViewController.h"

@interface CertificationViewController ()

@property (nonatomic, strong) CertificationView *certificationView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSMutableArray *imgArray;

@end

@implementation CertificationViewController
@synthesize certificationView;
@synthesize submitBtn;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.imgArray = [NSMutableArray array];
    [self.imgArray addObjectsFromArray:@[@"", @"", @""]];
    if ([self.title isEqualToString:@"身份认证"]) {
        
        self.certificationView.dataSources = @[@"身份证正面", @"身份证反面"];
    }
    else {
        
        self.certificationView.dataSources = @[@"相关授权资质", @"", @""];
    }
    
    [self btnStateChangeWithState:self.state];
}

- (void)initErrorView {
    
    if (self.certificationView.y == 0) {
        
        UIView *errorBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        errorBgView.backgroundColor = [UIColor redColor];
        [self.view addSubview:errorBgView];
        
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 70)];
        errorLabel.text = self.certificationView.cerImgModel.idt_auth_remark;
        errorLabel.font = [UIFont systemFontOfSize:14];
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.numberOfLines = 0;
        errorLabel.height = [errorLabel getTextHeight] + 15;
        [errorBgView addSubview:errorLabel];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            errorBgView.height = errorLabel.height;
            self.certificationView.y = errorBgView.height;
            self.certificationView.height -= errorBgView.height;
        }];
    }
}

- (void)btnStateChangeWithState:(int)state {
    
    if (state == 3) {
        
        CerImgModel *model = self.certificationView.cerImgModel;
        if (model.practice_card > 0) {
            
            NSArray *arr = @[model.emp_card, model.qualification_card, model.practice_card];
            for (int i = 0; i < 3; i++) {
                [self.imgArray replaceObjectAtIndex:i withObject:arr[i]];
            }
        }
        else {
            
            NSArray *arr = @[model.id_card_face, model.id_card_con];
            for (int i = 0; i < 3; i++) {
                [self.imgArray replaceObjectAtIndex:i withObject:arr[i]];
            }
        }
        
    }
    
    switch (state) {
            
        case 1:
            
            self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
            [self.submitBtn setTitle:@"身份验证中" forState:UIControlStateNormal];
            break;
            
        case 2:
            
            self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
            [self.submitBtn setTitle:@"审核已通过" forState:UIControlStateNormal];
            break;
            
        case 3:
            
            [self initErrorView];
            
        default:
            
            self.submitBtn.backgroundColor = kMainColor;
            [self.submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
            break;
    }
}

#pragma mark - lazy
- (CertificationView *)certificationView {
    
    if (!certificationView) {
        
        certificationView = [[CertificationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
        certificationView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:certificationView];
        
        WS(weakSelf);
        [certificationView setGoImgBlock:^(UIViewController *viewController) {
            
            [weakSelf.navigationController presentViewController:viewController animated:YES completion:nil];
        }];
        
        [certificationView setUploadImg:^(NSInteger index, UIImage *img) {
            
            [weakSelf uploadImg:img index:index];
        }];
    }
    
    return certificationView;
}

- (UIButton *)submitBtn {
    
    if (!submitBtn) {
        
        submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(0, CGRectGetMaxY(self.certificationView.frame), ScreenWidth, 50);
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        submitBtn.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [submitBtn setTitle:@"身份验证中" forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
        
        @weakify(self);
        [[submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            if ([self.submitBtn.titleLabel.text isEqualToString:@"提交申请"]) {
                
                if ([self.title isEqualToString:@"身份认证"]) {
                    
                    [self setIdtAuthFiles];
                }
                else {
                    
                    [self setCertFicateFiles];
                }
            }
         }];
    }
    
    return submitBtn;
}

#pragma mark - request
/// 获取身份认证状态
- (void)getIdtAuthDetail {
    
    @weakify(self);
    self.certificationView.dataSources = @[@"身份证正面", @"身份证反面"];

    [[CertificationViewModel new] getIdtAuthDetailWithComplete:^(id object) {
     
        @strongify(self);
        
        CerImgModel *model = [CerImgModel new];
        [model setValuesForKeysWithDictionary:object];
        model.auth_status = object[@"idt_auth_status"];
        self.certificationView.cerImgModel = model;
        
        [self btnStateChangeWithState:[object[@"idt_auth_status"] intValue]];
    }];
}

/// 获取资格认证状态
- (void)getDoctorFiles {
    
    @weakify(self);
    self.certificationView.dataSources = @[@"相关授权资质"];

    [[CertificationViewModel new] getDoctorFilesWithComplete:^(id object) {
        
        @strongify(self);
        
        CerImgModel *model = [CerImgModel new];
        [model setValuesForKeysWithDictionary:object];
        model.isDoctorFiles = YES;
        model.idt_auth_remark = object[@"auth_remark"];
        self.certificationView.cerImgModel = model;
        
        [self btnStateChangeWithState:[object[@"auth_status"] intValue]];
    }];
}

/// 提交身份认证信息
- (void)setIdtAuthFiles {
    
    __block NSInteger index = 0;
    
    [self showHudAnimated:YES];
    for (int i = 0; i < 2; i++) {
        
        SubmitCertificationModel *model = [SubmitCertificationModel new];
        model.drid = GetUserDefault(UserID);
        model.file_path = self.imgArray[i];
        model.file_type = [NSString stringWithFormat:@"%d", i + 1];
        model.pkid = GetUserDefault(UserID);;
        
        [[CertificationViewModel new] setIdtAuthFilesWithModel:model complete:^(id object) {
            
            index += 1;
            if (index >= 2) {
                
                [self hideHudAnimated];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

/// 提交资格认证信息
- (void)setCertFicateFiles {
    
    for (int i = 0; i < 3; i++) {
        
        if ([self.imgArray[i] length] == 0) {
            return [self.view makeToast:@"请选择图片"];
        }
    }
    
    __block NSInteger index = 0;
    
    [self showHudAnimated:YES];
    for (int i = 0; i < 3; i++) {
        
        SubmitCertificationModel *model = [SubmitCertificationModel new];
        model.drid = GetUserDefault(UserID);
        model.file_path = self.imgArray[i];
        model.pkid = GetUserDefault(UserID);
        
        if (i == 2) {
            model.file_type = @"3";
        }
        else {
            model.file_type = [NSString stringWithFormat:@"%d", i + 7];
        }
        
        WS(weakSelf);
        [[CertificationViewModel new] setCertFicateFilesWithModel:model complete:^(id object) {
            
            index += 1;
            if (index >= 3) {
                
                [weakSelf hideHudAnimated];
                
                if (weakSelf.type == 1) {
                    
                    UIViewController *status = [NSClassFromString(@"RegisterStatusViewController") new];
                    NSArray *list = @[[weakSelf.navigationController.viewControllers firstObject], status];
                    [weakSelf.navigationController setViewControllers:list animated:YES];
//                    for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
//
//                        if ([controller isKindOfClass:[LogInViewController class]]) {
//
//                            [weakSelf.navigationController popToViewController:controller animated:YES];
//
//                        }
//
//                    }
                }
                else {
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                
            }
        }];
    }
}

- (void)uploadImg:(UIImage *)image index:(NSInteger)index {
    
    [self showHudAnimated:YES];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
        
        [self hideHudAnimated];
        [self.imgArray replaceObjectAtIndex:index withObject:object];
    }];
}

@end
