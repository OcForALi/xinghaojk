//
//  MessageViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MessageViewController.h"
#import "PaySetViewController.h"
#import "MessageRequest.h"
#import "ChatView.h"
#import "MessageModel.h"
#import "ChatKeyboardView.h"
#import "TreatmentViewController.h"
#import "CertificationViewModel.h"
#import "VisitDetailsViewModel.h"
#import "VisitDetailsModel.h"
#import "VisitDetailsViewController.h"
#import "FastReplyViewController.h"
#import "ChatStateModel.h"
#import "PrescriptionDetailsViewController.h"
#import "SaveMedicalRcdModel.h"
#import "NSString+ToJSON.h"
#import "DrugDosageModel.h"
#import "PatientsDetailsViewController.h"
#import "RecDrugsViewController.h"

@interface MessageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic ,strong) ChatView *chatView;

@property (nonatomic ,strong) ChatKeyboardView *chatKeyboardView;

@property (nonatomic ,copy) NSString *dateString;

@property (nonatomic ,strong) UIView *visitsView;

@property (nonatomic ,assign) BOOL isKeyboard;

@property (nonatomic ,copy) NSString *visitTimeString;

@property (nonatomic ,retain) ChatStateModel *chatStateModel;

@property (nonatomic ,strong) UIView *againView;

@property (nonatomic ,strong) UIView *closedView;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,assign) NSInteger secondsCountDown;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSTimer *activeTimer;

