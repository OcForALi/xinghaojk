//
//  PrescriptionNumViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionNumViewController.h"
#import "PrescriptionNumViewModel.h"
#import "PrescriptionNumView.h"

@interface PrescriptionNumViewController ()

@property (nonatomic, strong) PrescriptionNumView *numberView;
@property (nonatomic, assign) int page;

@end

@implementation PrescriptionNumViewController
@synthesize numberView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.page = 1;
    
    [self setTitle:@"医生处方"];
    [self getList];
}


#pragma mark - lazy
- (PrescriptionNumView *)numberView {
    
    if (!numberView) {
        
        numberView = [[PrescriptionNumView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        numberView.y = 0;
        numberView.height = ScreenHeight - self.navHeight;
        [self.view addSubview:numberView];
    }
    
    return numberView;
}


#pragma mark - request
- (void)getList {
    
    PrescriptionNumViewModel *viewModel = [PrescriptionNumViewModel new];
    [viewModel getListWithPage:self.page complete:^(NSArray * _Nonnull list) {
        self.numberView.dataSources = list;
    }];
}

@end
