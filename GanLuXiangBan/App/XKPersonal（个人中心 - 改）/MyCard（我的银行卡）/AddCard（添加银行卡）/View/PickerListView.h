//
//  PickerListView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerListView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) BOOL isShowList;

#pragma mark - Block
@property (nonatomic, strong) void (^didTextStringBlock)(NSString *textString);

@end
