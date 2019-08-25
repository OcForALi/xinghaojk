//
//  PaidConsultingViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PaidConsultingViewController.h"
#import "PaidConsultingView.h"
#import "PaidConsultingViewModel.h"

@interface PaidConsultingViewController ()

@property (nonatomic, strong) PaidConsultingView *paidConsultingView;

@end

@implementation PaidConsultingViewController
@synthesize paidConsultingView;

- (void)viewDidLoad {

    [super viewDidLoad];
    [self getDrVisits];
}

#pragma mark - lazy
- (PaidConsultingView *)paidConsultingView {
    
    if (!paidConsultingView) {
        
        paidConsultingView = [[PaidConsultingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        paidConsultingView.dataSources = @[@"图文咨询", @"电话咨询", @"线下咨询"];
        [self.view addSubview:paidConsultingView];
        
        @weakify(self);
        [paidConsultingView setGoViewControllerBlock:^(BaseViewController *viewController) {
            
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return paidConsultingView;
}

#pragma mark - request
- (void)getDrVisits {
    
    [[PaidConsultingViewModel new] getDrVisitsComplete:^(id object) {
        self.paidConsultingView.prices = object;
    }];
}

@end
