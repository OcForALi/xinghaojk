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
#import "HospitalModel.h"
#import "CertificationViewModel.h"

@interface FillInDataViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic ,strong) FillInDataView *fillInView;

@property (nonatomic ,retain) NSMutableArray *fillInDataArray;

@property (nonatomic ,retain) LogInRequest *logInRequest;

@property (nonatomic ,retain) DrugModel *drugModel;

@property (nonatomic ,retain) NSMutableArray *hospitalArray;

@property (nonatomic ,strong) UIView *picView;

@property (nonatomic ,retain) NSMutableArray *picArray;

@end

@implementation FillInDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写信息";
    
    self.fillInDataArray = [NSMutableArray array];
    
    self.hospitalArray = [NSMutableArray array];
    
    self.picArray = [NSMutableArray array];
    
    [self initUI];
    
    [self block];
    
    [self not];
    
}

- (void)not{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hospitalHList:) name:@"HospitalHList" object:nil];
    
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
    
    self.picView = [UIView new];
    [self.view addSubview:self.picView];
    
    self.picView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, ScreenHeight * 0.6)
    .bottomSpaceToView(sendButton, 0);
    
    [self pic];
    
}

- (void)pic{
    
    [self.picView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.picArray.count == 0) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"Keyboard_Image"];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic:)];
        [imageView addGestureRecognizer:tap];
        [self.picView addSubview:imageView];
        
        imageView.sd_layout
        .leftSpaceToView(self.picView, ScreenWidth * 0.14)
        .topSpaceToView(self.picView, ScreenHeight * 0.053)
        .widthIs(ScreenWidth*0.145)
        .heightEqualToWidth();
        
    }else{
        
        NSInteger countInteger = 0;
        NSInteger integer = 0;
        
        for (int i = 0; i < self.picArray.count; i++) {
            
            if (countInteger == 2) {
                integer++;
            }
            
            countInteger = i%3;
            
            CGSize size = CGSizeMake(ScreenWidth*0.145, ScreenWidth*0.145);
            
            UIImageView *imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[i]] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.picView addSubview:imageView];
            
            imageView.sd_layout
            .leftSpaceToView(self.picView,ScreenWidth * 0.14 + (i%3) * size.width + (i%3) * ScreenWidth * 0.145)
            .topSpaceToView(self.picView, ScreenHeight * 0.053 + integer * size.height + integer * ScreenHeight * 0.086)
            .widthIs(size.width)
            .heightIs(size.height);
            
            if (i == self.picArray.count - 1) {
                
                if (countInteger + 1 == 3) {
                    integer++;
                }
                
                UIImageView *imageView = [UIImageView new];
                imageView.image = [UIImage imageNamed:@"Keyboard_Image"];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic:)];
                [imageView addGestureRecognizer:tap];
                [self.picView addSubview:imageView];
                
                imageView.sd_layout
                .leftSpaceToView(self.picView, ScreenWidth * 0.14 + ((i + 1)%3) * size.width + (( i + 1)%3) * ScreenWidth * 0.145)
                .topSpaceToView(self.picView, ScreenHeight * 0.053 + integer * size.height + integer * ScreenHeight * 0.086)
                .widthIs(size.width)
                .heightEqualToWidth();
                
            }
            
        }
        
    }
    
}

- (void)addPic:(UITapGestureRecognizer *)sender{
    
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
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        WS(weakSelf)
        [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
            
            [weakSelf.picArray addObject:object];
            
            [weakSelf pic];
            
        }];
        
    });
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

- (void)hospitalHList:(NSNotification *)sender{
    [self.hospitalArray removeAllObjects];
    NSArray *array = sender.object;
    
    for (HospitalModel *model in array) {
        [self.hospitalArray addObject:model.pkid];
    }
    
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
            
            if ([model.titleName isEqualToString:@"代理医院"]) {
                
                if (self.hospitalArray.count == 0) {
                    
                    [self.view makeToast:@"请选择代理医院"];
                    
                    return;
                    
                }else{
                    dataModel.HospitalIds = self.hospitalArray;
                }
                
            }
            
            if ([model.titleName isEqualToString:@"身份证号"]) {
                if (model.messageString.length < 1) {
                    
                    [self.view makeToast:@"请填写身份证号"];
                    
                    return;
                    
                }else{
                    
                    dataModel.IdCard = model.messageString;
                    
                }
            }
            
            if ([model.titleName isEqualToString:@"代理区域"]) {
                
                if (model.provinceID.length < 1) {
                    
                    [self.view makeToast:@"请选择代理区域"];
                    
                    return;
                    
                }
                
            }else{
                
                dataModel.ProvinceId = model.provinceID;
                
                if (model.cityID != nil) {
                    dataModel.CityId = model.cityID;
                }
                
            }
            
        }
        
        if (self.picArray.count == 0) {
            
            [self.view makeToast:@"请添加资质证明"];
            
            return;
            
        }else{
            
            dataModel.FileIds = self.picArray;
            
        }
        
    }
    
    dataModel.pkid = GetUserDefault(UserID);
    
    self.logInRequest = [LogInRequest new];
    WS(weakSelf);
    [self.logInRequest postSaveBasicInfo:dataModel complete:^(HttpGeneralBackModel *model) {
       
        if (model && model.retcode == 0) {
            
//            CertificationViewController *certificationView = [[CertificationViewController alloc] init];
//            certificationView.title = @"资格认证";
//            certificationView.type = 1;
//            [weakSelf.navigationController pushViewController:certificationView animated:YES];
            
            UIViewController *status = [NSClassFromString(@"RegisterStatusViewController") new];
            NSArray *list = @[[weakSelf.navigationController.viewControllers firstObject], status];
            [weakSelf.navigationController setViewControllers:list animated:YES];
            
        }else{
            
            [self.view makeToast:model.retmsg];
            
        }
        
    }];
    
}

@end
