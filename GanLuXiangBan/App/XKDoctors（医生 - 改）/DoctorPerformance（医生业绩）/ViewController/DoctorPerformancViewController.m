//
//  DoctorPerformancViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorPerformancViewController.h"
#import "PerformanceViewModel.h"
#import "DoctorPerformancView.h"

@interface DoctorPerformancViewController ()

@property (nonatomic, strong) DoctorPerformancView *performancView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) int page;
@property (nonatomic, assign) int type;

@end

@implementation DoctorPerformancViewController
@synthesize performancView;

- (void)viewDidLoad {

    [super viewDidLoad];

    [self setTitle:@"医生姓名业绩"];
    [self setHeaderView];
    [self getDataSource];
}


#pragma mark - UI
- (void)setHeaderView {
    
    NSArray *texts = @[@"品种数量", @"处方数", @"订单金额", @"患者数"];
    NSArray *units = @[@"", @"张", @"元", @""];
    self.headerView = [self setInfoWithTexts:texts units:units];
    [self.view addSubview:self.headerView];
}

- (UIView *)setInfoWithTexts:(NSArray *)texts units:(NSArray *)units {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    for (int i = 0; i < texts.count; i++) {
        
        // 背景
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(ScreenWidth / texts.count * i, 0, ScreenWidth / texts.count, 0);
        bgButton.backgroundColor = [UIColor whiteColor];
        bgButton.tag = i + 10;
        [bgButton addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:bgButton];
        
        // 数量
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, bgButton.width, 18)];
        numberLabel.tag = i + 100;
        numberLabel.text = [NSString stringWithFormat:@"100%@", units[i]];
        numberLabel.font = [UIFont boldSystemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:numberLabel];
        
        // 可用积分
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, numberLabel.maxY + 10, bgButton.width, 15)];
        nameLabel.text = texts[i];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = kMainColor;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [bgButton addSubview:nameLabel];
        
        bgView.height = bgButton.height = nameLabel.maxY + numberLabel.y;
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

- (void)setUnits:(NSArray *)units {
    
    for (int i = 0; i < units.count; i++) {
        
        UILabel *numberLabel = [self.view viewWithTag:i + 100];
        numberLabel.text = units[i];
    }
}

- (void)clickType:(UIButton *)button {
    
    if (button.tag - 10 < 2) {
        
        self.type = (int)button.tag - 10;
        [self getDataSource];
    }
}

#pragma mark - lazy
- (DoctorPerformancView *)performancView {
    
    if (!performancView) {
        
        performancView = [[DoctorPerformancView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        performancView.y = self.headerView.maxY;
        performancView.height = ScreenHeight - performancView.y - self.navHeight;
        [self.view addSubview:performancView];
    }
    
    return performancView;
}


#pragma mark - request
- (void)getDataSource {
    
    PerformanceViewModel *viewModel = [PerformanceViewModel new];
    [viewModel getPerformanceWithId:self.drid page:self.page type:self.type complete:^(PerformanceModel * _Nonnull model) {
        
        if (model) {
            
            NSArray *units = @[model.drug_num,
                               [model.recipe_num stringByAppendingString:@"张"],
                               [model.order_amount stringByAppendingString:@"元"],
                               model.patient_num];
            
            [self setUnits:units];
            
            self.performancView.model = model;
        }
    }];
}

@end