@property (nonatomic ,strong) RecDrugsViewController *recDrugsView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self block];
    
    [self requst:1];
    
    [self refresh];
    
    self.isKeyboard = NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveRecDrugs:) name:@"SaveRecDrugs" object:nil];
    
    @weakify(self);
    [self addNavRightTitle:@"设置" complete:^{
        
        @strongify(self);
        PaySetViewController *viewController = [PaySetViewController new];
        viewController.mid = [NSString stringWithFormat:@"%@",self.mid];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    
    if (self.mid) {
        NSString *mmid = [NSString stringWithFormat:@"%@", self.mid];
        SetUserDefault(kChattingMid, mmid);
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
    RemoveUserDefault(kChattingMid);
}

-(void)action{

    [self requst:1];
}

-(void)initUI{
    
    self.view.frame = CGRectMake(0,0, ScreenWidth, ScreenHeight - kTabbarSafeBottomMargin - self.navBarHeight);
    
    self.chatKeyboardView = [ChatKeyboardView new];
    
    if ([self.msg_flag integerValue] == 1) {
        self.chatKeyboardView.isPicture = 1;
    }else{
        self.chatKeyboardView.isPicture = 0;
    }
    
    [self.view addSubview:self.chatKeyboardView];
    
    self.chatKeyboardView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(120);
    
    self.chatView = [ChatView new];
    self.chatView.mid = self.mid;
    [self.view addSubview:self.chatView];
    
    self.chatView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.chatKeyboardView, 0);
    
}

-(void)block{
    WS(weakSelf);
    
    self.chatView.patientsDetailPushBlock = ^(NSString *idString) {
        
        PatientsDetailsViewController *vc = [[PatientsDetailsViewController alloc] init];
        vc.midString = idString;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    self.chatKeyboardView.keyboardTypeBlock = ^(NSInteger type) {
        
        if (type == 0) {

            weakSelf.chatKeyboardView.sd_resetLayout
            .leftSpaceToView(weakSelf.view, 0)
            .rightSpaceToView(weakSelf.view, 0)
            .bottomSpaceToView(weakSelf.view, 0)
            .heightIs(120);
        }
        
        if (type == 1) {

            weakSelf.chatKeyboardView.sd_resetLayout
            .leftSpaceToView(weakSelf.view, 0)
            .rightSpaceToView(weakSelf.view, 0)
            .bottomSpaceToView(weakSelf.view, 0)
            .heightIs(50);
            
        }
        
        if (type == 2) {
            
            if (weakSelf.isKeyboard == NO) {
                
                weakSelf.chatKeyboardView.sd_resetLayout
                .leftSpaceToView(weakSelf.view, 0)
                .rightSpaceToView(weakSelf.view, 0)
                .bottomSpaceToView(weakSelf.view, 0)
                .heightIs(210);
                
                weakSelf.isKeyboard = YES;
                
            }else{
                
                weakSelf.chatKeyboardView.sd_resetLayout
                .leftSpaceToView(weakSelf.view, 0)
                .rightSpaceToView(weakSelf.view, 0)
                .bottomSpaceToView(weakSelf.view, 0)
                .heightIs(120);
                
                weakSelf.isKeyboard = NO;
                
            }

        }
        
    };
    
    self.chatKeyboardView.pushBlock = ^(NSString *pushString) {
        
        if ([pushString isEqualToString:@"诊疗记录"]) {
            
            TreatmentViewController *vc = [TreatmentViewController new];
            vc.pkid = weakSelf.mid;
            vc.mid = weakSelf.mid;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }
        if ([pushString isEqualToString:@"推荐用药"]) {
            
            RecDrugsViewController *recDrugsView = [RecDrugsViewController new];
            recDrugsView.mid = weakSelf.mid;
            recDrugsView.name = weakSelf.patientName;
            recDrugsView.age = weakSelf.patientAge;
            recDrugsView.gender = weakSelf.patientGender;
            recDrugsView.msgFlag = weakSelf.msg_flag;
            recDrugsView.msgId = @"1";
            recDrugsView.type = 2;
            InitialRecipeInfoModel *initialRecipeInfoModel = [InitialRecipeInfoModel new];
            initialRecipeInfoModel.mid = weakSelf.mid;
            initialRecipeInfoModel.drugs = @[];
            initialRecipeInfoModel.medical_id = @"0";
            recDrugsView.initialRecipeInfoModel = initialRecipeInfoModel;
            [weakSelf.navigationController pushViewController:recDrugsView animated:YES];
            
            recDrugsView.recDrugsSaveBlock = ^(RecDrugsModel *recDrugsModel) {

                SaveMedicalRcdModel *saveModel = [SaveMedicalRcdModel new];
                saveModel.patient_name = recDrugsModel.patient_name;
                saveModel.mid = weakSelf.mid;
                saveModel.patient_age = recDrugsModel.age;
                saveModel.patient_gender = recDrugsModel.gender;
                saveModel.code = [NSString stringWithFormat:@"%@",recDrugsModel.code];
                saveModel.check_id = [NSString stringWithFormat:@"%@",recDrugsModel.check_id];
                saveModel.rcd_result = recDrugsModel.check_result;
                saveModel.druguse_items = recDrugsModel.druguse_items;
                if (weakSelf.msg_flag != nil) {
                    saveModel.msg_flag = weakSelf.msg_flag;
                }else{
                    saveModel.msg_flag = @"0";
                }
                
                if (weakSelf.msgId != nil) {
                    saveModel.msg_id = weakSelf.msgId;
                }else{
                    saveModel.msg_id = @"0";
                }
                saveModel.visit_id = @"0";
                saveModel.allergy_codes = @"";
                saveModel.allergy_names = @"";
                saveModel.analysis_result = @"";
                saveModel.analysis_suggestion = @"";
                [[MessageRequest new] postSaveMedicalRcd:saveModel complete:^(HttpGeneralBackModel *genneralBackModel) {
                    
                    if (genneralBackModel.retcode == 0) {

                        [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseRecDrug" object:nil];
                        [weakSelf.view makeToast:@"保存成功"];
                    }else{
                       
                        [weakSelf.view makeToast:genneralBackModel.retmsg];
                        
                    }
                    
                }];
                
            };
            
        }
        if ([pushString isEqualToString:@"图片"]) {
            
            [weakSelf image];
            
        }
        if ([pushString isEqualToString:@"出诊时间"]) {
            
            NSMutableArray *array = [NSMutableArray new];
            
            [[VisitDetailsViewModel new] getWeekScheduleComplete:^(id object) {
                
                for (VisitDetailsModel *model in object) {
                    
                    if ([model.amType integerValue] != 0 || [model.pmType integerValue] != 0) {
                        
                        [array addObject:model];
                        
                    }
                    
                }
                
                [weakSelf visits:array];
                
            }];

        }
        if ([pushString isEqualToString:@"快捷回复"]) {
            
            FastReplyViewController *fastReplyView = [[FastReplyViewController alloc] init];
            [weakSelf.navigationController pushViewController:fastReplyView animated:YES];
            
            fastReplyView.inputTextBlock = ^(NSString *inputTextString) {
              
                weakSelf.chatKeyboardView.inputTextField.text = inputTextString;
                
                weakSelf.chatKeyboardView.sendLabel.hidden = NO;
                
            };
            
        }
 
    };
    
    self.chatKeyboardView.uploadBlock = ^(NSString *uploadFilePath) {
        [weakSelf showHudAnimated:YES];
        [[MessageRequest new] postUploadAudio:uploadFilePath complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            if (genneralBackModel.retcode == 0 && genneralBackModel != nil) {
                
                [[MessageRequest new] postSendVoiceMsgMid:weakSelf.mid content:genneralBackModel.data[0][@"Url"] msg_flag:@"0" complete:^(HttpGeneralBackModel *genneralBackModel) {
                    
                    if (genneralBackModel.retcode == 0) {
                        [weakSelf requst:1];
                    }
                    [weakSelf hideHudAnimated];
                }];
                
            }
            else {
                [weakSelf hideHudAnimated];
                [weakSelf.view makeToast:@"语音发送失败"];
            }
        }];
        
    };
    
    self.chatKeyboardView.inputTextBlock = ^(NSString *inputTextString) {
        if (!weakSelf.msg_source) {
            weakSelf.msg_source = @"0";
        }
        [[MessageRequest new] postsendTxtMsggMid:weakSelf.mid content:inputTextString msg_flag:weakSelf.msg_source complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            if (genneralBackModel.retcode == 0) {
                [weakSelf requst:1];
                weakSelf.chatKeyboardView.inputTextField.text = nil;
            }
            
        }];
        
    };
    
    self.chatView.drugPushBlock = ^(InitialRecipeInfoModel *initialRecipeInfoModel) {
        
        weakSelf.recDrugsView = [[RecDrugsViewController alloc] init];
        weakSelf.recDrugsView.mid = weakSelf.mid;
        weakSelf.recDrugsView.mid = weakSelf.mid;
        weakSelf.recDrugsView.name = weakSelf.patientName;
        weakSelf.recDrugsView.age = weakSelf.patientAge;
        weakSelf.recDrugsView.gender = weakSelf.patientGender;
        weakSelf.recDrugsView.msgFlag = weakSelf.msg_flag;
        weakSelf.recDrugsView.msgId = @"1";
        weakSelf.recDrugsView.type = 1;
        weakSelf.recDrugsView.msgFlag = weakSelf.msg_flag;
        weakSelf.recDrugsView.msgId = @"1";
        weakSelf.recDrugsView.initialRecipeInfoModel = initialRecipeInfoModel;
        [weakSelf.navigationController pushViewController:weakSelf.recDrugsView animated:YES];
        
        weakSelf.recDrugsView.recDrugsSaveBlock = ^(RecDrugsModel *recDrugsModel) {
            
            SaveMedicalRcdModel *saveModel = [SaveMedicalRcdModel new];
            saveModel.patient_name = recDrugsModel.patient_name;
            saveModel.mid = weakSelf.mid;
            saveModel.patient_age = recDrugsModel.age;
            saveModel.patient_gender = recDrugsModel.gender;
            saveModel.code = [NSString stringWithFormat:@"%@",recDrugsModel.code];
            saveModel.check_id = [NSString stringWithFormat:@"%@",recDrugsModel.check_id];
            saveModel.rcd_result = recDrugsModel.check_result;
            saveModel.druguse_items = recDrugsModel.druguse_items;
            if (weakSelf.msg_flag != nil) {
                saveModel.msg_flag = weakSelf.msg_flag;
            }else{
                saveModel.msg_flag = @"0";
            }
            
            if (weakSelf.msgId != nil) {
                saveModel.msg_id = weakSelf.msgId;
            }else{
                saveModel.msg_id = @"0";
            }
            saveModel.visit_id = @"0";
            saveModel.allergy_codes = @"";
            saveModel.allergy_names = @"";
            saveModel.analysis_result = @"";
            saveModel.analysis_suggestion = @"";
            [[MessageRequest new] postSaveMedicalRcd:saveModel complete:^(HttpGeneralBackModel *genneralBackModel) {
                
                if (genneralBackModel.retcode == 0) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseRecDrug" object:nil];
                    [weakSelf.view makeToast:@"保存成功"];
                }else{
                    
                    [weakSelf.view makeToast:genneralBackModel.retmsg];
                    
                }
                
            }];
            
        };
        
    };
    
    self.chatView.detailsPushBlock = ^(ChatModel *model) {

        RecDrugsViewController *recDrugsView = [RecDrugsViewController new];
        recDrugsView.mid = weakSelf.mid;
        recDrugsView.name = weakSelf.patientName;
        recDrugsView.age = weakSelf.patientAge;
        recDrugsView.gender = weakSelf.patientGender;
        recDrugsView.type = 2;
        recDrugsView.msgFlag = weakSelf.msg_flag;
        recDrugsView.msgId = model.msg_id;
        InitialRecipeInfoModel *initialRecipeInfoModel = [InitialRecipeInfoModel new];
        initialRecipeInfoModel.mid = weakSelf.mid;
        initialRecipeInfoModel.medical_id = model.medical_id;
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in model.druguse) {
            [array addObject:@{@"drug_code":[NSString stringWithFormat:@"%@",dict[@"drug_code"]],@"qty":[NSNumber numberWithInteger:[dict[@"qty"] integerValue]]}];
        }
        initialRecipeInfoModel.drugs = array;
        recDrugsView.initialRecipeInfoModel = initialRecipeInfoModel;
        [weakSelf.navigationController pushViewController:recDrugsView animated:YES];
        
    };
    
    self.chatView.drugDetailsBlock = ^(ChatModel *model) {
        PrescriptionDetailsViewController *presriptionDetailsView = [[PrescriptionDetailsViewController alloc] init];
        presriptionDetailsView.idString = model.medical_id;
        [weakSelf.navigationController pushViewController:presriptionDetailsView animated:YES];
    };
    
}

