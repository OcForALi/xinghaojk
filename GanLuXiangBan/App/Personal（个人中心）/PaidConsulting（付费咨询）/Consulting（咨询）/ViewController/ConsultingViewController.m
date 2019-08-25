//
//  ConsultingViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ConsultingViewController.h"
#import "ConsultingView.h"
#import "ConsultingViewModel.h"
#import "HelpWebViewController.h"
#import "PaySetViewModel.h"
#import "GroupAddModel.h"

@interface ConsultingViewController ()

@property (nonatomic, strong) ConsultingView *consultingView;

@end

@implementation ConsultingViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self initConsultingView];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
    
        @strongify(self);
        [self save];
    }];
}

- (void)initConsultingView {
    
    self.consultingView = [[ConsultingView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.consultingView.dataSources = @[@[@"价格", @"选择患者"], @[[NSString stringWithFormat:@"%@介绍", self.title]]];
    self.consultingView.model = self.model;
    [self.view addSubview:self.consultingView];
    
    @weakify(self);
    [self.consultingView setGoViewControllerBlock:^(UIViewController *viewController) {
        
        @strongify(self);
        if ([viewController isKindOfClass:[HelpWebViewController class]]) {
            [self getHelpWithviewController:(HelpWebViewController *)viewController];
        }
        else {
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }];
}

- (void)getHelpWithviewController:(HelpWebViewController *)viewController {
    
    [[ConsultingViewModel new] getHelpWithType:self.model.visit_type complete:^(id object) {
        viewController.bodyString = object;
        viewController.title = [NSString stringWithFormat:@"%@介绍", self.title];
        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

- (void)save {
    
    NSMutableArray *ids = [NSMutableArray array];
    for (GroupAddModel *groupAddModel in self.consultingView.patientsArray) {
        [ids addObject:groupAddModel.mid];
    }

    [[PaySetViewModel new] saveVisitDetailWithModel:self.consultingView.paySetModel ids:ids complete:^(id object) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}



@end
