//
//  LHPickerDateView.m
//  Seabuy
//
//  Created by Bruthlee on 2019/7/14.
//  Copyright © 2019 Brother Co.,Ltd. All rights reserved. All rights reserved.
//

#import "LHPickerDateView.h"

@interface LHPickerDateView()
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) PickerDateViewBlock pickBlock;
@end

@implementation LHPickerDateView

+ (void)showIn:(UIView *)parentView action:(PickerDateViewBlock)action {
    LHPickerDateView *view = [[LHPickerDateView alloc] initWithFrame:parentView.bounds];
    [parentView addSubview:view];
    view.pickBlock = action;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initPickerView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPickerView];
    }
    return self;
}

- (void)touchCancelPicker {
    if (self.pickBlock) {
        self.pickBlock(YES, nil);
    }
    [self removeFromSuperview];
}

- (void)touchConfirmPicker {
    if (self.pickBlock) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSString *res = [formatter stringFromDate:self.datePicker.date];
        self.pickBlock(NO, res);
    }
    [self removeFromSuperview];
}

- (void)initPickerView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self addSubview:self.datePicker];
    self.datePicker.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(240);
    
    self.toolbar = [[UIToolbar alloc] init];
    [self addSubview:self.toolbar];
    self.toolbar.sd_layout.bottomSpaceToView(self.datePicker, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(50);
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(touchCancelPicker)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.7, 24)];
    label.text = @"选择时间";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontRegular(16);
    label.textColor = kNightColor;
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithCustomView:label];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(touchConfirmPicker)];
    self.toolbar.items = @[left, flex, right];
}

@end
