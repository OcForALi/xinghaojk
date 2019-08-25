//
//  QuickReplyTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "QuickReplyTableViewCell.h"

@implementation QuickReplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupUI];
        
    }
    
    return self;
}

-(void)setTypeInteger:(NSInteger)typeInteger{
    _typeInteger = typeInteger;
}

-(void)setModel:(QuickReplyModel *)model{
    
    _model = model;
    
    self.contentLabel.text = model.content;
    
    if (self.typeInteger == 1) {
        
        self.button.hidden = NO;
        
        self.contentLabel.sd_resetLayout
        .leftSpaceToView(self.button, 20)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.textLabel setSingleLineAutoResizeWithMaxWidth:200];
        
    }else{
        
        self.button.hidden = YES;
        
        self.contentLabel.sd_resetLayout
        .leftSpaceToView(self.contentView, 20)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.textLabel setSingleLineAutoResizeWithMaxWidth:200];
        
    }
    
}

-(void)setupUI{
    
    self.button = [UIButton new];
    [self.button setImage:[UIImage imageNamed:@"Home_Hollow"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"Login_Correct"] forState:UIControlStateSelected];
    self.button.hidden = YES;
    self.button.selected = NO;
    [self.contentView addSubview:self.button];
    
    self.button.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .widthIs(23)
    .heightIs(23);
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

@end
