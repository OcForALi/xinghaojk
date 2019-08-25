//
//  TreatmentViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TreatmentViewController.h"
#import "TreatmentViewModel.h"
#import "KTextFeildView.h"
#import "CertificationViewModel.h"

@interface TreatmentViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *delArray;
@property (nonatomic, strong) UIView *imgBgView;
@property (nonatomic, strong) NSArray *delIds;
@property (nonatomic, strong) KTextFeildView *textFeildView;

@end

@implementation TreatmentViewController
@synthesize textFeildView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"诊疗记录";
    self.delArray = [NSMutableArray array];
    self.addImas = [NSMutableArray array];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
        @strongify(self);
        [self save];
    }];
    
    [self initTimeLabel];
    [self initTextFeild];
    [self initImgAddView];
    [self getPatientDiagnosis];

    self.imgArray = [NSMutableArray new];
    if ([self.imgs count] > 0) {
        
        [self.imgArray addObjectsFromArray:self.imgs];
        
        __block int count = 0;
        for (int i = 0; i < self.imgs.count; i++) {
            
            NSString *imgString = self.imgs[i];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgString] options:SDWebImageProgressiveDownload progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
             {
                 [self.imgArray replaceObjectAtIndex:i withObject:image];
                 
                 count ++;
                 if (count == self.imgs.count) {
                     [self createImgBtn];
                 }
             }];
        }
    }
}

#pragma mark - UI
/// 时间Label
- (void)initTimeLabel {
    
    /// 获取时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    UILabel *currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    currentTimeLabel.text = [formatter stringFromDate:[NSDate date]];
    currentTimeLabel.font = [UIFont systemFontOfSize:13];
    currentTimeLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:currentTimeLabel];
}

/// 文本框
- (void)initTextFeild {
    
    /// 背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 200)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    textFeildView = [[KTextFeildView alloc] initWithFrame:CGRectMake(5, 5, ScreenWidth - 10, bgView.height - 20)];
    textFeildView.tipString = @"请输入患者主诉、诊疗相关记录";
    textFeildView.tipLabel.font = [UIFont systemFontOfSize:13];
    textFeildView.textView.text = self.text;
    [bgView addSubview:textFeildView];
    
    if (self.text.length > 0) {
        textFeildView.tipString = @"";
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIView *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.height * i, ScreenWidth, 0.5)];
        lineView.backgroundColor = kLineColor;
        [bgView addSubview:lineView];
    }
}

/// 图片
- (void)initImgAddView {
    
    CGFloat btnWidth = (ScreenWidth - 50) / 4;
    
    /// 背景
    self.imgBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, ScreenWidth, btnWidth + 30)];
    self.imgBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgBgView];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgBgView.height * i, ScreenWidth, 0.5)];
        lineView.backgroundColor = kLineColor;
        [self.imgBgView addSubview:lineView];
    }
    
    [self addImgBtn:CGRectMake(10, 15, btnWidth, btnWidth)];
}

- (void)createImgBtn {
    
    CGFloat btnWidth = (ScreenWidth - 50) / 4;
    UIButton *tempButton = [self addImgBtn:CGRectMake(10, 15, btnWidth, btnWidth)];
    for (int i = 0; i < self.imgArray.count; i++) {
        
        if (i == 0) {
            
            [tempButton setImage:self.imgArray[0] forState:UIControlStateNormal];
            [self addDeletewithSubview:tempButton];
        }
        else {
            
            CGRect newFrame = tempButton.frame;
            newFrame.origin.x = 10 + (btnWidth + 10) * i;
            
            UIButton *addBtn = [self addImgBtn:newFrame];
            [addBtn setImage:self.imgArray[i] forState:UIControlStateNormal];
            [self addDeletewithSubview:addBtn];
        }
    }
    
    if (self.imgArray.count < 4) {
        
        CGRect newFrame = tempButton.frame;
        newFrame.origin.x = 10 + (btnWidth + 10) * self.imgArray.count;
        [self addImgBtn:newFrame];
        
    }
}

- (UIButton *)addImgBtn:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = frame.origin.x / frame.size.width + 100;
    button.clipsToBounds = YES;
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button setImage:[UIImage imageNamed:@"TreatmentAddImg"] forState:UIControlStateNormal];
    [self.imgBgView addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

        self.currentBtn = button;
        
        NSArray *titles = @[@"拍照", @"从相册选取一张照片"];
        [self actionSheetWithTitle:nil titles:titles isCan:YES completeBlock:^(NSInteger index) {
            [self openImagePickerControllerWithIndex:index];
        }];
    }];
    
    return button;
}

