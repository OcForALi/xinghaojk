//
//  BaseView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initNoMessageView];
        
    }
    
    return self;
    
}

-(void)initNoMessageView{
    
    self.NoMessageView = [UIView new];
    [self addSubview:self.NoMessageView];
    
    self.NoMessageView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"Public_NoMessage"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.NoMessageView addSubview:imageView];
    
    imageView.sd_layout
    .centerXEqualToView(self.NoMessageView)
    .centerYEqualToView(self.NoMessageView)
    .widthIs(ScreenWidth*0.24)
    .heightEqualToWidth();
    
    self.noMessageLabel = [UILabel new];
    self.noMessageLabel.text = @"您暂时没新消息";
    self.noMessageLabel.font = [UIFont systemFontOfSize:16];
    self.noMessageLabel.textColor = [UIColor lightGrayColor];
    [self.NoMessageView addSubview:self.noMessageLabel];
    
    self.noMessageLabel.sd_layout
    .centerXEqualToView(self.NoMessageView)
    .topSpaceToView(imageView, 15)
    .heightIs(16);
    [self.noMessageLabel setSingleLineAutoResizeWithMaxWidth:300];
    
}

@end