-(void)saveRecDrugs:(NSNotification *)sender{
    
    
    
}

-(void)image{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotos = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            //拍照
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
        
    }];
    
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"从相册选取一张照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            //相册
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
        
    }];
    
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [alert addAction:takePhotos];
    
    [alert addAction:ok];//添加确认按钮
    
    [alert addAction:cancel];//添加取消按钮
    
    //以modal的形式
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        WS(weakSelf);
        [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
            
            [[MessageRequest new] postSendImgMsgMid:weakSelf.mid file_path:object msg_flag:@"0" complete:^(HttpGeneralBackModel *genneralBackModel) {
                [weakSelf requst:1];
            }];
            
        }];
        
    });
}

-(void)requst:(NSInteger)type{
    WS(weakSelf);
    
    if ([self.msg_flag integerValue] == 0) {
        
        [[MessageRequest new] getCurrentMsgIsClosedMid:self.mid  complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            weakSelf.chatStateModel = [ChatStateModel new];
            [weakSelf.chatStateModel setValuesForKeysWithDictionary:genneralBackModel.data];
            
            if ([weakSelf.chatStateModel.is_closed integerValue] == 0) {
                
                if (weakSelf.chatStateModel.endtime != nil) {
                    [weakSelf initClosedView];
                }
                
            }
            
            if ([weakSelf.chatStateModel.is_start integerValue] == 0) {
                [weakSelf initAgainView];
            }
            
        }];
        
    }
    
    [[MessageRequest new] getDetailMid:self.mid msg_source:self.msg_flag msg_id:self.msgId complete:^(HttpGeneralBackModel *genneralBackModel)  {

        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in [genneralBackModel.data objectForKey:@"minutes"]) {
            
            MessageModel *model = [MessageModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        if (type == 0) {
            
            self.dateString = [genneralBackModel.data objectForKey:@"date"];
            
            [weakSelf.chatView addData:array];

        }else{
            
            MessageModel *model = array.lastObject;
            
            MessageModel *model1 = weakSelf.chatView.dataSource.lastObject;
            
            if ([model.minute isEqualToString:model1.minute]) {
                
                if (model1.items.count < model.items.count) {
                    
                    self.dateString = [genneralBackModel.data objectForKey:@"date"];
                    
                    [weakSelf.chatView addUnderData:array];
                    
                }
                
            }else{
                
                self.dateString = [genneralBackModel.data objectForKey:@"date"];
                
                [weakSelf.chatView addUnderData:array];
                
            }
            
        }
        
        [weakSelf.chatView.NoMessageView removeFromSuperview];
        
        [weakSelf.chatView.myTable.mj_header endRefreshing];
        
    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.chatView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
        [nextformatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [nextformatter dateFromString:self.dateString];
        
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
        
        self.dateString = [nextformatter stringFromDate:lastDay];
        
        NSLog(@"时间记录 %@",self.dateString);
        
        [[MessageRequest new] getMoreMsgMid:weakSelf.mid Date:self.dateString complete:^(HttpGeneralBackModel *genneralBackModel) {

            self.dateString = [genneralBackModel.data objectForKey:@"date"];
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in [genneralBackModel.data objectForKey:@"minutes"]) {
                
                MessageModel *model = [MessageModel new];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
                
            }
            
            [weakSelf.chatView addData:array];
            
            [weakSelf.chatView.myTable.mj_header endRefreshing];
            
        }];
        
    }];
    
}

