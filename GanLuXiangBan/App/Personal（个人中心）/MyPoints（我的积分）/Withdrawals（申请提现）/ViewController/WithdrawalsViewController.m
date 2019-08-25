//
//  WithdrawalsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "WithdrawalsViewController.h"
#import "WithdrawalsView.h"
#import "MyPointsViewModel.h"
#import "MyCardViewModel.h"
#import "MyPointModel.h"


@interface WithdrawalsViewController ()

@property (nonatomic, strong) WithdrawalsView *withdrawalsView;

@end

@implementation WithdrawalsViewController
@synthesize withdrawalsView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"申请提现";
    [self initWithdrawalsView];
    [self getBank];
}

- (void)setPointString:(NSString *)pointString {
    
    _pointString = pointString;
}

- (void)initWithdrawalsView {
    
    self.withdrawalsView = [[WithdrawalsView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.withdrawalsView.pointString = self.pointString;
    [self.view addSubview:self.withdrawalsView];
    
    @weakify(self);
    [self.withdrawalsView setGoViewController:^(UIViewController *viewController) {
       
        @strongify(self);
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
    [self.withdrawalsView setEchangeBlock:^(NSString *number, NSString *bankId) {
       
        @strongify(self);
        [[MyPointsViewModel new] pointExchangeWithBankId:bankId pointNum:number complete:^(id object) {
            
            [[UIApplication sharedApplication].keyWindow makeToast:object];
            if ([object isEqualToString:@"兑换成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
}

- (void)getBank {
    
    [[MyCardViewModel new] getUserBankListComplete:^(id object) {
      
        for (MyCardModel *model in object) {
            
            if ([model.is_default boolValue]) {
                self.withdrawalsView.myCardModel = model;
            }
        }
    }];
}

@end
