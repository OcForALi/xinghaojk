//
//  ProductExamineTableViewCell.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ProductExamineTableViewCell.h"

@implementation ProductExamineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = kPageBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(ProductModel *)model{
    
    _model = model;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    
    self.productNameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.drugNm,model.commonNm];
    
    self.specificationsLabel.text = model.spec;
    
    self.manufactorLabel.text = model.producer;
    
    self.priceLabel.text = model.price;
    
    self.noPassLabel.text = model.reason;
    
    if (model.noPassBool == YES) {
        self.reconsiderButton.hidden = NO;
    }else{
        self.reconsiderButton.hidden = YES;
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
    
    
    self.noPassLabel = [UILabel new];
    self.noPassLabel.font = [UIFont systemFontOfSize: 10];
    self.noPassLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.noPassLabel];
    
    self.noPassLabel.sd_layout
    .leftSpaceToView(self.productImageView, 10)
    .topSpaceToView(self.priceLabel, 5)
    .heightIs(10);
    [self.noPassLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.reconsiderButton = [UIButton new];
    self.reconsiderButton.backgroundColor = kMainColor;
    self.reconsiderButton.layer.cornerRadius = 5;
    self.reconsiderButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.reconsiderButton setTitle:@"重新申请" forState:UIControlStateNormal];
    [self.reconsiderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.reconsiderButton];
    
    self.reconsiderButton.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(40);
    
    [self setupAutoHeightWithBottomView:self.productImageView bottomMargin:10];
    
}

@end