- (NSString *)parseVisitStatus:(NSInteger)status {
    NSString *amType = @"";
    if (status == 1) {
        amType = @"普通";
    }
    if (status == 2) {
        amType = @"专家";
    }
    if (status == 3) {
        amType = @"特诊";
    }
    return amType;
}

- (NSString *)parseVisitContent:(VisitDetailsModel *)model {
    NSString *contentString = @"";
    NSInteger am = [model.amType integerValue];
    NSString *amType = [self parseVisitStatus:am];
    NSInteger pm = [model.pmType integerValue];
    NSString *pmType = [self parseVisitStatus:pm];
    
    if (am != 0 && pm != 0) {
        contentString = [NSString stringWithFormat:@"\n%@ 上午（%@）/下午（%@）",model.week,amType,pmType];
    }
    else if (am != 0){
        contentString = [NSString stringWithFormat:@"\n%@ 上午（%@）",model.week,amType];
    }
    else if (pm != 0){
        contentString = [NSString stringWithFormat:@"\n%@ 下午（%@）",model.week,pmType];
    }
    
    return contentString;
}

- (BOOL)checkHospital:(VisitDetailsModel *)left right:(VisitDetailsModel *)right {
    BOOL amLeft = left.amHospital && left.amHospital.length > 0;
    BOOL pmLeft = left.pmHospital && left.pmHospital.length > 0;
    BOOL amRight = right.amHospital && right.amHospital.length > 0;
    BOOL pmRight = right.pmHospital && right.pmHospital.length > 0;
    if (amLeft && amRight && [left.amHospital isEqualToString:right.amHospital]) {
        return YES;
    }
    else if (pmLeft && pmRight && [left.pmHospital isEqualToString:right.pmHospital]) {
        return YES;
    }
    else if (amLeft && pmRight && [left.amHospital isEqualToString:right.pmHospital]) {
        return YES;
    }
    else if (pmLeft && amRight && [left.pmHospital isEqualToString:right.amHospital]) {
        return YES;
    }
    return NO;
}

