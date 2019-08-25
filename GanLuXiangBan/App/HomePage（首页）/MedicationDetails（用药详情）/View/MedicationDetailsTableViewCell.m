//
//  MedicationDetailsTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MedicationDetailsTableViewCell.h"

@implementation MedicationDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(DrugDetailModel *)model{
    
    _model = model;
    
    NSString *name = model.drug_name;
    if (model.standard) {
        name = [name stringByAppendingFormat:@"(%@) x%@", model.standard, @(model.qty)];
    }
    self.drug_nameLabel.text = name;
    
    self.six_rateLabel.text = [NSString stringWithFormat:@"小六指数：%@",@(model.six_rate)];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
}

-(void)setupUI{
    
    self.drug_nameLabel = [UILabel new];
    self.drug_nameLabel.font = kFontRegular(16);
    [self.contentView addSubview:self.drug_nameLabel];
    
    self.drug_nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 10)
    .heightIs(18);
    [self.drug_nameLabel setSingleLineAutoResizeWithMaxWidth:350];
    
    self.six_rateLabel = [UILabel new];
    self.six_rateLabel.textColor = [UIColor lightGrayColor];
    self.six_rateLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.six_rateLabel];
    
    self.six_rateLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.drug_nameLabel, 10)
    .heightIs(14);
    [self.six_rateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
//    self.priceLabel.backgroundColor = [UIColor orangeColor];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.priceLabel];
    
    self.priceLabel.sd_layout
    .rightSpaceToView(self.contentView, 14)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
//    self.qtyLabel = [UILabel new];
//    self.qtyLabel.textColor = [UIColor lightGrayColor];
//    self.qtyLabel.font = [UIFont systemFontOfSize:14];
//    self.qtyLabel.hidden = YES;
//    [self.contentView addSubview:self.qtyLabel];
    
//    self.qtyLabel.sd_layout
//    .rightSpaceToView(self.contentView, 20)
//    .centerYEqualToView(self.contentView)
//    .heightIs(14);
//    [self.qtyLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

@end
