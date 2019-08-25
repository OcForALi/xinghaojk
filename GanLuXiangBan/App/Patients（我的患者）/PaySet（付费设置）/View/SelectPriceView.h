//
//  SelectPriceView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/26.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPriceView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *priceArr;
@property (nonatomic, assign) BOOL isShowList;

#pragma mark - Block
@property (nonatomic, strong) void (^didTextStringBlock)(NSString *textString);
@property (nonatomic, strong) void (^didIndexTextBlock)(NSInteger index, NSString *textString);

@end
