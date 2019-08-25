//
//  KTextFeildView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "KTextFeildView.h"

@interface KTextFeildView ()


@end

@implementation KTextFeildView
@synthesize textView;
@synthesize tipLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    // 文本框
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 15)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor blackColor];
    [self addSubview:textView];
    
    // 文本框提示
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.5, 8.5, textView.width, 15)];
    tipLabel.text = @"文本框";
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.numberOfLines = 0;
    tipLabel.height = [tipLabel getTextHeight];
    [textView addSubview:tipLabel];
    
    // 文本数量
    UILabel *textNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.x, CGRectGetMaxY(self.textView.frame), self.width - 15, 15)];
    textNumber.text = @"0/200";
    textNumber.font = [UIFont systemFontOfSize:14];
    textNumber.textColor = kMainColor;
    textNumber.textAlignment = NSTextAlignmentRight;
    textNumber.backgroundColor = [UIColor whiteColor];
    [self addSubview:textNumber];
    
    // 监听文本框
    WS(weakSelf);
    [[textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        
        weakSelf.tipLabel.hidden = x.length > 0 ? YES : NO;
        if (x.length > 200) {
            weakSelf.textView.text = [x substringToIndex:200];
        }
        
        textNumber.text = [NSString stringWithFormat:@"%zd/200", weakSelf.textView.text.length];
    }];
}

- (void)setTipString:(NSString *)tipString {
    
    _tipString = tipString;
    tipLabel.text = tipString;
}

@end
