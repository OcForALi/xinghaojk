//
//  TrendLineChart.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "TrendLineChart.h"

@interface TrendLineChart ()

@property (nonatomic, strong) AAChartView *aaChartView;

@end

@implementation TrendLineChart
@synthesize aaChartView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initChart];
    }
    
    return self;
}

- (void)initChart {
    
    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    
    // 圖表
    aaChartView = [[AAChartView alloc] init];
    aaChartView.frame = CGRectMake(0, 60, ScreenWidth, ScreenWidth);
    aaChartView.scrollEnabled = NO;
    [self addSubview:aaChartView];
}

- (void)setCharts:(NSArray *)charts {
    
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeSpline)
    .titleSet(@"趋势图")
    .categoriesSet(self.dates)
    .yAxisTitleSet(@"")
    .seriesSet(charts);
    [aaChartView aa_drawChartWithChartModel:aaChartModel];
}

@end
