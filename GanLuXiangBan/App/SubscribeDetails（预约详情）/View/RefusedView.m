

//
//  RefusedView.m
//  GanLuXiangBan
//
//  Created by M on 2018/7/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RefusedView.h"

@implementation RefusedView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UIView *tipBgview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 0)];
    tipBgview.backgroundColor = [UIColor colorWithHexString:@"0xf3f3f3"];
    tipBgview.clipsToBounds = YES;
    tipBgview.layer.cornerRadius = 5;
    tipBgview.layer.masksToBounds = YES;
    [self addSubview:tipBgview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, tipBgview.width, 15)];
    titleLabel.text = @"拒绝预约";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [tipBgview addSubview:titleLabel];
    
    UILabel *tipTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 20, 0, 15)];
    tipTitleLabel.text = @"审批原因: ";
    tipTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    tipTitleLabel.textColor = [UIColor blackColor];
    tipTitleLabel.width = [tipTitleLabel getTextWidth];
    [tipBgview addSubview:tipTitleLabel];
    
    // 文本框
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tipTitleLabel.frame) + 10, CGRectGetMaxY(titleLabel.frame) + 10, tipBgview.width, 80)];
    textView.width -= (textView.x + 10);
    textView.font = [UIFont systemFontOfSize:13];
    textView.textColor = [UIColor blackColor];
    [tipBgview addSubview:textView];
    
    // 文本框提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.5, 8.5, textView.width, 15)];
    tipLabel.text = @"请输入不通过的理由";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.numberOfLines = 0;
    tipLabel.height = [tipLabel getTextHeight];
    [textView addSubview:tipLabel];
    
    // 文本数量
    UILabel *textNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + 10, tipBgview.width - 10, 15)];
    textNumber.text = @"0/50";
    textNumber.font = [UIFont systemFontOfSize:12];
    textNumber.textColor = kMainColor;
    textNumber.textAlignment = NSTextAlignmentRight;
    [tipBgview addSubview:textNumber];
    
    // 监听文本框
    [[textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        
        tipLabel.hidden = x.length > 0 ? YES : NO;
        if (x.length > 50) {
            textView.text = [x substringToIndex:50];
        }
        
        textNumber.text = [NSString stringWithFormat:@"%zd/50", textView.text.length];
    }];
    
    // 审核按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(textNumber.frame) + 10, tipBgview.width, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"审核" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kMainColor];
    [tipBgview addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSString *txt = textView.text;
        if (txt && txt.length > 0) {
            [self removeFromSuperview];
            if (self.textBlock) {
                self.textBlock(textView.text);
            }
        }
        else {
            [self makeToast:@"请输入不通过的理由"];
        }
    }];
    
    tipBgview.height = CGRectGetMaxY(button.frame);
    tipBgview.centerY = self.centerY;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
