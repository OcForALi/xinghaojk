//
//  EndConsoleView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "EndConsoleView.h"

@interface EndConsoleView()
@property (nonatomic, strong) EndConsoleViewBlock endBlock;
@end

@implementation EndConsoleView

+ (void)show:(EndConsoleViewBlock)block {
    EndConsoleView *view = [[EndConsoleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.endBlock = block;
    [view show];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(touchHideConsoleView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        [self setupUI];
    }
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)touchHideConsoleView {
    self.endBlock = nil;
    [self removeFromSuperview];
}

- (void)touchButton:(UIButton *)button {
    if (self.endBlock) {
        NSInteger tag = button.tag;
        BOOL res = tag == 1;
        self.endBlock(res);
    }
    self.endBlock = nil;
    [self removeFromSuperview];
}

- (void)setupUI {
    UIView *main = [[UIView alloc] init];
    main.backgroundColor = [UIColor whiteColor];
    [self addSubview:main];
    main.sd_layout.leftSpaceToView(self, 20).rightSpaceToView(self, 20).centerYEqualToView(self);
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"提示";
    title.textColor = kMainTextColor;
    title.font = kFontRegular(16);
    title.textAlignment = NSTextAlignmentCenter;
    [main addSubview:title];
    title.sd_layout.topSpaceToView(main, 0).widthIs(50).heightIs(40).centerXEqualToView(main);
    
    UILabel *top = [[UILabel alloc] init];
    top.text = @"是否为患者“推荐用药”，点击“是”为患者添加用药，点击“否”直接结束当前咨询。";
    top.textColor = kMainTextColor;
    top.font = kFontRegular(14);
    [main addSubview:top];
    top.sd_layout.topSpaceToView(title, 0).leftSpaceToView(main, 14).rightSpaceToView(main, 8).autoHeightRatio(0);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    [main addSubview:line];
    line.sd_layout.topSpaceToView(top, 10).leftEqualToView(top).rightEqualToView(top).heightIs(0.6);
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"温馨提示：";
    tip.textColor = kMainTextColor;
    tip.font = kFontRegular(16);
    [main addSubview:tip];
    tip.sd_layout.topSpaceToView(line, 10).leftEqualToView(top).widthIs(80).heightIs(34);
    
    UILabel *bottom = [[UILabel alloc] init];
    bottom.text = @"结束预约服务前，请先确认预约服务已完成或与患者协商一致，以免引起不必要的纠纷。";
    bottom.textColor = KRedColor;
    bottom.font = kFontRegular(14);
    [main addSubview:bottom];
    bottom.sd_layout.topSpaceToView(tip, 0).leftEqualToView(top).rightEqualToView(top).autoHeightRatio(0);
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = kLineColor;
    [main addSubview:line1];
    line1.sd_layout.topSpaceToView(bottom, 10).leftSpaceToView(main, 0).rightSpaceToView(main, 0).heightIs(0.6);
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.tag = 1;
    [confirm setTitle:@"是" forState:UIControlStateNormal];
    [confirm setTitleColor:kMainColor forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [main addSubview:confirm];
    confirm.sd_layout.topSpaceToView(line1, 4).leftSpaceToView(main, 0).heightIs(40).widthRatioToView(main, 0.5);
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.tag = 2;
    [cancel setTitle:@"否" forState:UIControlStateNormal];
    [cancel setTitleColor:kMainTextColor forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [main addSubview:cancel];
    cancel.sd_layout.topEqualToView(confirm).rightSpaceToView(main, 0).heightIs(40).widthRatioToView(main, 0.5);
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = kLineColor;
    [main addSubview:line2];
    line2.sd_layout.topEqualToView(confirm).heightRatioToView(confirm, 1.0).widthIs(0.6).centerXEqualToView(main);
    
    [main setupAutoHeightWithBottomView:confirm bottomMargin:0];
}

@end
