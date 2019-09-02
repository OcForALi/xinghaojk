//
//  ModifyViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ModifyViewController.h"

NSInteger const MAX_TXT_COUNT = 500;

@interface ModifyViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation ModifyViewController
@synthesize textView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    
    WS(weakSelf);
    [self addNavRightTitle:@"确认" complete:^{
        
        if ([weakSelf.textView.text containsString:@"<"] && [weakSelf.textView.text containsString:@"</"]) {
            
            [weakSelf.view makeToast:@"请不要输入特殊符号"];
        }
        else {
            
            weakSelf.completeBlock(weakSelf.textView.text);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)setupSubviews {
    
    // 提示文字
    NSString *tipString = @"请填写您的职称、经历以及医学相关荣誉等";
    tipString = [self.title isEqualToString:@"擅长"] ? @"请填写您擅长的领域、病种以及研究方向等" : tipString;
    
    // 背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 285)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    // 文本框背景
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, bgView.height - 50)];
    titleBgView.backgroundColor = kPageBgColor;
    titleBgView.layer.cornerRadius = 5;
    titleBgView.layer.masksToBounds = YES;
    titleBgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    titleBgView.layer.borderWidth = 0.5;
    [bgView addSubview:titleBgView];
    
    // 文本框
    int titleSpacing = 10;
    textView = [[UITextView alloc] initWithFrame:CGRectMake(titleSpacing, titleSpacing / 2, titleBgView.width - titleSpacing * 2, titleBgView.height - titleSpacing)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = titleBgView.backgroundColor;
    [titleBgView addSubview:textView];
    
    // 文本框提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.5, 8.5, textView.width, 15)];
    tipLabel.text = tipString;
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.numberOfLines = 0;
    tipLabel.height = [tipLabel getTextHeight];
    [textView addSubview:tipLabel];
    
    // 文本数量
    UILabel *textNumber = [[UILabel alloc] initWithFrame:CGRectMake(titleBgView.x, CGRectGetMaxY(titleBgView.frame) + 10, titleBgView.width, 15)];
    textNumber.text = [@"0/" stringByAppendingFormat:@"%@", @(MAX_TXT_COUNT)];
    textNumber.font = [UIFont systemFontOfSize:14];
    textNumber.textColor = kMainColor;
    textNumber.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:textNumber];
    
    // 线
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@0.5);
    }];
    
    if (self.contentString.length > 0) {
        self.textView.text = self.contentString;
    }
    
    // 监听文本框
    WS(weakSelf);
    [[textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        
        tipLabel.hidden = x.length > 0 ? YES : NO;
        if (x.length > MAX_TXT_COUNT) {
            weakSelf.textView.text = [x substringToIndex:MAX_TXT_COUNT];
        }
        
        textNumber.text = [NSString stringWithFormat:@"%zd/%@", weakSelf.textView.text.length, @(MAX_TXT_COUNT)];
    }];
    
}

@end
