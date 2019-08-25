
//
//  PatientsDetailsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsDetailsViewController.h"
#import "PaySetViewController.h"
#import "PatientsDetailsView.h"
#import "PatientsDetailsViewModel.h"
#import "MessageViewController.h"
#import "TreatmentViewController.h"
#import "RecDrugsViewController.h"
#import "SaveMedicalRcdModel.h"
#import "MessageRequest.h"
#import "PatientsVisitDetailsModel.h"
#import "SDPhotoBrowser.h"

@interface PatientsDetailsViewController () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) PatientsDetailsView *patientsDetailsView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) PatientsVisitDetailsModel *currentRecordModel;

@end

@implementation PatientsDetailsViewController
@synthesize patientsDetailsView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"患者详情";
    self.page = 1;

    @weakify(self);
    [self addNavRightTitle:@"设置" complete:^{
        
        @strongify(self);
        PaySetViewController *viewController = [PaySetViewController new];
        viewController.mid = self.patientsDetailsView.model.pkid;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveRecDrugs:) name:@"SaveRecDrugs" object:nil];
    self.patientsDetailsView.dataSources = nil;
    
    [self getDataSource];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//    [self getDetailsWithPage:1];
//}

- (void)injected {
    
    [patientsDetailsView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getRedPoint];
}

