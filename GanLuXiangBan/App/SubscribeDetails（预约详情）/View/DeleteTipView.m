//
//  DeleteTipView.m
//  GanLuXiangBan
//
//  Created by M on 2018/7/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DeleteTipView.h"

@implementation DeleteTipView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UIView *tipBgview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 0)];
    tipBgview.backgroundColor = [UIColor whiteColor];
    tipBgview.clipsToBounds = YES;
    tipBgview.layer.cornerRadius = 5;
    tipBgview.layer.masksToBounds = YES;
    [self addSubview:tipBgview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, tipBgview.width, 15)];
    titleLabel.text = @"提示";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [tipBgview addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 10, tipBgview.width - 20, 0)];
    contentLabel.text = @"是否为患者“推荐用药”，点击“是”为患者添加用药，点击“否”直接结束当前询问";
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
    contentLabel.numberOfLines = 0;
    contentLabel.height = [contentLabel getTextHeight];
    [tipBgview addSubview:contentLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 15, tipBgview.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [tipBgview addSubview:lineView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame) + 15, tipBgview.width, 15)];
    tipLabel.text = @"温馨提示: ";
    tipLabel.font = [UIFont boldSystemFontOfSize:14];
    tipLabel.textColor = [UIColor blackColor];
    [tipBgview addSubview:tipLabel];
    
    UILabel *tipContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tipLabel.frame) + 10, tipBgview.width - 20, 15)];
    tipContentLabel.text = @"结束预约服务前，请先确认预约服务已完成或与患者协商一致，以免引起不必要的纠纷。";
    tipContentLabel.font = [UIFont systemFontOfSize:13];
    tipContentLabel.textColor = [UIColor redColor];
    tipContentLabel.numberOfLines = 0;
    tipContentLabel.height = [contentLabel getTextHeight];
    [tipBgview addSubview:tipContentLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipContentLabel.frame) + 15, tipBgview.width, 0.5)];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [tipBgview addSubview:lineView2];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(tipBgview.width / 2 * i, CGRectGetMaxY(lineView2.frame) + 1, tipBgview.width / 2, 45);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:i == 0 ? @"是" : @"否" forState:UIControlStateNormal];
        [button setTitleColor:i == 0 ? kMainColor : [UIColor blackColor] forState:UIControlStateNormal];
        [tipBgview addSubview:button];
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            if (i == 1 && self.exitBlock) {
                
                [self removeFromSuperview];
                self.exitBlock();
            }
            else if (self.goViewController) {
                self.goViewController();
            }
        }];
    }
    
    tipBgview.height = CGRectGetMaxY(lineView2.frame) + 45;
    tipBgview.centerY = self.centerY;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
