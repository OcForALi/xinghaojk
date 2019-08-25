//
//  NewPatientViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "NewPatientViewController.h"
#import "NewPatientViewModel.h"
#import "NewPatientView.h"

@interface NewPatientViewController ()

@property (nonatomic, strong) NewPatientView *newPatientView;

@end

@implementation NewPatientViewController
@synthesize newPatientView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"新患者";
    [self getDrPatient];
}

#pragma mark - lazy
- (NewPatientView *)newPatientView {
    
    if (!newPatientView) {
        
        newPatientView = [[NewPatientView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:newPatientView];
        
        @weakify(self);
        [self.newPatientView setGoViewController:^(UIViewController *viewController) {
            
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return newPatientView;
}

- (void)getDrPatient {
    
    [[NewPatientViewModel new] getDrNewPatienttComplete:^(id object) {
        self.newPatientView.dictDataSource = object;
    }];
}

@end
