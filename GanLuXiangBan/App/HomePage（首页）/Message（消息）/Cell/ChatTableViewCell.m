//
//  ChatTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupUI];
        
    }
    
    return self;
}

-(void)setModel:(ChatModel *)model{
    
    _model = model;
    
    NSLog(@"%@",model.rcd_contents);
    
    self.exportTextLabel.text = model.rcd_contents;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    
    if ([_model.user_type integerValue] == 0) {

        self.exportTextLabel.textColor = [UIColor blackColor];
        
        self.iconImageView.sd_resetLayout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightEqualToWidth();
        
        self.exportTextLabel.sd_resetLayout
        .leftSpaceToView(self.iconImageView, 25)
        .topSpaceToView(self.contentView, 20)
        .autoHeightRatio(0);
        [self.exportTextLabel setSingleLineAutoResizeWithMaxWidth:(ScreenWidth*0.6)];
        
        self.contentBackView.layer.sublayers = nil;
        
        self.contentBackView.sd_resetLayout
        .leftSpaceToView(self.iconImageView, 15)
        .widthIs(self.exportTextLabel.width+20)
        .topSpaceToView(self.contentView, 10)
        .heightIs(self.exportTextLabel.height+20);
        
        @weakify(self)
        self.contentBackView.didFinishAutoLayoutBlock = ^(CGRect frame) {
            @strongify(self)
            
            CGPoint point1 = CGPointMake(0, 0);
            CGPoint point2 = CGPointMake(0, 10);
            CGPoint point3 = CGPointMake(0 - 5, 15);
            CGPoint point4 = CGPointMake(0 , 20);
            CGPoint point5 = CGPointMake(0, frame.size.height);
            CGPoint point6 = CGPointMake(frame.size.width, frame.size.height);
            CGPoint point7 = CGPointMake(frame.size.width, 0);
            CGPoint point8 = CGPointMake(0, 0);
            
            self.path = [UIBezierPath bezierPath];
            [self.path moveToPoint:point1];//移动到某个点，也就是起始点
            [self.path addLineToPoint:point2];
            [self.path addLineToPoint:point3];
            [self.path addLineToPoint:point4];
            [self.path addLineToPoint:point5];
            [self.path addLineToPoint:point6];
            [self.path addLineToPoint:point7];
            [self.path addLineToPoint:point8];
            
            CAShapeLayer *shapeLayer=[CAShapeLayer layer];
            shapeLayer.path = self.path.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            shapeLayer.strokeColor=RGB(237, 237, 237).CGColor;//边框颜色
            shapeLayer.lineWidth = 1;
            shapeLayer.cornerRadius = 5;
            [self.contentBackView.layer addSublayer:shapeLayer];
            
        };
        
    }else if([_model.user_type integerValue] == 1){
        
        _exportTextLabel.textColor = [UIColor blackColor];
        
        self.iconImageView.sd_resetLayout
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightEqualToWidth();
        
        _exportTextLabel.sd_resetLayout
        .rightSpaceToView(self.iconImageView, 25)
        .topSpaceToView(self.contentView, 20)
        .autoHeightRatio(0);
        [_exportTextLabel setSingleLineAutoResizeWithMaxWidth:(ScreenWidth*0.6)];
        
        self.contentBackView.layer.sublayers = nil;
        
        self.contentBackView.sd_resetLayout
        .rightSpaceToView(self.iconImageView, 15)
        .widthIs(_exportTextLabel.width+20)
        .topSpaceToView(self.contentView, 10)
        .heightIs(_exportTextLabel.height+20);
        
        @weakify(self)
        self.contentBackView.didFinishAutoLayoutBlock = ^(CGRect frame) {
            @strongify(self)
            
            CGPoint point1 = CGPointMake(0, 0);
            CGPoint point2 = CGPointMake(frame.size.width, 0);
            CGPoint point3 = CGPointMake(frame.size.width, 10);
            CGPoint point4 = CGPointMake(frame.size.width + 5, 15);
            CGPoint point5 = CGPointMake(frame.size.width , 20);
            CGPoint point6 = CGPointMake(frame.size.width, frame.size.height);
            CGPoint point7 = CGPointMake(0, frame.size.height);
            CGPoint point8 = CGPointMake(0, 0);
            
            self.path = [UIBezierPath bezierPath];
            [self.path moveToPoint:point1];//移动到某个点，也就是起始点
            [self.path addLineToPoint:point2];
            [self.path addLineToPoint:point3];
            [self.path addLineToPoint:point4];
            [self.path addLineToPoint:point5];
            [self.path addLineToPoint:point6];
            [self.path addLineToPoint:point7];
            [self.path addLineToPoint:point8];

            CAShapeLayer *shapeLayer=[CAShapeLayer layer];
            shapeLayer.path = self.path.CGPath;
            shapeLayer.fillColor = RGB(200, 209, 254).CGColor;
            shapeLayer.strokeColor=RGB(237, 237, 237).CGColor;//边框颜色
            shapeLayer.lineWidth = 1;
            shapeLayer.cornerRadius = 5;
            [self.contentBackView.layer addSublayer:shapeLayer];
            
        };
        
    }

}

-(void)setupUI{

    self.iconImageView = [UIImageView new];
    self.iconImageView.layer.cornerRadius = 20;
    self.iconImageView.layer.masksToBounds = YES;
//    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.exportTextLabel = [UILabel new];
    self.exportTextLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.exportTextLabel];
    
    self.exportTextLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 25)
    .topSpaceToView(self.contentView, 20)
    .autoHeightRatio(0);
    [self.exportTextLabel setSingleLineAutoResizeWithMaxWidth:(ScreenWidth*0.6)];
    
    self.contentBackView = [UIView new];
    [self.contentView addSubview:self.contentBackView];
    
    self.contentBackView.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(self.exportTextLabel.width+20)
    .topSpaceToView(self.contentView, 10)
    .heightIs(self.exportTextLabel.height);
    
    @weakify(self)
    self.exportTextLabel.didFinishAutoLayoutBlock = ^(CGRect frame) {
        @strongify(self)
        self.contentBackView.sd_layout
        .leftSpaceToView(self.iconImageView, 15)
        .widthIs(self.exportTextLabel.width+20)
        .topSpaceToView(self.contentView, 10)
        .heightIs(frame.size.height+20);
    };
    
    [self.contentView bringSubviewToFront:self.exportTextLabel];
    
    [self setupAutoHeightWithBottomView:self.exportTextLabel bottomMargin:15];
    
}

@end
