//
//  SortView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    self.sort = 0;
    
    self.isDesc = YES;
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = RGB(241, 241, 241);
    [self addSubview:topLine];
    
    topLine.sd_layout
    .topSpaceToView(self, 0)
    .widthIs(ScreenWidth)
    .heightIs(0.5)
    .centerXEqualToView(self);
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = RGB(241, 241, 241);
    [self addSubview:bottomLine];
    
    bottomLine.sd_layout
    .bottomSpaceToView(self, 0)
    .widthIs(ScreenWidth)
    .heightIs(0.5)
    .centerXEqualToView(self);
    
    NSArray *array = @[@"默认",@"价格",@"销量"];
    
    for (int i = 0; i < array.count; i++) {
        
        UIView *view = [UIView new];
        view.userInteractionEnabled = YES;
        view.tag = i+100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        
        view.sd_layout
        .leftSpaceToView(self, 0 + i * (ScreenWidth/3))
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .widthIs(ScreenWidth/3);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = RGB(241, 241, 241);
        [view addSubview:lineView];
        
        lineView.sd_layout
        .rightSpaceToView(view, -1)
        .topSpaceToView(view, 2)
        .bottomSpaceToView(view, 2)
        .widthIs(1);
        
        UILabel *label = [UILabel new];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = i + 1000;
        [view addSubview:label];
        
        label.sd_layout
        .centerXEqualToView(view)
        .centerYEqualToView(view)
        .heightIs(14);
        [label setSingleLineAutoResizeWithMaxWidth:150];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@""];
        imageView.hidden = YES;
        imageView.tag = i + 1000;
        [view addSubview:imageView];
        
        imageView.sd_layout
        .leftSpaceToView(label, 5)
        .centerYEqualToView(label)
        .widthIs(14)
        .heightEqualToWidth();
        
        if (self.sort == i) {
            label.textColor = kMainColor;
            imageView.hidden = NO;
        }

    }
    
}

-(void)tap:(UITapGestureRecognizer *)sender{
    
    NSInteger tagInteger = sender.view.tag - 100;
    
    if (tagInteger == self.sort) {
        
        if (self.isDesc == NO) {
            self.isDesc = YES;
        }else{
            self.isDesc = NO;
        }
        
    }else{
        
        self.isDesc = YES;
        self.sort = tagInteger;
        
    }
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [self viewWithTag:i+1000];
        label.textColor = [UIColor blackColor];
        
        UIImageView *imageView = [self viewWithTag:i+10000];
        imageView.hidden = YES;
        if (self.sort == i) {
            label.textColor = kMainColor;
            imageView.hidden = NO;
        }
        
    }
    
    if (self.sortBlock) {
        self.sortBlock(self.sort, self.isDesc);
    }
    
}

@end