-(void)visits:(NSArray *)array{
    if (!array || array.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂无出诊时间" message:nil preferredStyle:UIAlertControllerStyleAlert];
        WS(weakSelf)
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            VisitDetailsViewController *visitDetailsView = [[VisitDetailsViewController alloc] init];
            [weakSelf.navigationController pushViewController:visitDetailsView animated:YES];
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    self.visitsView = [UIView new];
    [[UIApplication sharedApplication].keyWindow addSubview:self.visitsView];
    self.visitsView.sd_layout.xIs(0).yIs(0).widthIs(ScreenWidth).heightIs(ScreenHeight);
    
    NSString *contentString;
    NSMutableArray *res = [[NSMutableArray alloc] init];
    NSMutableArray *source = [[NSMutableArray alloc] initWithArray:array];
    for (NSInteger i = 0 ; i < source.count; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] init];
        VisitDetailsModel *first = source[i];
        [row addObject:first];
        for (NSInteger j = i+1; j < source.count; j++) {
            VisitDetailsModel *second = source[j];
            if ([self checkHospital:first right:second]) {
                [row addObject:second];
                [source removeObjectAtIndex:j];
                j--;
            }
        }
        [res addObject:row];
    }
    for (NSArray *row in res) {
        VisitDetailsModel *first = [row firstObject];
        NSString *hospital = first.amHospital;
        if (!hospital || hospital.length == 0) {
            hospital = first.pmHospital;
        }
        if (!contentString) {
            contentString = @"";
        }
        else {
            contentString = [contentString stringByAppendingFormat:@"\n"];
        }
        contentString = [contentString stringByAppendingFormat:@"%@:", hospital];
        for (VisitDetailsModel *item in row) {
            NSString *str = [self parseVisitContent:item];
            if (str) {
                contentString = [contentString stringByAppendingString:str];
            }
        }
    }
