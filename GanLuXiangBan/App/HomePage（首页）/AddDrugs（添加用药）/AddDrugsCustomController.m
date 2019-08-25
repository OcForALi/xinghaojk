//
//  AddDrugsCustomController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/29.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AddDrugsCustomController.h"

#import "AddCountView.h"
#import "AddDrugsRequest.h"
#import "CollectionPickerView.h"

@interface AddDrugsCustomController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textBox;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) AddCountView *addView;
@property (nonatomic, strong) BaseUseDuring *lastDuring;
@end

@implementation AddDrugsCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WS(weakSelf)
    [self addNavRightTitle:@"保存" complete:^{
        [weakSelf touchSave];
    }];
    
    if (self.pickerType == PickerTypeCycle) {
        self.lastDuring = [BaseUseDuring new];
        self.lastDuring.name = @"天";
        self.title = @"自定义周期";
        [self setupCycle];
    }
    else if (self.pickerType == PickerTypeNum) {
        self.lastDuring = [BaseUseDuring new];
        self.lastDuring.name = @"天";
        self.title = @"自定义用量";
        [self setupNum];
    }
    else {
        self.title = self.pickerType == PickerTypeInfo ? @"自定义用法" : @"自定义单位";
        [self setupBox];
    }
}

- (void)touchSave {
    if (self.pickerType == PickerTypeNum) {
        BaseUseNumItem *item = [BaseUseNumItem new];
        item.frequency_num = self.addView.addCountString;
        item.frequency_cycle = self.lastDuring.name;
        item.use_num_name = [NSString stringWithFormat:@"每%@%@次",item.frequency_cycle, item.frequency_num];
        item.frequency = item.frequency_num;
        WS(weakSelf)
        [[AddDrugsRequest new] saveBaseUseNum:item complete:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (model.retmsg) {
                [weakSelf.view makeToast:model.retmsg];
            }
        }];
    }
    else if (self.pickerType == PickerTypeUnit) {
        NSString *txt = self.textBox.text;
        if (!txt || txt.length == 0) {
            [self.view makeToast:self.textBox.placeholder];
            return;
        }
        [self.view endEditing:YES];
        
        BaseUnitMinItem *item = [BaseUnitMinItem new];
        item.minunitname = txt;
        WS(weakSelf)
        [[AddDrugsRequest new] saveBaseUnitMin:item complete:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (model.retmsg) {
                [weakSelf.view makeToast:model.retmsg];
            }
        }];
    }
    else if (self.pickerType == PickerTypeCycle) {
        BaseUseCycleItem *item = [BaseUseCycleItem new];
        item.days = self.addView.addCountString;
        item.name = [NSString stringWithFormat:@"%@%@",item.days, self.lastDuring.name];
        WS(weakSelf)
        [[AddDrugsRequest new] saveBaseUseCycle:item complete:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (model.retmsg) {
                [weakSelf.view makeToast:model.retmsg];
            }
        }];
    }
    else if (self.pickerType == PickerTypeInfo) {
        NSString *txt = self.textBox.text;
        if (!txt || txt.length == 0) {
            [self.view makeToast:self.textBox.placeholder];
            return;
        }
        [self.view endEditing:YES];
        
        BaseUseInfoItem *item = [BaseUseInfoItem new];
        item.use_name = txt;
        WS(weakSelf)
        [[AddDrugsRequest new] saveBaseUseInfo:item complete:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (model.retmsg) {
                [weakSelf.view makeToast:model.retmsg];
            }
        }];
    }
}

