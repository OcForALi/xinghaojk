//
//  DrugListTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugListTableViewCell.h"

@implementation DrugListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setDrug_idArray:(NSArray *)drug_idArray{
    
    _drug_idArray = drug_idArray;
    
}

-(void)setType:(NSInteger)type{
    _type = type;
}

-(void)setModel:(DrugListModel *)model{
    
    _model = model;
    
    [self.drugImageView sd_setImageWithURL:[NSURL URLWithString:self.model.pic_path]];
    
    self.drugLabel.text = [NSString stringWithFormat:@"%@(%@)",self.model.drug_name,self.model.common_name];
    
    self.drugStandardLabel.text = self.model.standard;
    
    self.drugProducerLabel.text = self.model.producer;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.model.price];
    
    self.six_RaterLabel.text = [NSString stringWithFormat:@"小六指数：%ld",self.model.six_rate];
    
    if (self.type == 0) {
        
        if (model.fav_id == 0) {
            
            [self.collectButton setTitle:@"加入常用药" forState:UIControlStateNormal];
            [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
            
        }else{
            
            [self.collectButton setTitle:@"已加入常用药" forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: [UIColor grayColor]];
            [self.collectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
        }
        
        [self setupAutoHeightWithBottomView:self.collectButton bottomMargin:5];
        
    }else if (self.type == 1){
        
        self.collectButton.hidden = YES;
        
        self.selectedButton.hidden = YES;
        
        [self setupAutoHeightWithBottomView:self.six_RaterLabel bottomMargin:5];
        
        self.drugImageView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthEqualToHeight();
        
    }else if (self.type == 3){
        
        self.collectButton.hidden = YES;
        
        self.selectedButton.hidden = NO;
        
        if (model.isSelected == YES) {
            self.selectedButton.selected = YES;
        }else{
            self.selectedButton.selected = NO;
        }
        
        self.drugImageView.sd_resetLayout
        .leftSpaceToView(self.selectedButton, 15)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthEqualToHeight();
        
        [self setupAutoHeightWithBottomView:self.six_RaterLabel bottomMargin:5];
        
    } else{
        
        [self.collectButton setTitle:@"添加" forState:UIControlStateNormal];
        [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
        
        BOOL isAdd = [self.drug_idArray containsObject:model.drug_id];
        model.isAdded = isAdd;
        
        if (isAdd == YES) {
            
            [self.collectButton setTitle:@"已添加" forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: [UIColor grayColor]];
            [self.collectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
        }else{
            
            [self.collectButton setTitle:@"添加" forState:UIControlStateNormal];
            [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
            
        }

    }
}

-(void)setupUI {
    
    self.selectedButton = [UIButton new];
    [self.selectedButton setImage:[UIImage imageNamed:@"Home_NoSelected"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"Home_Selected"] forState:UIControlStateSelected];
    self.selectedButton.hidden = YES;
    [self.contentView addSubview:self.selectedButton];
    
    self.selectedButton.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .centerYEqualToView(self.contentView)
    .widthIs(30)
    .heightEqualToWidth();
    
    self.drugImageView = [UIImageView new];
    self.drugImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.drugImageView];
    
    self.drugImageView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .widthEqualToHeight();
    
    self.drugLabel = [UILabel new];
    self.drugLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.drugLabel];
    
    self.drugLabel.sd_layout
    .leftSpaceToView(self.drugImageView, 15)
    .topSpaceToView(self.contentView, 10)
    .heightIs(14);
    [self.drugLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    self.drugStandardLabel = [UILabel new];
    self.drugStandardLabel.font = [UIFont systemFontOfSize:12];
    self.drugStandardLabel.textColor = RGB(147, 147, 147);
    [self.contentView addSubview:self.drugStandardLabel];
    
    self.drugStandardLabel.sd_layout
    .leftSpaceToView(self.drugImageView, 15)
    .topSpaceToView(self.drugLabel, 10)
    .heightIs(12);
    [self.drugStandardLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.priceLabel];
    
    self.priceLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.drugStandardLabel)
    .heightIs(12);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.drugProducerLabel = [UILabel new];
    self.drugProducerLabel.font = [UIFont systemFontOfSize:12];
    self.drugProducerLabel.textColor = RGB(147, 147, 147);
    [self.contentView addSubview:self.drugProducerLabel];
    
    self.drugProducerLabel.sd_layout
    .leftSpaceToView(self.drugImageView, 15)
    .topSpaceToView(self.drugStandardLabel, 10)
    .heightIs(12);
    [self.drugProducerLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth*0.4];

    self.six_RaterLabel = [UILabel new];
    self.six_RaterLabel.font = [UIFont systemFontOfSize:12];
    self.six_RaterLabel.textColor = RGB(147, 147, 147);
    [self.contentView addSubview:self.six_RaterLabel];
    
    self.six_RaterLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.drugStandardLabel, 10)
    .heightIs(12);
    [self.six_RaterLabel setSingleLineAutoResizeWithMaxWidth:100];

    self.collectButton = [UIButton new];
    [self.collectButton setTitle:@"加入常用药" forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.collectButton.layer setMasksToBounds:YES];
    [self.collectButton.layer setCornerRadius:5.0];
    [self.contentView addSubview:self.collectButton];
    
    self.collectButton.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.six_RaterLabel, 10)
    .heightIs(30);
    [self.collectButton setupAutoSizeWithHorizontalPadding:20 buttonHeight:30];
    
    [self setupAutoHeightWithBottomView:self.collectButton bottomMargin:5];
    
}

@end
