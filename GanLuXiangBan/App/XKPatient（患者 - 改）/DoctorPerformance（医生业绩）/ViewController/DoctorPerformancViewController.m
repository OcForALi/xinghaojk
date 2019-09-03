//
//  DoctorPerformancViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorPerformancViewController.h"

@interface DoctorPerformancViewController ()

@end

@implementation DoctorPerformancViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [self setTitle:@"医生姓名业绩"];
    [self setHeaderView];
}


#pragma mark - UI
- (void)setHeaderView {
    
    NSArray *texts = @[@"品种数量", @"处方数", @"订单金额", @"患者数"];
    NSArray *units = @[@"", @"张", @"元", @""];
    UIView *headerView = [self setInfoWithTexts:texts units:units];
    [self.view addSubview:headerView];
}

- (UIView *)setInfoWithTexts:(NSArray *)texts units:(NSArray *)units {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    for (int i = 0; i < texts.count; i++) {
        
        // 背景
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(ScreenWidth / texts.count * i, 0, ScreenWidth / texts.count, 0);
        bgButton.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:bgButton];
        
        // 积分
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, bgButton.width, 18)];
        numberLabel.tag = i + 100;
        numberLabel.text = [NSString stringWithFormat:@"100%@", units[i]];
        numberLabel.font = [UIFont boldSystemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:numberLabel];
        
        // 可用积分
        UILabel *integralTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, numberLabel.maxY + 10, bgButton.width, 15)];
        integralTitleLabel.text = texts[i];
        integralTitleLabel.font = [UIFont systemFontOfSize:13];
        integralTitleLabel.textColor = kMainColor;
        integralTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:integralTitleLabel];
        
        bgView.height = bgButton.height = integralTitleLabel.maxY + numberLabel.y;
        [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    
    for (NSInteger i = 1; i < texts.count; i++) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / texts.count * i, 15, 0.5, bgView.height - 30)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [bgView addSubview:lineView];
    }
    
    return bgView;
}


@end
