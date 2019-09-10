//
//  ReApplicationViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ReApplicationViewController.h"
#import "CertificationViewModel.h"
#import "AgentProductRequest.h"

@interface ReApplicationViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic ,strong) UILabel *noPassLabel;

@property (nonatomic ,copy) NSArray *itemArray;

@property (nonatomic ,copy) NSArray *drugArray;

@property (nonatomic ,retain) NSMutableArray *picArray;

@property (nonatomic ,strong) UIView *picView;

@end

@implementation ReApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 0) {
        self.title = @"上传授权证明";
    }else if (self.type == 1){
        self.title = @"重新提交";
        [self request];
    }
    
    self.picArray = [NSMutableArray array];
    
    [self initUI];
    
}

- (void)request{
    WS(weakSelf)
    AgentProductRequest *request = [AgentProductRequest new];
    [request getAgDrugAppDetailAppID:self.appID :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if (generalBackModel.data != nil) {
            
            ProductModel *model = [ProductModel new];
            [model setValuesForKeysWithDictionary:generalBackModel.data];
            
            [weakSelf.picArray addObjectsFromArray:model.certs];
            weakSelf.noPassLabel.text = model.unreason;
            
        }
        
    }];
    
}

- (void)setAddModel:(DrugListModel *)addModel{
    
    _addModel = addModel;
    
    NSString *drugName = [NSString stringWithFormat:@"%@(%@)",addModel.drug_name,addModel.common_name];
    
    self.drugArray = @[drugName,addModel.standard,addModel.producer];
    
}

- (void)setNoPassModel:(ProductModel *)noPassModel{
    
    _noPassModel = noPassModel;
    
    NSString *drugName = [NSString stringWithFormat:@"%@(%@)",noPassModel.drugNm,noPassModel.commonNm];
    
    self.drugArray = @[drugName,noPassModel.spec,noPassModel.producer];
    
}

- (void)initUI{
    
    self.itemArray = @[@"名称：",@"规格：",@"厂家："];
    
    for (int i = 0; i < self.itemArray.count; i++) {
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.text = self.itemArray[i];
        [self.view addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self.view, 15)
        .topSpaceToView(self.view, 15 + i * 19)
        .heightIs(14);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.tag = i + 1000;
        contentLabel.text = self.drugArray[i];
        [self.view addSubview:contentLabel];
        
        contentLabel.sd_layout
        .leftSpaceToView(label, 5)
        .centerYEqualToView(label)
        .heightIs(14);
        [contentLabel setSingleLineAutoResizeWithMaxWidth:300];
        
    }
    
    self.noPassLabel = [UILabel new];
    self.noPassLabel.textColor = [UIColor redColor];
    self.noPassLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.noPassLabel];
    
    self.noPassLabel.sd_layout
    .leftSpaceToView(self.view, 15)
    .topSpaceToView(self.view, 15 + self.itemArray.count * 19)
    .heightIs(14);
    [self.noPassLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    UIView *garyView = [UIView new];
    garyView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:garyView];
    
    if (self.type == 0) {
        garyView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 20 + self.itemArray.count * 19)
        .heightIs(2);
    }else if (self.type == 1){
        garyView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.noPassLabel, 3)
        .heightIs(1);
    }
    
    UIButton *button = [UIButton new];
    button.backgroundColor = kMainColor;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submission:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(40);
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"温馨提示：\n\n1）请上传对应品种的相关资质以便更快通过审核\n\n2） 相关的资质务必清晰";
    [self.view addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(button, 20)
    .autoHeightRatio(0);
    
    self.picView = [UIView new];
    [self.view addSubview:self.picView];
    
    self.picView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(garyView, 0)
    .bottomSpaceToView(label, 0);
    
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

- (void)submission:(UIButton *)sender{
    
    if (self.picArray.count == 0) {
        [self.view makeToast:@"请提交相关资质"];
        return;
    }
    
    WS(weakSelf)
    AgentProductRequest *request = [AgentProductRequest new];
    
    if (self.type == 0) {
        
        [request postAgentDrugAppAppId:0 Drug_id:self.addModel.drug_id Drug_name:self.addModel.drug_name Commonname:self.addModel.common_name Producer:self.addModel.producer Spec:self.addModel.standard Form:@"" Unit:@"" Approval:@"" Certs:self.picArray :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
            
            [weakSelf.view makeToast:generalBackModel.retmsg];
            if (generalBackModel.retcode == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }];
        
    }else if (self.type == 1){
        
        [request postReAppDrugAgentAppId:self.noPassModel.appId Drug_id:self.noPassModel.drugId Drug_name:self.noPassModel.drugNm Commonname:self.noPassModel.commonNm Producer:self.noPassModel.producer Spec:self.noPassModel.spec Form:@"" Unit:@"" Approval:@"" Certs:self.picArray :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
            
            [weakSelf.view makeToast:generalBackModel.retmsg];
            if (generalBackModel.retcode == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }];
        
    }
    
}

@end
