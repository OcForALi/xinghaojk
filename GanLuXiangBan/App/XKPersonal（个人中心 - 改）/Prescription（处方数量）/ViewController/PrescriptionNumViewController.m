//
//  PrescriptionNumViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionNumViewController.h"
#import "PrescriptionNumView.h"

@interface PrescriptionNumViewController ()

@property (nonatomic, strong) PrescriptionNumView *numberView;

@end

@implementation PrescriptionNumViewController
@synthesize numberView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self initialization];
    [self setTitle:@"医生处方"];
}

// 初始化
- (void)initialization {
    
    self.numberView.dataSources = @[@"医生姓名（医院名称）", @"医生姓名（医院名称）", @"医生姓名（医院名称）", @"医生姓名（医院名称）"];
}

#pragma mark - lazy
- (PrescriptionNumView *)numberView {
    
    if (!numberView) {
        
        numberView = [[PrescriptionNumView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        numberView.height = ScreenHeight - self.navHeight;
        numberView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:numberView];
    }
    
    return numberView;
}

@end
