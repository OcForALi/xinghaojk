//
//  AgentProductViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentProductViewController.h"
#import "NinaPagerView.h"
#import "ProductExamineAdoptViewController.h"
#import "ProductExamineInViewController.h"
#import "ProductExamineFailViewController.h"

@interface AgentProductViewController ()<NinaPagerViewDelegate>

@end

@implementation AgentProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品代理";
    
    [self addChildViewController];
    
    [self initUI];
    
}

- (void)addChildViewController{
    
    ProductExamineAdoptViewController *productExamineAdoptVC = [[ProductExamineAdoptViewController alloc] init];
    [self addChildViewController:productExamineAdoptVC];
    
    ProductExamineInViewController *productExamineInVC = [[ProductExamineInViewController alloc] init];
    [self addChildViewController:productExamineInVC];
    
    ProductExamineFailViewController *productExamineFailVC = [[ProductExamineFailViewController alloc] init];
    [self addChildViewController:productExamineFailVC];
    
}

- (void)initUI{
    
    NSArray *titleArray = @[@"审核通过",@"审核中",@"审核不通过"];
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) WithTitles:titleArray WithVCs:self.childViewControllers];
    ninaPagerView.ninaPagerStyles = 0;
    ninaPagerView.nina_navigationBarHidden = NO;
    ninaPagerView.selectTitleColor = kMainColor;
    ninaPagerView.unSelectTitleColor = [UIColor blackColor];
    ninaPagerView.underlineColor = kMainColor;
    ninaPagerView.selectBottomLinePer = 0.8;
    ninaPagerView.delegate = self;
    [self.view addSubview:ninaPagerView];
    
}


@end
