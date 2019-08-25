//
//  DocCircleFilterView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleFilterView.h"

#import "LHPickerDateView.h"

@interface DocCircleFilterView()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *endBtn;
@property (nonatomic, strong) UITextField *nameBox;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, strong) DocCircleFilterConfirm handleBlock;
@end

@implementation DocCircleFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame), 0, CGRectGetWidth(frame) - 50, CGRectGetHeight(frame))];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        
        UILabel *date = [self setupLabel:@"时间段"];
        date.sd_layout.topSpaceToView(self.mainView, 30).leftSpaceToView(self.mainView, 10).widthIs(80).heightIs(20);
        
        self.startBtn = [self setupButton:@"选择开始日期" tag:1];
        self.startBtn.sd_layout.topSpaceToView(date, 10).leftSpaceToView(self.mainView, 10).heightIs(34).widthRatioToView(self.mainView, 0.4);
        
        UILabel *sep = [self setupLabel:@"-"];
        sep.textAlignment = NSTextAlignmentCenter;
        sep.sd_layout.leftSpaceToView(self.startBtn, 10).widthIs(10).heightIs(20).centerYEqualToView(self.startBtn);
        
        self.endBtn = [self setupButton:@"选择开始日期" tag:2];
        self.endBtn.sd_layout.leftSpaceToView(sep, 10).heightRatioToView(self.startBtn, 1.0).widthRatioToView(self.startBtn, 1.0).centerYEqualToView(self.startBtn);
        
        UILabel *name = [self setupLabel:@"医生姓名"];
        name.sd_layout.topSpaceToView(self.startBtn, 30).leftEqualToView(date).widthIs(100).heightIs(20);
        
        self.nameBox = [[UITextField alloc] init];
        self.nameBox.layer.masksToBounds = YES;
        self.nameBox.layer.cornerRadius = 4;
        self.nameBox.layer.borderWidth = 1.0;
        self.nameBox.font = kFontRegular(14);
        self.nameBox.layer.borderColor = kPageBgColor.CGColor;
        self.nameBox.placeholder = @"请输入需要查找的医生姓名";
        self.nameBox.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.mainView addSubview:self.nameBox];
        self.nameBox.sd_layout.topSpaceToView(name, 10).leftSpaceToView(self.mainView, 10).rightEqualToView(self.endBtn).heightIs(34);
        
        UIButton *done = [self setupButton:@"确 定" tag:10];
        [done.titleLabel setFont:kFontMedium(18)];
        done.backgroundColor = kMainColor;
        [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        done.sd_layout.topSpaceToView(self.nameBox, 50).leftSpaceToView(self.mainView, 50).rightSpaceToView(self.mainView, 50).heightIs(50);
        
        self.alpha = 0.0;
    }
    return self;
}

- (void)showFilterView:(DocCircleFilterConfirm)block {
    self.handleBlock = block;
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.left = 50;
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
    }];
}

- (void)touchChooseDate:(UIButton *)button {
    NSInteger tag = button.tag;
    if (tag == 1 || tag == 2) {
        WS(weakSelf)
        [LHPickerDateView showIn:self action:^(BOOL cancel, NSString *date) {
            if (date) {
                if (tag == 1) {
                    weakSelf.startDate = date;
                    [weakSelf.startBtn setTitle:date forState:UIControlStateNormal];
                }
                else {
                    weakSelf.endDate = date;
                    [weakSelf.endBtn setTitle:date forState:UIControlStateNormal];
                }
            }
        }];
    }
    else if (tag == 10) {
        if (self.handleBlock) {
            NSString *name = self.nameBox.text;
            self.handleBlock(self.startDate, self.endDate, name);
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.mainView.left = ScreenWidth;
        } completion:^(BOOL finished) {
            self.alpha = 0.0;
        }];
    }
}

- (UILabel *)setupLabel:(NSString *)txt {
    UILabel *label = [[UILabel alloc] init];
    label.text = txt;
    label.font = kFontRegular(14);
    label.textColor = kSixColor;
    [self.mainView addSubview:label];
    return label;
}

- (UIButton *)setupButton:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1.0;
    btn.tag = tag;
    btn.layer.borderColor = kPageBgColor.CGColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:kFontRegular(14)];
    [btn addTarget:self action:@selector(touchChooseDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
    return btn;
}

@end
