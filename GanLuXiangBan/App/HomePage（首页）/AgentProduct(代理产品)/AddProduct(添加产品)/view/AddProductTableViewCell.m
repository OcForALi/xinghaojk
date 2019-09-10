//
//  AddProductTableViewCell.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AddProductTableViewCell.h"

@implementation AddProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = kPageBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setModel:(DrugListModel *)model{
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.pic_path] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    
    self.productNameLabel.text = [NSString stringWithFormat:@"%@ + %@",model.drug_name,model.common_name];
    
    self.specificationsLabel.text = model.standard;
    
    self.manufactorLabel.text = model.producer;
    
    self.priceLabel.text = model.price;
    
    if (model.app_id == 0) {
        [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addButton.backgroundColor = kMainColor;
    }else{
        [self.addButton setTitle:@"已添加" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addButton.backgroundColor = [UIColor grayColor];
    }
    
}

- (void)setupUI{
    
    self.productImageView = [UIImageView new];
    self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.productImageView];
    
    self.productImageView.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 10)
    .heightIs(70)
    .widthEqualToHeight();
    
    
    self.productNameLabel = [UILabel new];
    self.productNameLabel.font = [UIFont systemFontOfSize: 14];
    [self.contentView addSubview:self.productNameLabel];
    
    self.productNameLabel.sd_layout
    .leftSpaceToView(self.productImageView, 10)
    .topSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [self.productNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.specificationsLabel = [UILabel new];
    self.specificationsLabel.font = [UIFont systemFontOfSize: 10];
    [self.contentView addSubview:self.specificationsLabel];
    
    self.specificationsLabel.sd_layout
    .leftSpaceToView(self.productImageView, 10)
    .topSpaceToView(self.productNameLabel, 5)
    .heightIs(10);
    [self.specificationsLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.manufactorLabel = [UILabel new];
    self.manufactorLabel.font = [UIFont systemFontOfSize: 10];
    [self.contentView addSubview:self.manufactorLabel];
    
    self.manufactorLabel.sd_layout
    .leftSpaceToView(self.productImageView, 10)
    .topSpaceToView(self.specificationsLabel, 5)
    .heightIs(10);
    [self.manufactorLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.priceLabel = [UILabel new];
    self.priceLabel.font = [UIFont systemFontOfSize: 10];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    
    self.priceLabel.sd_layout
    .leftSpaceToView(self.productImageView, 10)
    .topSpaceToView(self.manufactorLabel, 5)
    .heightIs(10);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.addButton = [UIButton new];
    self.addButton.backgroundColor = kMainColor;
    self.addButton.layer.cornerRadius = 5;
    self.addButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.addButton];
    
    self.addButton.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.productImageView, 0)
    .widthIs(70)
    .heightIs(25);
    
    [self setupAutoHeightWithBottomView:self.addButton bottomMargin:10];
    
    
}

@end
