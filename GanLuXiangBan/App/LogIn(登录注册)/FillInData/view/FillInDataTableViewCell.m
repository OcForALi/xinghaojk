//
//  FillInDataTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "FillInDataTableViewCell.h"

@implementation FillInDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

-(void)setModel:(FillInDataModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.titleName;
    
    self.messageTextField.textColor = RGB(202, 202, 202);
    
    self.messageTextField.text = model.placeholderString;
    
    if (model.messageString != nil) {
        
        self.messageTextField.textColor = RGB(51, 51, 51);
        
        self.messageTextField.text = model.messageString;
        
    }
    
}

-(void)setupUI{
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = RGB(51, 51, 51);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 17)
    .centerYEqualToView(self.contentView)
    .heightIs(15);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.messageTextField = [UILabel new];
    self.messageTextField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.messageTextField];
    
    self.messageTextField.sd_layout
    .rightSpaceToView(self.contentView, 17)
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.titleLabel, 15)
    .autoHeightRatio(0);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(202, 202, 202);
    [self.contentView addSubview:lineView];
    
    lineView.sd_layout
    .centerXEqualToView(self.messageTextField)
    .topSpaceToView(self.messageTextField, 4)
    .widthRatioToView(self.messageTextField, 1)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.messageTextField bottomMargin:20];
    
}

@end
