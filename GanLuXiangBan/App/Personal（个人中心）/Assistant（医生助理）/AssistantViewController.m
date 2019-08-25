//
//  AssistantViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AssistantViewController.h"

@interface AssistantViewController ()

@end

@implementation AssistantViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth - 30, 15)];
    titleLabel.text = [NSString stringWithFormat:@"尊敬的医生，欢迎您使用%@", App_Name];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.height = [titleLabel getTextHeight];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 15, ScreenWidth - 30, 200)];
    introduceLabel.text = [NSString stringWithFormat:@"目前%@暂不开通在线留言服务，如有疑问，请点击下方 “联系助理”，直接电话联系助理，谢谢", App_Name];
    introduceLabel.font = [UIFont systemFontOfSize:14];
    introduceLabel.height = [introduceLabel getTextHeight];
    introduceLabel.textColor = [UIColor blackColor];
    introduceLabel.numberOfLines = 0;
    [self.view addSubview:introduceLabel];
    
    UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callBtn.frame = CGRectMake(0, self.view.height - 50 - self.navHeight, ScreenWidth, 50);
    callBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    callBtn.backgroundColor = kMainColor;
    [callBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:callBtn];
    
    @weakify(self);
    [[callBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        NSString *titleString = @"助理上班时间：7 * 8小时\n(09:00 - 18:00)";
        [self alertWithTitle:titleString msg:@"020-81978876" isShowCancel:YES complete:^{
            
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"020-81978876"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
    }];
}

@end
