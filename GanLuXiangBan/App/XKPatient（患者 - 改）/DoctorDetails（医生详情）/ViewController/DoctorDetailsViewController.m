//
//  DoctorDetailsViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorDetailsViewController.h"
#import "DoctorPerformancViewController.h"
#import "DoctorDetailsView.h"

@interface DoctorDetailsViewController ()

@property (nonatomic, strong) DoctorDetailsView *detailsView;

@end

@implementation DoctorDetailsViewController
@synthesize detailsView;

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    [self setRight];
    [self initialization];
}

- (void)setRight {
    
    @weakify(self);
    [self addNavRightTitle:@"业绩查看" complete:^{
     
        @strongify(self);
        
        DoctorPerformancViewController *vc = [DoctorPerformancViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

// 初始化
- (void)initialization {
    
    self.detailsView.dataSources = @[@[@"推荐关系", @"推荐人：", @"跟进人："],
                                     @[@"医生姓名：", @"职       称：", @"医院名称：", @"科       室：", @"加入时间：", @"联系电话："]];
}


#pragma mark - lazy
- (DoctorDetailsView *)detailsView {
    
    if (!detailsView) {
        
        detailsView = [[DoctorDetailsView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        detailsView.height = ScreenHeight - self.navHeight;
        [self.view addSubview:detailsView];
    }
    
    return detailsView;
}

@end
