//
//  RecDrugsTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecDrugsTableViewCell.h"

@implementation RecDrugsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(DrugDosageModel *)model{
    
    _model = model;
    
    self.drugNameLabel.text = [NSString stringWithFormat:@"%@、%@", @(self.tag+1), model.drug_name];
    
    if (model.dosage && model.dosage.length > 0) {
        self.usageLabel.text = model.dosage;
    }
    else {
        self.usageLabel.text = [NSString stringWithFormat:@"%@,%@,%@", model.use_cycle, model.use_num_name,self.model.use_type];
    }
    self.amountLabel.text = [NSString stringWithFormat:@"X%@",model.use_num];
    self.remarksLabel.hidden = YES;
//    BOOL flag = model.remark && model.remark.length > 0 && ![model.remark isEqualToString:@"(null)"];
//    if (flag) {
//        self.remarksLabel.text = model.remark;
//        [self setupAutoHeightWithBottomView:self.remarksLabel bottomMargin:10];
//    }
//    else {
//
//    }
    [self setupAutoHeightWithBottomView:self.usageLabel bottomMargin:10];
    
}

-(void)setupUI{
    
    self.compileLabel = [UILabel new];
    self.compileLabel.textColor = [UIColor orangeColor];
    self.compileLabel.font = [UIFont systemFontOfSize:14];
    self.compileLabel.text = @"编辑";
    self.compileLabel.textAlignment = NSTextAlignmentCenter;
    self.compileLabel.layer.borderWidth = 1;
    self.compileLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.contentView addSubview:self.compileLabel];
    
    self.compileLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(20);
    
    self.drugNameLabel = [UILabel new];
    self.drugNameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.drugNameLabel];
    
    self.drugNameLabel.sd_layout
    .leftSpaceToView(self.compileLabel, 15)
    .topSpaceToView(self.contentView, 15)
    .heightIs(16);
    [self.drugNameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.usageLabel = [UILabel new];
    self.usageLabel.font = [UIFont systemFontOfSize:14];
//    self.usageLabel.textColor = RGB(153, 153, 153);
    [self.contentView addSubview:self.usageLabel];
    
    self.usageLabel.sd_layout
    .leftSpaceToView(self.compileLabel, 15)
    .topSpaceToView(self.drugNameLabel, 10)
    .heightIs(14);
    [self.usageLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.remarksLabel = [UILabel new];
    self.remarksLabel.font = [UIFont systemFontOfSize:14];
    self.remarksLabel.textColor = RGB(153, 153, 153);
    [self.contentView addSubview:self.remarksLabel];
    
    self.remarksLabel.sd_layout
    .leftSpaceToView(self.compileLabel, 15)
    .topSpaceToView(self.usageLabel, 10)
    .widthRatioToView(self.contentView, 0.7)
    .heightIs(14);
    
    self.amountLabel = [UILabel new];
    self.amountLabel.textColor = [UIColor lightGrayColor];
    self.amountLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.amountLabel];
    
    self.amountLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.amountLabel setSingleLineAutoResizeWithMaxWidth:100];
    
}

@end
