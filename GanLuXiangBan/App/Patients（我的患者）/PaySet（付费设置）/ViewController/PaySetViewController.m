//
//  PaySetViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PaySetViewController.h"
#import "PaySetViewModel.h"
#import "PaidConsultingViewModel.h"
#import "PaySetView.h"

@interface PaySetViewController ()

@property (nonatomic, strong) PaySetView *paySetView;

@end

@implementation PaySetViewController
@synthesize paySetView;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"付费设置";
    
    if (self.mid && self.mid.length > 0) {
        @weakify(self);
        [self addNavRightTitle:@"保存" complete:^{
            @strongify(self);
            [self save];
        }];
        [self getDataSource];
    }
}


#pragma mark - lazy
- (PaySetView *)paySetView {
    
    if (!paySetView) {
        
        paySetView = [[PaySetView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:paySetView];
    }
    
    return paySetView;
}


#pragma mark - request

- (PaySetModel *)checkModel:(NSArray *)list type:(NSInteger)type {
    PaySetModel *model = nil;
    for (PaySetModel *pay in list) {
        if ([pay.visit_type integerValue] == type) {
            model = pay;
            break;
        }
    }
    if (!model) {
        model = [PaySetModel new];
        model.visit_type = [NSString stringWithFormat:@"%@", @(type)];
        model.pay_money = @"-1";
        model.is_open = @"0";
    }
    return model;
}

- (void)getDataSource {
    WS(weakSelf)
    [[PaySetViewModel new] getPatientVisit:self.mid complete:^(id object) {
        NSArray *res = object;
        PaySetModel *one = [weakSelf checkModel:res type:1];
        PaySetModel *two = [weakSelf checkModel:res type:2];
        PaySetModel *three = [weakSelf checkModel:res type:3];
        weakSelf.paySetView.prices = @[one, two, three];
        weakSelf.paySetView.dataSources = @[@"图文咨询", @"电话咨询", @"线下咨询"];
    }];
}

- (void)save {
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (PaySetModel *pay in self.paySetView.prices) {
        NSNumber *money = [NSNumber numberWithInteger:-1];
        if (pay.pay_money && ![pay.pay_money isEqualToString:@"-1"]) {
            money = [NSNumber numberWithInteger:[pay.pay_money integerValue]];
        }
        NSDictionary *dic = @{@"mid": [NSNumber numberWithInteger:[self.mid integerValue]], @"visit_type": [NSNumber numberWithInteger:[pay.visit_type integerValue]], @"pay_money": money};
        [res addObject:dic];
    }
    WS(weakSelf)
    [[PaySetViewModel new] savePatientVisit:res complete:^(NSString *msg) {
        
        [weakSelf.view makeToast:msg];
        
    }];
    
//    __block int a = 0;
//    for (PaySetModel *model in self.paySetView.prices) {
//
//        [[PaySetViewModel new] saveVisitDetailWithModel:model ids:@[self.mid] complete:^(id object) {
//
//            if (a == 0) {
//
//                [weakSelf.view makeToast:object];
//            }
//
//            a += 1;
//        }];
//    }
}

@end