- (void)addDeletewithSubview:(UIView *)subview {
    
    UIImage *img = [UIImage imageNamed:@"TreatmentDeleteImg"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(CGRectGetMaxX(subview.frame) - 7.5, subview.y - 7.5, 15, 15);
    button.tag = subview.tag + 100;
    button.layer.cornerRadius = button.height / 2;
    button.layer.masksToBounds = YES;
    [button setImage:img forState:UIControlStateNormal];
    [subview.superview addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSInteger currentTag = subview.tag;
        NSInteger deleteTag = button.tag;
        
        [subview removeFromSuperview];
        [button removeFromSuperview];
        
        for (int i = 0; i < 4; i++) {
            
            UIButton *nextButton = [self.view viewWithTag:currentTag + i];
            UIButton *nextDeleteButton = [self.view viewWithTag:deleteTag + i];
            if ([nextButton isKindOfClass:[UIButton class]]) {
                [nextButton removeFromSuperview];
                [nextDeleteButton removeFromSuperview];
            }
        }
        
        NSInteger index = currentTag - 100;
        NSMutableArray *tempImgs = [NSMutableArray arrayWithArray:self.imgs];
        NSMutableArray *tempImgIds = [NSMutableArray arrayWithArray:self.delIds];
        if (index < tempImgIds.count) {
            [self.delArray addObject:[tempImgIds[index] copy]];
            [tempImgs removeObjectAtIndex:index];
            [tempImgIds removeObjectAtIndex:index];
        }else{
            
            [self.addImas removeObjectAtIndex:index - tempImgIds.count];
            
        }
        self.imgs = tempImgs;
        self.delIds = tempImgIds;
        
        [self.imgArray removeObjectAtIndex:index];
        [self createImgBtn];
    }];
}

#pragma mark - UIImagePickerController
- (void)openImagePickerControllerWithIndex:(NSInteger)index {
    
    if (index != 0) {
        
        NSUInteger sourceType = 0;
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            if (index == 1) {
                
                //拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.sourceType = sourceType;
            }
            else if (index == 2) {
                
                //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.sourceType = sourceType;
            }
        }
        else {
            
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
        }
        
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.currentBtn setImage:image forState:UIControlStateNormal];
        [self.imgArray addObject:image];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        
        [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
            [self.addImas addObject:object];
        }];
        
        if (ScreenWidth > CGRectGetMaxX(self.currentBtn.frame) + self.currentBtn.width) {
            
            CGRect newFrame = self.currentBtn.frame;
            newFrame.origin.x = self.currentBtn.frame.origin.x + self.currentBtn.width + 10;
            [self addImgBtn:newFrame];
        }
        
        [self addDeletewithSubview:self.currentBtn];
        
    });
}

#pragma mark - request
- (void)save {
    
    BOOL isEdit = self.text.length > 0 ? YES : NO;
    [[TreatmentViewModel new] addPatientDiagnosis:self.pkid
                                          content:self.textFeildView.textView.text
                                              mid:self.mid
                                         addFiles:self.addImas
                                           delIds:self.delArray
                                           isEdit:isEdit
                                         complete:^(id object)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             [self hideHudAnimated];
             
             if (isEdit) [[UIApplication sharedApplication].keyWindow makeToast:@"修改成功"];
             else [[UIApplication sharedApplication].keyWindow makeToast:@"添加成功"];
             
             
             if (self.refreshBlock) {
                 self.refreshBlock();
             }
             
             [self.navigationController popViewControllerAnimated:YES];
         });
         
     }];
    
//    [self showHudAnimated:YES];
//
//    __block int count = 0;
//
//    NSLog(@"%@",self.imgArray);
//
//    NSMutableArray *imgUrls = [NSMutableArray arrayWithArray:self.imgArray];
//    for (int i = 0; i < self.imgArray.count; i++) {
//
//        UIImage *image = self.imgArray[i];
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
//        [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
//
//            [imgUrls replaceObjectAtIndex:i withObject:object];
//
//            for (NSString *urlString in imgUrls) {
//
//                if ([urlString isKindOfClass:[NSString class]]) {
//                    count += 1;
//                }
//
//                if (count == imgUrls.count) {
//                    [self addPatientDiagnosis:imgUrls];
//                }
//            }
//
//        }];
//    }
}

- (void)addPatientDiagnosis:(NSMutableArray *)arr {
    
    for (int i = 0; i < self.imgs.count; i++) {
        [arr removeObjectAtIndex:0];
    }
    
    BOOL isEdit = self.text.length > 0 ? YES : NO;
    [[TreatmentViewModel new] addPatientDiagnosis:self.pkid
                                          content:self.textFeildView.textView.text
                                              mid:self.mid
                                         addFiles:arr
                                           delIds:self.delArray
                                           isEdit:isEdit
                                         complete:^(id object)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
      
             [self hideHudAnimated];
             
             if (isEdit) [[UIApplication sharedApplication].keyWindow makeToast:@"修改成功"];
             else [[UIApplication sharedApplication].keyWindow makeToast:@"添加成功"];
             [self.navigationController popViewControllerAnimated:YES];
         });
         
     }];
}

- (void)getPatientDiagnosis {
    
    [[TreatmentViewModel new] getPatientDiagnosis:self.pkid complete:^(id object) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (PatientDiagnosisModel *model in object) {
            [arr addObject:model.pkid];
        }
        
        self.delIds = arr;
    }];
}

@end
