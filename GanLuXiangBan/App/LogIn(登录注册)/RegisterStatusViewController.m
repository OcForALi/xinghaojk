//
//  RegisterStatusViewController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "RegisterStatusViewController.h"

@interface RegisterStatusViewController ()

@end

@implementation RegisterStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册提示";
    
    UILabel *top = [[UILabel alloc] init];
    top.textColor = kMainTextColor;
    top.font = kFontRegular(15);
    top.textAlignment = NSTextAlignmentCenter;
    top.text = @"您的注册信息已成功提交，我们将尽快审核";
    top.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(34);
    }];
    UILabel *bottom = [[UILabel alloc] init];
    bottom.textColor = kMainTextColor;
    bottom.font = kFontRegular(15);
    bottom.textAlignment = NSTextAlignmentCenter;
    bottom.text = @"审核的结果将以短信的方式通知您，敬请留意!";
    bottom.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top.mas_bottom);
        make.left.right.height.equalTo(top);
    }];
}

@end
