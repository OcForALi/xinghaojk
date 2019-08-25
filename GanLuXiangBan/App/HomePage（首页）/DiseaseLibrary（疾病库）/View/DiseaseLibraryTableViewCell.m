//
//  DiseaseLibraryTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DiseaseLibraryTableViewCell.h"

@implementation DiseaseLibraryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setType:(NSInteger)type{
    _type = type;
}

-(void)setModel:(DiseaseLibraryModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.name;
    
    if (self.type == 0) {
        
        if (model.disease_id == 0) {
//            [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
        }
        else{
//            [self.collectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.collectButton setBackgroundColor: kNightColor];
        }
        
        self.nameLabel.sd_resetLayout
        .leftSpaceToView(self.contentView, 20)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
        
        [self setupAutoHeightWithBottomView:self.collectButton bottomMargin:5];
        
    }else if(self.type == 1){
        
        self.collectButton.hidden = YES;
        
        self.collectImage.hidden = YES;
        
        [self setupAutoHeightWithBottomView:self.nameLabel bottomMargin:10];
        
        self.nameLabel.sd_resetLayout
        .leftSpaceToView(self.contentView, 20)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
        
        [self setupAutoHeightWithBottomView:self.collectButton bottomMargin:5];
        
    }else{
        
        self.collectImage.hidden = NO;
        
        self.collectButton.hidden = YES;
        
        self.nameLabel.sd_resetLayout
        .leftSpaceToView(self.collectImage, 15)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
        
        [self setupAutoHeightWithBottomView:self.nameLabel bottomMargin:10];
        
    }
    
}

-(void)setupUI{
    
    self.collectImage = [UIImageView new];
    self.collectImage.image = [UIImage imageNamed:@"SortingAreaDeleteImg"];
    self.collectImage.contentMode = UIViewContentModeScaleAspectFit;
    self.collectImage.hidden = YES;
    [self.contentView addSubview:self.collectImage];
    
    self.collectImage.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .centerYEqualToView(self.contentView)
    .widthIs(20)
    .heightEqualToWidth();
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.collectButton = [UIButton new];
    [self.collectButton setTitle:@"加入常用疾病" forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectButton setBackgroundColor: RGB(255, 144, 0)];
    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.collectButton.layer setMasksToBounds:YES];
    [self.collectButton.layer setCornerRadius:5.0];
    [self.contentView addSubview:self.collectButton];
    
    self.collectButton.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(30);
    [self.collectButton setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
    
    [self setupAutoHeightWithBottomView:self.collectButton bottomMargin:10];
    
}

@end
