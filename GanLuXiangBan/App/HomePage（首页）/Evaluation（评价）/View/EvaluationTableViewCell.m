//
//  EvaluationTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EvaluationTableViewCell.h"
#import "EvaluationRequest.h"

@implementation EvaluationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setModel:(EvaluationModel *)model{
    
    _model = model;
    
    [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:model.patient_head]];
    
    self.nameLabel.text = model.patient_name;
    
    self.contentLaebl.text = model.content;
    
    self.timeLabel.text = model.createtime;
    
    if (model.is_zs == 1) {
        self.zsImageView.hidden = NO;
        self.zsLabel.hidden = NO;
        self.zsLabel.text = [NSString stringWithFormat:@"+%@",model.zs_points];
    }
    
    for (int i = 0 ; i < [model.score integerValue]; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"collectionImg"];
        [imageView setTintColor:[UIColor redColor]];
        [self.contentView addSubview:imageView];
        
        imageView.sd_layout
        .leftSpaceToView(self.iamgeView, 15 + i * 20)
        .topSpaceToView(self.nameLabel, 5)
        .widthIs(14)
        .heightEqualToWidth();
        
    }
    
    if (model.content == nil) {
        
        [self setupAutoHeightWithBottomView:self.imageView bottomMargin:20];
        
    }else{
        
        [self setupAutoHeightWithBottomView:self.contentLaebl bottomMargin:20];
        
    }

}

-(void)setupUI{
    
    self.iamgeView = [UIImageView new];
    self.iamgeView.contentMode = UIViewContentModeScaleAspectFit;
    [self.iamgeView.layer setMasksToBounds:YES];
    [self.iamgeView.layer setCornerRadius:20.0];
    [self.contentView addSubview:self.iamgeView];
    
    self.iamgeView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iamgeView, 15)
    .topSpaceToView(self.contentView, 12)
    .heightIs(16);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLaebl = [UILabel new];
    self.contentLaebl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLaebl];
    
    self.contentLaebl.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.iamgeView, 15)
    .autoHeightRatio(0);
    
    self.zsImageView = [UIImageView new];
    self.zsImageView.image = [UIImage imageNamed:@"Home_Gift"];
    self.zsImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.zsImageView.hidden = YES;
    self.zsImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *zsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zs:)];
    [self.zsImageView addGestureRecognizer:zsTap];
    [self.contentView addSubview:self.zsImageView];
    
    self.zsImageView.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.iamgeView)
    .widthIs(30)
    .heightEqualToWidth();
    
    self.zsLabel = [UILabel new];
    self.zsLabel.font = [UIFont systemFontOfSize:12];
    self.zsLabel.hidden = YES;
    [self.contentView addSubview:self.zsLabel];
    
    self.zsLabel.sd_layout
    .centerXEqualToView(self.zsImageView)
    .topSpaceToView(self.zsImageView, 5)
    .heightIs(12);
    [self.zsLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    self.timeLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 5)
    .heightIs(12);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

-(void)zs:(UITapGestureRecognizer *)sender{
    
    WS(weakSelf);
    
    [[EvaluationRequest new]getDdmirationDetailID:self.model.id complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (genneralBackModel.retcode == 0) {
            [weakSelf evaluationDetails: genneralBackModel.data];
        }

    }];
    
}

-(void)evaluationDetails:(NSDictionary *)dict{
    
    self.evaluationDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.evaluationDetailsView.backgroundColor = RGBA(51, 51, 51, 0.7);
    self.evaluationDetailsView.userInteractionEnabled = YES;
    UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delete:)];
    [self.evaluationDetailsView addGestureRecognizer:deleteTap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.evaluationDetailsView];
    
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.evaluationDetailsView addSubview:whiteView];
    
    whiteView.sd_layout
    .leftSpaceToView(self.evaluationDetailsView, 50)
    .rightSpaceToView(self.evaluationDetailsView, 50)
    .centerYEqualToView(self.evaluationDetailsView)
    .heightIs(200);
    
    UIImageView *imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"icon"]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [whiteView addSubview:imageView];
    
    imageView.sd_layout
    .centerXEqualToView(whiteView)
    .topSpaceToView(whiteView, 20)
    .widthIs(70)
    .heightEqualToWidth();
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = [dict objectForKey:@"remark"];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [whiteView addSubview:titleLabel];
    
    titleLabel.sd_layout
    .centerXEqualToView(whiteView)
    .topSpaceToView(imageView, 15)
    .heightIs(16);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text =  [NSString stringWithFormat:@"收到%@积分",[dict objectForKey:@"point"]];
    subTitleLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:subTitleLabel];
    
    subTitleLabel.sd_layout
    .centerXEqualToView(whiteView)
    .topSpaceToView(titleLabel, 15)
    .heightIs(14);
    [subTitleLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    UILabel *encourageLaebl = [UILabel new];
    encourageLaebl.text = @"患者的小心意，希望医生继续加油！";
    encourageLaebl.font = [UIFont systemFontOfSize:16];
    encourageLaebl.textColor = [UIColor redColor];
    [whiteView addSubview:encourageLaebl];
    
    encourageLaebl.sd_layout
    .centerXEqualToView(whiteView)
    .topSpaceToView(subTitleLabel, 15)
    .heightIs(18);
    [encourageLaebl setSingleLineAutoResizeWithMaxWidth:280];
    
}

-(void)delete:(UITapGestureRecognizer *)sender{
    
    [self.evaluationDetailsView removeFromSuperview];
    
}

@end