//    for (NSInteger index = 0 ; index < res.count; index++) {
//        VisitDetailsModel *model = res[index];
//        NSString *amType;
//        NSString *pmType;
//        if ([model.amType integerValue] == 1) {
//            amType = @"普通";
//        }
//        if ([model.amType integerValue] == 2) {
//            amType = @"专家";
//        }
//        if ([model.amType integerValue] == 3) {
//            amType = @"特诊";
//        }
//        if ([model.pmType integerValue] == 1) {
//            pmType = @"普通";
//        }
//        if ([model.pmType integerValue] == 2) {
//            pmType = @"专家";
//        }
//        if ([model.pmType integerValue] == 3) {
//            pmType = @"特诊";
//        }
//
//        if ([model.amType integerValue] != 0 && [model.pmType integerValue] != 0) {
//
//            if (contentString == nil) {
//                contentString = [NSString stringWithFormat:@"\n%@ 上午（%@）/下午（%@）",model.week,amType,pmType];
//            }else{
//                contentString = [contentString stringByAppendingString:[NSString stringWithFormat:@"\n%@ 上午（%@）/下午（%@）",model.week,amType,pmType]];
//            }
//
//        }else if ([model.amType integerValue] != 0){
//            if (contentString == nil) {
//                contentString = [NSString stringWithFormat:@"\n%@ 上午（%@）",model.week,amType];
//            }else{
//                contentString = [contentString stringByAppendingString:[NSString stringWithFormat:@"\n%@ 上午（%@）",model.week,amType]];
//            }
//
//        }else if ([model.pmType integerValue] != 0){
//
//            if (contentString == nil) {
//                contentString = [NSString stringWithFormat:@"\n%@ 下午（%@）",model.week,pmType];
//            }else{
//                contentString = [contentString stringByAppendingString:[NSString stringWithFormat:@"\n%@ 下午（%@）",model.week,pmType]];
//            }
//
//        }
//
//    }
    
    self.visitTimeString = contentString;
    
    UIView *bgView = [UIView new];
    bgView .backgroundColor = RGBA(51, 51, 51, 0.7);
    bgView .userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [bgView  addGestureRecognizer:backTap];
    [self.visitsView addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.visitsView, 0)
    .rightSpaceToView(self.visitsView, 0)
    .topSpaceToView(self.visitsView, 0)
    .bottomSpaceToView(self.visitsView, 0);
    
    UIView *whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor whiteColor];
    whiteBG.userInteractionEnabled = YES;
    [bgView addSubview:whiteBG];
    
    whiteBG.sd_layout
    .centerYEqualToView(bgView)
    .leftSpaceToView(bgView, 15)
    .rightSpaceToView(bgView, 15)
    .heightIs(250);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"你好，我在医院的门诊时间是：";
    titleLabel.textColor = kMainColor;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [whiteBG addSubview:titleLabel];
    
    titleLabel.sd_layout
    .leftSpaceToView(whiteBG, 10)
    .topSpaceToView(whiteBG, 15)
    .heightIs(14);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    
