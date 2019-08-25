//
//  FillInDataViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "FillInDataViewController.h"
#import "FillInDataView.h"
#import "FillInDataModel.h"
#import "FillInDataRequestModel.h"
#import "LogInRequest.h"
#import "LogInViewController.h"
#import "DrugModel.h"
#import "CertificationViewController.h"

@interface FillInDataViewController ()

@property (nonatomic ,strong) FillInDataView *fillInView;

@property (nonatomic ,retain) NSMutableArray *fillInDataArray;

@property (nonatomic ,retain) LogInRequest *logInRequest;

@property (nonatomic ,retain) DrugModel *drugModel;

@end

@implementation FillInDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写信息";
    
    self.fillInDataArray = [NSMutableArray array];
    
    [self initUI];
    
    [self block];
    
}

-(void)initUI{
    
    self.fillInView = [FillInDataView new];
    [self.view addSubview:self.fillInView];
    
    self.fillInView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    UIButton *sendButton = [UIButton new];
    sendButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [sendButton setTitle:@"下一步" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundColor: kMainColor];
    [sendButton addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    sendButton.sd_layout
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(50);
    
}

-(void)block{
    WS(weakSelf)
    
    self.fillInView.fillInDataBlock = ^(NSMutableArray *array) {
      
        weakSelf.fillInDataArray = array;
        
    };
    
    self.fillInView.goViewControllerBlock = ^(UIViewController *viewController) {
        
        [weakSelf goViewControllerWith:(BaseViewController *)viewController];
        
    };
    
}

#pragma mark - push
- (void)goViewControllerWith:(BaseViewController *)viewController {
    
    __weak typeof(viewController)weakVC = viewController;
    [viewController setCompleteBlock:^(id object) {
        
        if ([object isKindOfClass:[DrugModel class]]) {
            
            NSLog(@"是DrugModel类型");
            
            self.drugModel = object;
            
            self.fillInView.selDepartmentString = self.drugModel.id;
            
            object = self.drugModel.name;
            
        }
        else{
            NSLog(@"String类型");
            
        }
        
        for (int f = 0; f < self.fillInView.dataSountArray.count; f++) {
            
            NSArray *array = self.fillInView.dataSountArray[f];

            for (int i = 0; i < array.count; i++) {
                
                FillInDataModel *model = array[i];
                
                if ([model.titleName isEqualToString:weakVC.title]) {
                    
                    if ([object isKindOfClass:[NSDictionary class]]) {
                        model.valueId = [NSString stringWithFormat:@"%@", [object valueForKey:@"hid"]];
                        model.messageString = [object valueForKey:@"name"];
                    }
                    else {
                        model.messageString = object;
                    }
                    
                    NSMutableArray *sectionArray = self.fillInView.dataSountArray[f];
                    [sectionArray replaceObjectAtIndex:i withObject:model];
                    
                    [self.fillInView.dataSountArray replaceObjectAtIndex:f withObject:sectionArray];
                }
            }
        }
        
        [self.fillInView.myTable reloadData];
    }];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)sendButton:(UIButton *)sender{
    
//    if (self.fillInDataArray.count < 3) {
//        return;
//    }
    
    FillInDataRequestModel *dataModel = [FillInDataRequestModel new];
    
    for (int i = 0; i < self.fillInView.dataSountArray.count; i++) {
        
        NSArray *array = self.fillInView.dataSountArray[i];
        
        for (int f = 0; f < array.count; f++) {
            
            FillInDataModel *model = array[f];
            
            if ([model.titleName isEqualToString:@"姓名"]) {
                
                if (model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请填写姓名"];
                    
                    return;
                    
                }else{
                    
                    dataModel.Name = model.messageString;
                    
                }
                
            }
            
            if ([model.titleName isEqualToString:@"性别"]) {
                
                if (model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请选择性别"];
                    
                    return;
                    
                }else{
                    
                    if ([model.messageString isEqualToString:@"男"]) {
                        
                        dataModel.Gender = @"1";
                        
                    }else{
                        
                        dataModel.Gender = @"0";
                        
                    }
                    
                }
                
            }
            
            if ([model.titleName isEqualToString:@"医院"]) {
                
                if (!model.valueId || model.valueId.length < 1 || model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请选择医院"];
                    
                    return;
                    
                }else{
                    dataModel.HispitalId = model.valueId;
                    dataModel.HispitalName = model.messageString;
                }
                
            }
            
            if ([model.titleName isEqualToString:@"科室"]) {
                
                if (model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请选择科室"];
                    
                    return;
                    
                }else{

//                    dataModel.HispitalId = self.drugModel.id;
                    
                    dataModel.CustName = model.messageString;
                    
                }
                
            }
            
            if ([model.titleName isEqualToString:@"职称"]) {
                
                if (model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请选择职称"];
                    
                    return;
                    
                }else{
                    dataModel.Title = model.messageString;
                }
                
            }
            
            if ([model.titleName isEqualToString:@"擅长"]) {
                
                if (model.messageString.length > 1) {
                    dataModel.Remark = model.messageString;
                }
                
            }
            
            if ([model.titleName isEqualToString:@"简介"]) {
                
                if (model.messageString.length > 1) {
                    dataModel.Introduction = model.messageString;
                }
                
            }
            
            
        }

    }
    
    dataModel.pkid = GetUserDefault(UserID);
    
    self.logInRequest = [LogInRequest new];
    WS(weakSelf);
    [self.logInRequest postSaveBasicInfo:dataModel complete:^(HttpGeneralBackModel *model) {
       
        if (model && model.retcode == 0) {
            
            CertificationViewController *certificationView = [[CertificationViewController alloc] init];
            certificationView.title = @"资格认证";
            certificationView.type = 1;
            [weakSelf.navigationController pushViewController:certificationView animated:YES];
            
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//
//                if ([controller isKindOfClass:[LogInViewController class]]) {
//
//                    [self.navigationController popToViewController:controller animated:YES];
//
//                }
//
//            }
            
        }else{
            
            [self.view makeToast:model.retmsg];
            
        }
        
    }];
    
}

@end
