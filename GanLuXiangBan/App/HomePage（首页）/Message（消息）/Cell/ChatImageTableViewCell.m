//
//  ChatImageTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatImageTableViewCell.h"

@implementation ChatImageTableViewCell

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
 
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:model.rcd_contents]];
    
    switch ([_model.user_type integerValue]) {
            
        case 0:{

            self.iconImageView.sd_resetLayout
            .leftSpaceToView(self.contentView, 15)
            .topSpaceToView(self.contentView, 10)
            .widthIs(40)
            .heightEqualToWidth();
            
            self.pictureImageView.sd_resetLayout
            .leftSpaceToView(self.iconImageView, 25)
            .topSpaceToView(self.contentView, 20)
            .widthIs(ScreenWidth * 0.65)
            .heightEqualToWidth();
            
            self.contentBackView.layer.sublayers = nil;
            
            self.contentBackView.sd_resetLayout
            .leftSpaceToView(self.iconImageView, 15)
            .widthIs(self.pictureImageView.width+20)
            .topSpaceToView(self.contentView, 10)
            .heightIs(self.pictureImageView.height+20);
            
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
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:point1];//移动到某个点，也就是起始点
                [path addLineToPoint:point2];
                [path addLineToPoint:point3];
                [path addLineToPoint:point4];
                [path addLineToPoint:point5];
                [path addLineToPoint:point6];
                [path addLineToPoint:point7];
                [path addLineToPoint:point8];
                
                CAShapeLayer *shapeLayer=[CAShapeLayer layer];
                shapeLayer.path = path.CGPath;
                shapeLayer.fillColor = [UIColor whiteColor].CGColor;
                shapeLayer.strokeColor=RGB(237, 237, 237).CGColor;//边框颜色
                shapeLayer.lineWidth = 1;
                shapeLayer.cornerRadius = 5;
                [self.contentBackView.layer addSublayer:shapeLayer];
                
            };
            
        }

            break;
            
        case 1:{

            self.iconImageView.sd_resetLayout
            .rightSpaceToView(self.contentView, 15)
            .topSpaceToView(self.contentView, 10)
            .widthIs(40)
            .heightEqualToWidth();
            
            self.pictureImageView.sd_resetLayout
            .rightSpaceToView(self.iconImageView, 25)
            .topSpaceToView(self.contentView, 20)
            .widthIs(ScreenWidth * 0.65)
            .heightEqualToWidth();
            
            self.contentBackView.layer.sublayers = nil;
            
            self.contentBackView.sd_resetLayout
            .rightSpaceToView(self.iconImageView, 15)
            .widthIs(self.pictureImageView.width+20)
            .topSpaceToView(self.contentView, 10)
            .heightIs(self.pictureImageView.height+20);
            
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
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:point1];//移动到某个点，也就是起始点
                [path addLineToPoint:point2];
                [path addLineToPoint:point3];
                [path addLineToPoint:point4];
                [path addLineToPoint:point5];
                [path addLineToPoint:point6];
                [path addLineToPoint:point7];
                [path addLineToPoint:point8];
                
                CAShapeLayer *shapeLayer=[CAShapeLayer layer];
                shapeLayer.path = path.CGPath;
                shapeLayer.fillColor = RGB(200, 209, 254).CGColor;
                shapeLayer.strokeColor=RGB(237, 237, 237).CGColor;//边框颜色
                shapeLayer.lineWidth = 1;
                shapeLayer.cornerRadius = 5;
                [self.contentBackView.layer addSublayer:shapeLayer];
                
            };
            
        }
            
            break;
            
        default:
            break;
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
    
    self.pictureImageView = [UIImageView new];
    self.pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.pictureImageView];
    
    self.pictureImageView.sd_layout
    .leftSpaceToView(self.iconImageView, 25)
    .topSpaceToView(self.contentView, 20)
    .widthIs(ScreenWidth * 0.65)
    .heightEqualToWidth();
    
    self.contentBackView = [UIView new];
    [self.contentView addSubview:self.contentBackView];
    
    self.contentBackView.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(self.pictureImageView.width+20)
    .topSpaceToView(self.contentView, 10)
    .heightIs(self.pictureImageView.height);
    
    @weakify(self)
    self.pictureImageView.didFinishAutoLayoutBlock = ^(CGRect frame) {
        @strongify(self)
        self.contentBackView.sd_layout
        .leftSpaceToView(self.iconImageView, 15)
        .widthIs(self.pictureImageView.width+20)
        .topSpaceToView(self.contentView, 10)
        .heightIs(frame.size.height+20);
        
    };
    
    [self.contentView bringSubviewToFront:self.pictureImageView];
    
    [self setupAutoHeightWithBottomView:self.pictureImageView bottomMargin:15];
    
}

@end
