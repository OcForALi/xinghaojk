//
//  TrendView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TrendView.h"
#import "TrendTypeView.h"
#import "TrendLineChart.h"
#import "CheckListDetailsModel.h"

@interface TrendView ()

@property (nonatomic, strong) TrendTypeView *trendTypeView;
@property (nonatomic, strong) TrendLineChart *trendLineChart;

@end

@implementation TrendView
@synthesize trendTypeView;
@synthesize trendLineChart;

#pragma mark - set

- (NSString *)parseDemoName:(NSString *)code {
    if (self.items) {
        for (CheckDemoModel *demo in self.items) {
            if ([code isEqualToString:demo.chk_item_code]) {
                return demo.chk_item;
            }
        }
    }
    return code;
}

- (void)setModel:(TrendModel *)model {
    
    _model = model;
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *charts = [NSMutableArray array];
    for (TrendItemsModel *itemModel in model.items) {
        NSString *name = [self parseDemoName:itemModel.chk_demo_name];
        [arr addObject:name];
        
        NSMutableArray *numbers = [NSMutableArray array];
        for (NSString *number in itemModel.chk_values) {
//            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//            [formatter setMaximumIntegerDigits:2];
            [numbers addObject:number];
        }
        
        [charts addObject:AAObject(AASeriesElement).nameSet(name).dataSet(numbers)];
    }
    
    self.trendLineChart.dates = self.model.dates;
    self.trendLineChart.charts = charts;
    self.trendTypeView.types = arr;
    CGFloat fiveHeight = self.trendTypeView.fiveHeight;
    if (fiveHeight > 0) {
        self.trendTypeView.height = fiveHeight;
        self.trendLineChart.y = fiveHeight + 15;
    }
}


#pragma mark - lazy
- (TrendTypeView *)trendTypeView {
    
    if (!trendTypeView) {
        
        trendTypeView = [[TrendTypeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
        [self addSubview:trendTypeView];
    }
    
    return trendTypeView;
}

- (TrendLineChart *)trendLineChart {
    
    if (!trendLineChart) {
        
        trendLineChart = [[TrendLineChart alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 70)];
        trendLineChart.backgroundColor = [UIColor whiteColor];
        [self addSubview:trendLineChart];
    }
    
    return trendLineChart;
}

@end