- (void)showRecordPicture:(PatientsVisitDetailsModel *)model index:(NSInteger)index {
    if (model.files) {
        NSArray *files = (NSArray *)(model.files);
        if (files && files.count > 0) {
            self.currentRecordModel = model;
            
            SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
            photoBrowser.delegate = self;
            photoBrowser.currentImageIndex = index < files.count ? index : 0;
            photoBrowser.imageCount = files.count;
            photoBrowser.sourceImagesContainerView = self.view;
            [photoBrowser show];
        }
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return nil;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    if (self.currentRecordModel && self.currentRecordModel.files) {
        NSArray *files = (NSArray *)(self.currentRecordModel.files);
        return [NSURL URLWithString:files[index]];
    }
    return nil;
}

#pragma mark - lazy
- (PatientsDetailsView *)patientsDetailsView {
    
    if (!patientsDetailsView) {
        
        patientsDetailsView = [[PatientsDetailsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
        [self.view addSubview:patientsDetailsView];
        
        WS(weakSelf)
        patientsDetailsView.patientsDetailViewImageBlock = ^(PatientsVisitDetailsModel *model, NSInteger index) {
            [weakSelf showRecordPicture:model index:index];
        };
        
        @weakify(self);
        patientsDetailsView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self.page ++;
            [self getDetailsWithPage:self.page];
        }];
        
        [patientsDetailsView setGoViewControlleBlock:^(UIViewController *viewController) {

            @strongify(self);
            if ([viewController isKindOfClass:[TreatmentViewController class]]) {
                
                TreatmentViewController *vc = (TreatmentViewController *)viewController;
                [vc setRefreshBlock:^{
                    self.page = 1;
                    self.patientsDetailsView.dataSources = @[];
                    [self getDataSource];
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([viewController isKindOfClass:[SelectGroupViewController class]]) {
                
                SelectGroupViewController *vc = (SelectGroupViewController *)viewController;
                [vc setCompleteBlock:^(id object) {
                    
                    self.page = 1;
                    self.patientsDetailsView.dataSources = @[];
                    [self getDataSource];
                    
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else [self.navigationController pushViewController:viewController animated:YES];

        }];
        
        NSArray *titles = @[@"发信息", @"添加诊疗记录", @"推荐用药"];
        NSArray *colors = @[[UIColor colorWithHexString:@"ff9500"],
                            [UIColor colorWithHexString:@"0xfe0000"],
                            kMainColor];
        for (int i = 0; i < 3; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(ScreenWidth / 3 * i, CGRectGetMaxY(self.patientsDetailsView.frame), ScreenWidth / 3, 50);
            button.backgroundColor = colors[i];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(bottomBar:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    return patientsDetailsView;
}

- (void)bottomBar:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"发信息"]) {
        
        MessageViewController *messageView = [[MessageViewController alloc] init];
        messageView.mid = self.patientsDetailsView.model.pkid;
        messageView.patientName = self.patientsDetailsView.model.name;
        messageView.patientAge = self.patientsDetailsView.model.age;
        messageView.patientGender = self.patientsDetailsView.model.gender;
        messageView.msg_flag = @"0";
        messageView.msgId = @"1";
        messageView.title = self.patientsDetailsView.model.name;
        [self.navigationController pushViewController:messageView animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"添加诊疗记录"]) {
        
        TreatmentViewController *vc = [TreatmentViewController new];
        vc.mid = self.midString;
        [vc setRefreshBlock:^{
           
            self.page = 1;
            self.patientsDetailsView.dataSources = @[];
            [self getDataSource];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        
        RecDrugsViewController *recDrugsView = [RecDrugsViewController new];
        recDrugsView.mid = self.patientsDetailsView.model.pkid;
        recDrugsView.name = self.patientsDetailsView.model.name;
        recDrugsView.age = self.patientsDetailsView.model.age;
        recDrugsView.gender = self.patientsDetailsView.model.gender;
        recDrugsView.type = 2;
        InitialRecipeInfoModel *initialRecipeInfoModel = [InitialRecipeInfoModel new];
        initialRecipeInfoModel.mid = self.patientsDetailsView.model.pkid;
        initialRecipeInfoModel.drugs = @[];
        initialRecipeInfoModel.medical_id = @"0";
        recDrugsView.initialRecipeInfoModel = initialRecipeInfoModel;
        [self.navigationController pushViewController:recDrugsView animated:YES];
        
        WS(weakSelf)
        recDrugsView.sendBlock = ^(BOOL success) {
            if (success) {
                [weakSelf getDetailsWithPage:1];
            }
        };
        
        recDrugsView.recDrugsSaveBlock = ^(RecDrugsModel *recDrugsModel) {
            
            SaveMedicalRcdModel *saveModel = [SaveMedicalRcdModel new];
            saveModel.patient_name = recDrugsModel.patient_name;
            saveModel.mid = self.patientsDetailsView.model.pkid;
            saveModel.patient_age = recDrugsModel.age;
            saveModel.patient_gender = recDrugsModel.gender;
            saveModel.code = [NSString stringWithFormat:@"%@",recDrugsModel.code];
            saveModel.check_id = [NSString stringWithFormat:@"%@",recDrugsModel.check_id];
            saveModel.rcd_result = recDrugsModel.check_result;
            saveModel.druguse_items = recDrugsModel.druguse_items;
            saveModel.msg_flag = @"0";
            saveModel.msg_id = @"0";
            saveModel.visit_id = @"0";
            saveModel.allergy_codes = @"";
            saveModel.allergy_names = @"";
            saveModel.analysis_result = @"";
            saveModel.analysis_suggestion = @"";
            [[MessageRequest new] postSaveMedicalRcd:saveModel complete:^(HttpGeneralBackModel *genneralBackModel) {
                
                if (genneralBackModel.retcode == 0) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseRecDrug" object:nil];
                    
                     [self.view makeToast:@"保存成功"];
                    
                }else{
                    
                     [self.view makeToast:genneralBackModel.retmsg];
                    
                }
                
            }];
            
        };
        
    }
}


#pragma mark - request
- (void)getDataSource {
    
    WS(weakSelf)
    [[PatientsDetailsViewModel new] getDetailWithMidString:self.midString complete:^(id object) {
        
        self.patientsDetailsView.model = object;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf getDetailsWithPage:1];
            
        });
        
    }];
}

- (void)getRedPoint {
    WS(weakSelf)
    [[PatientsDetailsViewModel new] chkUnread:self.midString complete:^(NSInteger unread) {
        
        weakSelf.patientsDetailsView.unread = unread;
        
    }];
}

- (void)getDetailsWithPage:(NSInteger)page {
    
    NSString *pageString = [NSString stringWithFormat:@"%ld", (long)page];
    [[PatientsDetailsViewModel new] getMedicalRcdWithMidString:self.midString page:pageString  complete:^(id object) {
        
        [self.patientsDetailsView.mj_footer endRefreshing];
        
        NSMutableArray *objectArr = [NSMutableArray arrayWithArray:object];
        NSMutableArray *dataArr = [NSMutableArray new];
        if (page > 1) {
            [dataArr addObjectsFromArray:self.patientsDetailsView.dataSources];
        }
        for (int i = 0; i < dataArr.count; i++) {
            
            NSDictionary *dict = dataArr[i];
            if (objectArr.count > 0) {
                
                for (NSDictionary *tempDict in [objectArr mutableCopy]) {
                    
                    if ([dict[@"year_month"] isEqualToString:tempDict[@"year_month"]]) {
                        
                        NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                        NSMutableArray *months = [NSMutableArray arrayWithArray:dataDict[@"Months"]];
                        [months addObjectsFromArray:tempDict[@"Months"]];
                        [dataDict setObject:months forKey:@"Months"];
                        [dataArr replaceObjectAtIndex:i withObject:dataDict];
                        [objectArr removeObject:tempDict];
                        break ;
                        
                    }
                }
            }
            else {
                
                break;
            }
        }
        
        if (objectArr.count > 0) {
            [dataArr addObjectsFromArray:objectArr];
        }
        
        self.patientsDetailsView.dataSources = dataArr;
    }];
}

-(void)saveRecDrugs:(NSNotification *)sender{
    
    RecDrugsModel *recDrugsModel = sender.object;
    
    SaveMedicalRcdModel *saveModel = [SaveMedicalRcdModel new];
    saveModel.patient_name = recDrugsModel.patient_name;
    saveModel.mid = self.patientsDetailsView.model.pkid;
    saveModel.patient_age = recDrugsModel.age;
    saveModel.patient_gender = recDrugsModel.gender;
    saveModel.code = [NSString stringWithFormat:@"%@",recDrugsModel.code];
    saveModel.check_id = [NSString stringWithFormat:@"%@",recDrugsModel.check_id];
    saveModel.rcd_result = recDrugsModel.check_result;
    saveModel.druguse_items = recDrugsModel.druguse_items;
    saveModel.msg_flag = @"0";
    saveModel.msg_id = @"0";
    saveModel.msg_id = @"0";
    saveModel.visit_id = @"0";
    saveModel.allergy_codes = @"";
    saveModel.allergy_names = @"";
    saveModel.analysis_result = @"";
    saveModel.analysis_suggestion = @"";
    [[MessageRequest new] postSaveMedicalRcd:saveModel complete:^(HttpGeneralBackModel *genneralBackModel) {
        
    }];
    
}

@end
