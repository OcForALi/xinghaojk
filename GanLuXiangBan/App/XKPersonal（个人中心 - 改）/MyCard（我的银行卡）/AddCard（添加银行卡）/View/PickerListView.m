//
//  PickerListView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PickerListView.h"

@implementation PickerListView 
@synthesize pickerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    
    return self;
}

- (void)setIsShowList:(BOOL)isShowList {
    
    _isShowList = isShowList;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3 * isShowList];
        self.pickerView.alpha = isShowList;
        self.pickerView.y = self.height - self.pickerView.height * isShowList;
        
    } completion:^(BOOL finished) {
        
        if (!isShowList) {
            self.hidden = YES;
        }
    }];
}

- (void)setDataSource:(NSArray *)dataSource {
    
    _dataSource = dataSource;
    [self.pickerView reloadAllComponents];
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
    return self.dataSource.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (self.didTextStringBlock) {
        self.didTextStringBlock(self.dataSource[row]);
    }
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.isShowList = !self.isShowList;
}

@end
