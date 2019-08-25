//
//  MyStudioViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyStudioViewController.h"
#import "DrugViewController.h"
#import "MedicalRecordsViewController.h"
#import "DiseasesViewController.h"
#import "RecDrugsViewController.h"
#import "PrescriptionViewController.h"
#import "DrugListViewController.h"
#import "CollectionViewController.h"
#import "AllDrugViewController.h"

@interface MyStudioViewController ()

@property (nonatomic ,copy) NSArray *titleArray;

@property (nonatomic ,copy) NSArray *imageArray;

@end

@implementation MyStudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的工作室";
    
    [self data];
    
    [self initUI];
    
}

-(void)data{
    
    self.titleArray = @[@"常用药",@"常用疾病",@"常用处方",@"推荐用药",@"用药记录",@"药品目录",@"医生圈"];
    
    self.imageArray = @[@"MyMedicineCabinet",@"MyStudio",@"MedicalRecords",@"RecommendedDosage",@"MedicalRecords",@"MyMedicineCabinet",@"docquan"];
    
}

-(void)initUI{
    
    NSInteger integer = 0;
    NSInteger countInteger = 0;

    for (int i = 0; i < self.titleArray.count; i++) {
        
        if (countInteger == 2) {
            integer++;
        }
        
        countInteger = i%3;
        
        CGSize size = CGSizeMake(ScreenWidth*0.145, ScreenWidth*0.145);
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:self.imageArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = i + 10000;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [self.view addSubview:imageView];
        
        imageView.sd_layout
        .leftSpaceToView(self.view,ScreenWidth * 0.14 + (i%3) * size.width + (i%3) * ScreenWidth * 0.145)
        .topSpaceToView(self.view, ScreenHeight * 0.053 + integer * size.height + integer * ScreenHeight * 0.086)
        .widthIs(size.width)
        .heightIs(size.height);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = self.titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titleLabel];
        
        titleLabel.sd_layout
        .centerXEqualToView(imageView)
        .topSpaceToView(imageView, 7)
        .heightIs(14);
        [titleLabel setSingleLineAutoResizeWithMaxWidth:100];
        
    }

}

-(void)tap:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag - 10000 == 0) {

        CollectionViewController *vc = [[CollectionViewController alloc] init];
//        vc.title = @"常用药";
//        vc.showAll = YES;
//        DrugViewController *vc = [[DrugViewController alloc] init];
        [self.navigationController pushViewController:vc  animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 1) {
        
        DiseasesViewController *diseasesView = [[DiseasesViewController alloc] init];
        [self.navigationController pushViewController:diseasesView animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 2) {
        
        PrescriptionViewController *vc = [[PrescriptionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 3) {
        
        RecDrugsViewController *recDrugsView = [[RecDrugsViewController alloc] init];
        [self.navigationController pushViewController:recDrugsView animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 4) {
        
        MedicalRecordsViewController *medicalView = [[MedicalRecordsViewController alloc] init];
        [self.navigationController pushViewController:medicalView animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 5) {
        
        AllDrugViewController *drugView = [[AllDrugViewController alloc] init];
        drugView.title = @"药品目录";
        drugView.showAll = YES;
        [self.navigationController pushViewController:drugView animated:YES];
        
    }
    else if (sender.view.tag - 10000 == 6) {
        UIViewController *vc = [NSClassFromString(@"DocCircleViewController") new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
