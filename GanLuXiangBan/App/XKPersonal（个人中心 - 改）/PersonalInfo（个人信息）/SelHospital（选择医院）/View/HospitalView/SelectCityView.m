//
//  SelectCityView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelectCityView.h"

@implementation SelectCityView
@synthesize pickerView;

- (UIPickerView *)pickerView {
    
    if (!pickerView) {
        
        pickerView = [UIPickerView new];
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.showsSelectionIndicator = YES;
        [self addSubview:pickerView];
        
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(ScreenHeight / 3));
        }];
    }
    
    return pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
    if (component == 0) {
        return self.citys.count;
    }
    else {
        return self.citys.count;
    }
}

@end
