//
//  VisitDetailsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "VisitDetailsViewController.h"
#import "VisitDetailsView.h"
#import "VisitDetailsViewModel.h"
#import "SortingAreaViewModel.h"

@interface VisitDetailsViewController ()

@property (nonatomic, strong) VisitDetailsView *visitDetailsView;

@end

@implementation VisitDetailsViewController
@synthesize visitDetailsView;

- (void)viewDidLoad {

    [super viewDidLoad];

    [self createHeader];
    [self getDetails];
    [self getHelp];
    
    @weakify(self);
    [self addNavRightTitle:@"确定" complete:^{
        @strongify(self);
        [self saveDetails];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getHospitalList];    
}

- (void)createHeader {
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * i, 0, ScreenWidth / 3, 40)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
        [self.view addSubview:titleLabel];
        
        if (i > 0) {
            
            titleLabel.text = i == 1 ? @"上午" : @"下午";
        }
    }
}

#pragma mark - lazy
- (VisitDetailsView *)visitDetailsView {
    
    if (!visitDetailsView) {
        
        visitDetailsView = [[VisitDetailsView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - self.navHeight - 40) style:UITableViewStyleGrouped];
        [self.view addSubview:visitDetailsView];
        
        @weakify(self);
        [visitDetailsView setGoViewController:^(UIViewController *viewController) {
           
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return visitDetailsView;
}

#pragma mark - request


- (NSString *)parseVisitType:(NSString *)type {
    if ([type isEqualToString:@"普通"]) {
        return @"1";
    }
    else if ([type isEqualToString:@"专家"]) {
        return @"2";
    }
    else if ([type isEqualToString:@"特诊"]) {
        return @"3";
    }
    return @"0";
}

- (VisitDetailsModel *)parseDcScheduleModel:(NSInteger)row datas:(NSArray *)list {
    VisitDetailsModel *model = [VisitDetailsModel new];
    NSArray *titles = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    NSString *current = [NSString stringWithFormat:@"星期%@", titles[row]];
    model.week = current;
    model.amType = @"0";
    model.amHospital = @"";
    model.pmType = @"0";
    model.pmHospital = @"";
    for (DcScheduleModel *loc in list) {
        for (DcScheduleWeekModel *week in loc.weeks) {
            if ([current isEqualToString:week.week]) {
                if (!model.isVisits) {
                    model.isVisits = YES;
                }
                model.week = current;
                for (DcScheduleItemModel *item in week.items) {
                    if ([@"上午" isEqualToString:item.visit_time]) {
                        model.amType = [self parseVisitType:item.clinc_type];
                        model.amHospital = loc.location;
                    }
                    else if ([@"下午" isEqualToString:item.visit_time]) {
                        model.pmType = [self parseVisitType:item.clinc_type];
                        model.pmHospital = loc.location;
                    }
                }
            }
        }
    }
    return model;
}

- (void)getDetails {
    
    @weakify(self);
    [[VisitDetailsViewModel new] drSchedules:^(NSArray *arr) {
        
        @strongify(self);
        if (!arr) {
            arr = [NSArray array];
        }
        NSArray *res = @[[self parseDcScheduleModel:0 datas:arr],
                         [self parseDcScheduleModel:1 datas:arr],
                         [self parseDcScheduleModel:2 datas:arr],
                         [self parseDcScheduleModel:3 datas:arr],
                         [self parseDcScheduleModel:4 datas:arr],
                         [self parseDcScheduleModel:5 datas:arr],
                         [self parseDcScheduleModel:6 datas:arr]];
        self.visitDetailsView.dataSources = @[res, @[@"管理分院区", @"出诊设置帮助"]];
        
    }];
}

- (void)saveDetails {
    
    @weakify(self);
    [[VisitDetailsViewModel new] saveWeekScheduleWithModel:self.visitDetailsView.dataSources Complete:^(id object) {
        
        @strongify(self);
        [self.view makeToast:object];
    }];
}

- (void)getHospitalList {
    
    @weakify(self);
    [[SortingAreaViewModel new] getHospitalListComplete:^(id object) {
        
        @strongify(self);
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < [object count]; i++) {
            
            SortingAreaModel *model = object[i];
            [arr addObject:model.text];
        }
        
        [arr insertObject:@"本院区" atIndex:0];
        self.visitDetailsView.hospitalList = arr;
    }];
}

- (void)getHelp {
    
    @weakify(self);
    [[VisitDetailsViewModel new] getHelpComplete:^(id object) {
        
        @strongify(self);
        self.visitDetailsView.helpBodyString = object;
        
    }];
}

@end