//    UILabel *subTitleLabel = [UILabel new];
//    subTitleLabel.text = @"本院区：";
//    subTitleLabel.font = [UIFont systemFontOfSize:16];
//    [whiteBG addSubview:subTitleLabel];
//    subTitleLabel.sd_layout
//    .leftSpaceToView(whiteBG, 15)
//    .topSpaceToView(titleLabel, 15)
//    .heightIs(16);
//    [subTitleLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.text = contentString;
    [whiteBG addSubview:contentLabel];
    
    contentLabel.sd_layout
    .leftSpaceToView(whiteBG, 15)
    .topSpaceToView(titleLabel, 20)
    .autoHeightRatio(0);
    [contentLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(237, 237, 237);
    [whiteBG addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(whiteBG, 0)
    .rightSpaceToView(whiteBG, 0)
    .bottomSpaceToView(whiteBG, 40)
    .heightIs(1);
    
    NSArray *titleArray = @[@"发送",@"修改时间"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UILabel *label = [UILabel new];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0) {
            label.textColor = kMainColor;
        }else{
            label.textColor = [UIColor blackColor];
        }
        label.tag = i + 100;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendVisits:)];
        [label addGestureRecognizer:labelTap];
        [whiteBG addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(whiteBG, 0 + i * ((ScreenWidth-40/2)/2))
        .bottomSpaceToView(whiteBG, 0)
        .heightIs(40)
        .widthIs((ScreenWidth-40/2)/2);
        
    }
    
    UIView *line1View = [UIView new];
    line1View.backgroundColor = RGB(237, 237, 237);
    [whiteBG addSubview:line1View];
    
    line1View.sd_layout
    .centerXEqualToView(whiteBG)
    .bottomSpaceToView(whiteBG, 0)
    .widthIs(1)
    .heightIs(40);
    
}

-(void)sendVisits:(UITapGestureRecognizer *)sender{
    
    [self.visitsView removeFromSuperview];
    
    self.visitTimeString = [[NSString stringWithFormat:@"你好，我在医院的门诊时间是：\n"] stringByAppendingString:self.visitTimeString];
    
    if (sender.view.tag - 100 == 0) {
        
        WS(weakSelf)
        [[MessageRequest new] sendDocSchedule:self.mid content:self.visitTimeString msgSource:self.msg_source complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            if (genneralBackModel.retcode == 0) {
                [weakSelf requst:1];
            }
            
        }];
        
//        [[MessageRequest new] postsendTxtMsggMid:self.mid content:self.visitTimeString msg_flag:self.msg_flag complete:^(HttpGeneralBackModel *genneralBackModel) {
//
//            if (genneralBackModel.retcode == 0) {
//                [self requst:1];
//            }
//
//        }];
//
//        [[MessageRequest new] postsendTxtMsggMid:self.mid content:self.visitTimeString msg_flag:@"2" complete:^(HttpGeneralBackModel *genneralBackModel) {
//
//        }];
        
    }else{
        VisitDetailsViewController *visitDetailsView = [[VisitDetailsViewController alloc] init];
        [self.navigationController pushViewController:visitDetailsView animated:YES];
    }
    
}

-(void)back{
    [self.visitsView removeFromSuperview];
}

-(void)initAgainView{
    
    if (!self.againView) {
        
        self.againView = [UIView new];
        self.againView.backgroundColor = [UIColor whiteColor];
        self.againView.userInteractionEnabled = YES;
        UITapGestureRecognizer *againTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(again:)];
        [self.againView addGestureRecognizer:againTap];
        [self.view addSubview:self.againView];
        
        self.againView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0)
        .heightIs(50);
        
        UILabel *label = [UILabel new];
        label.text = @"重新发起会话";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:20];
        [self.againView addSubview:label];
        
        label.sd_layout
        .centerXEqualToView(self.againView)
        .centerYEqualToView(self.againView)
        .heightIs(20);
        [label setSingleLineAutoResizeWithMaxWidth:300];
    }
    else {
        [self.view addSubview:self.againView];
    }
    self.chatKeyboardView.hidden = YES;
}

