//
//  SelectPriceView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/26.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelectPriceView.h"

@interface SelectPriceView ()

@property (nonatomic, strong) UIView *stateView;
@property (nonatomic, assign) NSInteger row;

@end

@implementation SelectPriceView
@synthesize pickerView;
@synthesize stateView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.stateView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setPriceArr:(NSArray *)priceArr {
    
    _priceArr = priceArr;
    [self.pickerView reloadAllComponents];
}

- (void)setIsShowList:(BOOL)isShowList {
    
    _isShowList = isShowList;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3 * isShowList];
        self.pickerView.alpha = isShowList;
        self.pickerView.y = self.height - self.pickerView.height * isShowList;
        
        self.stateView.alpha = isShowList;
        self.stateView.y = self.pickerView.y - 50;
        
    } completion:^(BOOL finished) {
        
        if (!isShowList) {
            self.hidden = YES;
        }
    }];
}

#pragma mark - lazy
- (UIView *)stateView {
    
    if (!stateView) {
        
        stateView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50)];
        stateView.y = self.pickerView.y - 50;
        stateView.alpha = 0;
        [self addSubview:stateView];
        
        for (int i = 0; i < 2; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = kPageBgColor;
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            button.frame = CGRectMake(10, 10, 40, 30);
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"0x333333"] forState:UIControlStateNormal];
            [stateView addSubview:button];
            
            if (i == 1) {
                
                button.x = ScreenWidth - 50;
                button.backgroundColor = kMainColor;
                [button setTitle:@"确定" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
               
                if (i == 0) {
                    
                    self.isShowList = NO;
                }
                else {
                    
                    if (self.didTextStringBlock) {
                        self.didTextStringBlock(self.priceArr[self.row]);
                    }
                    else if (self.didIndexTextBlock) {
                        self.didIndexTextBlock(self.row, self.priceArr[self.row]);
                    }
                }
                
            }];
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, stateView.height - 0.5, ScreenWidth, 0.5)];
        lineView.backgroundColor = kLineColor;
        [stateView addSubview:lineView];
    }
    
    return stateView;
}

- (UIPickerView *)pickerView {
    
    if (!pickerView) {
        
        pickerView = [[UIPickerView alloc] init];
        pickerView.frame = CGRectMake(0, self.height, self.width, 216);
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.alpha = 0;
        [self addSubview:pickerView];
    }
    
    return pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.priceArr.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.priceArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    self.row = row;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.isShowList = !self.isShowList;
}

@end