- (void)touchChooseDuring {
    WS(weakSelf)
    [CollectionPickerView show:PickerTypeDuring lastModel:self.lastDuring complete:^(PickerAction action, id model) {
        if (action == PickerActionConfirm && model) {
            weakSelf.lastDuring = model;
            weakSelf.addLabel.text = weakSelf.lastDuring.name;
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text && textField.text.length > 0) {
        [self touchSave];
    }
    return YES;
}

- (void)setupBox {
    self.textBox = [[UITextField alloc] init];
    self.textBox.borderStyle = UITextBorderStyleRoundedRect;
    self.textBox.font = kFontRegular(14);
    self.textBox.textAlignment = NSTextAlignmentCenter;
    self.textBox.textColor = kMainTextColor;
    self.textBox.placeholder = self.pickerType == PickerTypeUnit ? @"请输入单位名称" : @"请输入用法";
    self.textBox.delegate = self;
    self.textBox.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textBox];
    self.textBox.sd_layout.topSpaceToView(self.view, 25).leftSpaceToView(self.view, 20).rightSpaceToView(self.view, 20).heightIs(50);
}

- (void)setupNum {
    UILabel *label = [UILabel new];
    label.text = @"每";
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    label.sd_layout.leftSpaceToView(self.view, 15).topSpaceToView(self.view, 25).widthIs(25).heightIs(20);
    
    CGFloat width = (ScreenWidth-120)/2;
    
    UIView *view = [UIView new];
    view.layer.borderWidth = 1;
    view.layer.borderColor = RGB(237, 237, 237).CGColor;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *use_typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchChooseDuring)];
    [view addGestureRecognizer:use_typeTap];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(label, 15).centerYEqualToView(label).widthIs(width).heightIs(30);
    
    self.addLabel = [UILabel new];
    self.addLabel.text = self.lastDuring.name;
    self.addLabel.textAlignment = NSTextAlignmentCenter;
    self.addLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:self.addLabel];
    self.addLabel.sd_layout.leftSpaceToView(view, 10).rightSpaceToView(view, 10).centerYEqualToView(view).heightIs(20);
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"SubscriptImg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    imageView.sd_layout.rightSpaceToView(view, 5).centerYEqualToView(view).widthIs(12).heightEqualToWidth();
    
    self.addView = [AddCountView new];
    self.addView.addCountString = @"1";
    [self.view addSubview:self.addView];
    self.addView.sd_layout.leftSpaceToView(view, 20).centerYEqualToView(view).widthIs(width).heightIs(30);
    
    UILabel *num = [UILabel new];
    num.text = @"次";
    num.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:num];
    num.sd_layout.rightSpaceToView(self.view, 15).centerYEqualToView(view).widthIs(25).heightIs(20);
    
    [self setupBlock];
}

- (void)setupCycle {
    CGFloat width = (ScreenWidth-50)/2;
    
    self.addView = [AddCountView new];
    self.addView.addCountString = @"1";
    [self.view addSubview:self.addView];
    self.addView.sd_layout.leftSpaceToView(self.view, 15).topSpaceToView(self.view, 25).widthIs(width).heightIs(30);
    
    UIView *view = [UIView new];
    view.layer.borderWidth = 1;
    view.layer.borderColor = RGB(237, 237, 237).CGColor;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *use_typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchChooseDuring)];
    [view addGestureRecognizer:use_typeTap];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(self.addView, 20).topEqualToView(self.addView).widthIs(width).heightRatioToView(self.addView, 1.0);
    
    self.addLabel = [UILabel new];
    self.addLabel.text = self.lastDuring.name;
    self.addLabel.textAlignment = NSTextAlignmentCenter;
    self.addLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:self.addLabel];
    self.addLabel.sd_layout.leftSpaceToView(view, 10).rightSpaceToView(view, 10).centerYEqualToView(view).heightIs(20);
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"SubscriptImg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    imageView.sd_layout.rightSpaceToView(view, 5).centerYEqualToView(view).widthIs(12).heightEqualToWidth();
    
    [self setupBlock];
}

- (void)setupBlock {
    WS(weakSelf)
    self.addView.addBlock = ^(NSString *add) {
        NSInteger num = [add integerValue];
        num++;
        weakSelf.addView.addCountString = [NSString stringWithFormat:@"%@", @(num)];
    };
    
    self.addView.subtractBlock = ^(NSString *subtract) {
        NSInteger num = [subtract integerValue];
        if (num > 1) {
            num--;
            weakSelf.addView.addCountString = [NSString stringWithFormat:@"%@", @(num)];
        }
    };
}

@end