-(void)initClosedView{
    
    if (!self.closedView) {
        
        self.closedView = [UIView new];
        self.closedView.backgroundColor = RGBA(137, 137, 137, 0.7);
        self.closedView.layer.cornerRadius = 15;
        self.closedView.layer.masksToBounds = YES;
        self.closedView.userInteractionEnabled = YES;
        UITapGestureRecognizer *closedTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closed:)];
        [self.closedView addGestureRecognizer:closedTap];
        [self.view addSubview:self.closedView];
        
        self.closedView.sd_layout
        .rightSpaceToView(self.view, -10)
        .topSpaceToView(self.view, 30)
        .widthIs(150)
        .heightIs(50);
        
        UIImageView *timeImageView = [UIImageView new];
        timeImageView.image = [UIImage imageNamed:@"Home_Time"];
        timeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.closedView addSubview:timeImageView];
        
        timeImageView.sd_layout
        .leftSpaceToView(self.closedView, 5)
        .centerYEqualToView(self.closedView)
        .widthIs(30)
        .heightEqualToWidth();
        
        UILabel *label = [UILabel new];
        label.text = @"距离结束还剩";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        [self.closedView addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(timeImageView, 5)
        .topSpaceToView(self.closedView, 5)
        .heightIs(16);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
        self.timeLabel = [UILabel new];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:18];
        [self.closedView addSubview:self.timeLabel];
        
        self.timeLabel.sd_layout
        .leftSpaceToView(timeImageView, 5)
        .topSpaceToView(label, 5)
        .heightIs(18);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    }
    
    if (self.secondsCountDown <= 0 && self.chatStateModel.endtime) {
        // 倒计时的时间 测试数据
        NSString *deadlineStr = self.chatStateModel.endtime;
        // 当前时间的时间戳
        NSString *nowStr = [self getCurrentTimeyyyymmdd];
        // 计算时间差值
        self.secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
        
        KLog(@"%ld",(long)self.secondsCountDown);
        
        if (self.secondsCountDown < 0) {
            
            self.timeLabel.text = @"已结束";
            
            [[MessageRequest new] postCloseMsgMid:self.mid complete:^(HttpGeneralBackModel *genneralBackModel) {
                
            }];
            
        }else{
            
            self.activeTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(activeCountDownAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.activeTimer forMode:NSRunLoopCommonModes];
        }
    }
}

-(void)activeCountDownAction{
    if (self.secondsCountDown <= 0) {
        self.secondsCountDown = 86400;
    }
    // 重新计算 时/分/秒
    NSInteger hour = self.secondsCountDown / 3600;
    NSString *str_hour = [NSString stringWithFormat:@"%@", @(hour)];
    NSInteger minute = (self.secondsCountDown % 3600) / 60;
    NSString *str_minute = [NSString stringWithFormat:@"%@", @(minute)];
    NSInteger second = self.secondsCountDown % 60;
    NSString *str_second = [NSString stringWithFormat:@"%@", @(second)];
    NSString *format_time = [NSString stringWithFormat:@"%@ : %@ : %@", str_hour, str_minute, str_second];
    // 修改倒计时标签及显示内容
    dispatch_async(dispatch_get_main_queue(), ^{
        self.timeLabel.text = [NSString stringWithFormat:@"%@", format_time];
    });
//    DebugLog(@"time: %@", format_time);
    
    self.secondsCountDown--;
    if (self.secondsCountDown < 0) {
        
        self.timeLabel.text = @"已结束";
        self.secondsCountDown = 0;
        
        [[MessageRequest new]postCloseMsgMid:self.mid complete:^(HttpGeneralBackModel *genneralBackModel) {
            
        }];
        
        [self.activeTimer invalidate];
        self.activeTimer = nil;
    }
}

- (NSString *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}


-(void)again:(UITapGestureRecognizer *)sender{
    
    self.chatKeyboardView.hidden = NO;
    self.closedView.hidden = YES;
    [self.againView removeFromSuperview];
    
    WS(weakSelf)
    [[MessageRequest new] postRestartMsgMid:self.mid complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        [weakSelf requst:1];
        if (weakSelf.secondsCountDown > 0) {
            weakSelf.closedView.hidden = NO;
        }
        
    }];
    
}

-(void)closed:(UITapGestureRecognizer *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即结束会话？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *takePhotos = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.closedView.hidden = YES;
//        [self.closedView removeFromSuperview];
        
        WS(weakSelf);
        
        [[MessageRequest new]postCloseMsgMid:self.mid complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            if (genneralBackModel.retcode == 0) {
                
                weakSelf.secondsCountDown = 0;
                [weakSelf requst:1];
                
//                [self initAgainView];
            }
            
        }];
        
    }];

    [alert addAction:takePhotos];
    
    [alert addAction:ok];//添加确认按钮
    
    //以modal的形式
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}

@end
