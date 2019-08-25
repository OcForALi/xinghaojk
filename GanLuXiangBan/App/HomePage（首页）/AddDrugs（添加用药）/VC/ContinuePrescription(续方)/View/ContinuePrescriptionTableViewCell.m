//
//  ContinuePrescriptionTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/21.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ContinuePrescriptionTableViewCell.h"
#import "ChatDrugsModel.h"

@implementation ContinuePrescriptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

-(void)setModel:(ContinueModel *)model{
    
    _model = model;
    
    self.timeLabel.text = model.createtime;
    
    self.check_result.text = [NSString stringWithFormat:@"临床诊断： %@",model.check_result];
    
    if (model.items.count == 0) {
        
        [self setupAutoHeightWithBottomView:self.check_result bottomMargin:100];
        
    }else{
        
        self.BGView.sd_resetLayout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10)
        .heightIs(99 + model.items.count * 26);
        
        [self setupAutoHeightWithBottomView:self.BGView bottomMargin:10];
        
    }
    
    for (UILabel *label in self.BGView.subviews) {
        if ([label isKindOfClass:UILabel.class]) {
            if (label != self.OKLabel && label != self.check_result && label != self.RPLabel && label != self.timeLabel) {
                [label removeFromSuperview];
            }
        }
    }
    
    for (int i = 0; i < model.items.count; i++) {
        
        ChatDrugsModel *drugListModel = [ChatDrugsModel new];
        [drugListModel setValuesForKeysWithDictionary:model.items[i]];
        
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%@(%@)%@",drugListModel.drug_name,drugListModel.common_name, drugListModel.standard];
        label.font = [UIFont systemFontOfSize:13];
        [self.BGView addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self.BGView, 14)
        .topSpaceToView(self.check_result, 10 + i * 26)
        .heightIs(16);
        [label setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
        
        UILabel *qtyLabel = [UILabel new];
        qtyLabel.text = [NSString stringWithFormat:@"X%@",drugListModel.qty];
        qtyLabel.textColor = [UIColor lightGrayColor];
        qtyLabel.font = [UIFont systemFontOfSize:14];
        [self.BGView addSubview:qtyLabel];
        
        qtyLabel.sd_layout
        .rightSpaceToView(self.BGView, 10)
        .centerYEqualToView(label)
        .heightIs(14);
        [qtyLabel setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    
}

-(void)setupUI{
    
    self.BGView = [UIView new];
    self.BGView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.BGView];
    
    self.BGView.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10);
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = RGB(86, 164, 247);
    [self.BGView addSubview:blueView];
    
    blueView.sd_layout
    .leftSpaceToView(self.BGView, 0)
    .rightSpaceToView(self.BGView, 0)
    .topSpaceToView(self.BGView, 0)
    .heightIs(30);
    
    self.RPLabel = [UILabel new];
    self.RPLabel.text = @"Rp";
    self.RPLabel.font = [UIFont systemFontOfSize:20];
    self.RPLabel.textColor = [UIColor whiteColor];
    [blueView addSubview:self.RPLabel];
    
    self.RPLabel.sd_layout
    .leftSpaceToView(blueView, 10)
    .centerYEqualToView(blueView)
    .heightIs(20);
    [self.RPLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [blueView addSubview:self.timeLabel];
    
    self.timeLabel.sd_layout
    .rightSpaceToView(blueView, 10)
    .centerYEqualToView(blueView)
    .heightIs(14);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.check_result = [UILabel new];
    self.check_result.font = [UIFont systemFontOfSize:14];
    [self.BGView addSubview:self.check_result];
    
    self.check_result.sd_layout
    .leftSpaceToView(self.BGView, 10)
    .topSpaceToView(blueView, 10)
    .heightIs(14);
    [self.check_result setSingleLineAutoResizeWithMaxWidth:300];
    
    self.OKLabel = [UILabel new];
    self.OKLabel.textColor = RGB(86, 164, 247);
    self.OKLabel.font = [UIFont systemFontOfSize:16];
    self.OKLabel.textAlignment = NSTextAlignmentCenter;
    self.OKLabel.text = @"续方";
    [self.BGView addSubview:self.OKLabel];
    
    self.OKLabel.sd_layout
    .leftSpaceToView(self.BGView, 0)
    .rightSpaceToView(self.BGView, 0)
    .bottomSpaceToView(self.BGView, 0)
    .heightIs(30);
    
}

@end
