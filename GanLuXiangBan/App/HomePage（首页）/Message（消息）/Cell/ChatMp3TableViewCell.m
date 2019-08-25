//
//  ChatMp3TableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatMp3TableViewCell.h"

@implementation ChatMp3TableViewCell

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
    
    switch ([_model.user_type integerValue]) {
            
        case 0:{

            self.iconImageView.sd_resetLayout
            .leftSpaceToView(self.contentView, 15)
            .topSpaceToView(self.contentView, 10)
            .widthIs(40)
            .heightEqualToWidth();
            
            self.PlayLabel.sd_resetLayout
            .leftSpaceToView(self.iconImageView, 25)
            .topSpaceToView(self.contentView, 20)
            .heightIs(14);
            [self.PlayLabel setSingleLineAutoResizeWithMaxWidth:200];
            
            self.contentBackView.layer.sublayers = nil;
            
            self.contentBackView.sd_resetLayout
            .leftSpaceToView(self.iconImageView, 15)
            .widthIs(self.PlayLabel.width+70)
            .topSpaceToView(self.contentView, 10)
            .heightIs(self.PlayLabel.height+20);
            
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
            
            self.PlayLabel.sd_resetLayout
            .rightSpaceToView(self.iconImageView, 55)
            .topSpaceToView(self.contentView, 20)
            .heightIs(14);
            [self.PlayLabel setSingleLineAutoResizeWithMaxWidth:200];
            
            self.contentBackView.layer.sublayers = nil;
            
            self.contentBackView.sd_resetLayout
            .rightSpaceToView(self.iconImageView, 15)
            .widthIs(self.PlayLabel.width+70)
            .topSpaceToView(self.contentView, 10)
            .heightIs(self.PlayLabel.height+20);
            
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
    
    self.PlayLabel = [UILabel new];
    self.PlayLabel.font = [UIFont systemFontOfSize:14];
    self.PlayLabel.text = @"点击播放";
    [self.contentView addSubview:self.PlayLabel];
    
    self.PlayLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 25)
    .topSpaceToView(self.contentView, 20)
    .heightIs(14);
    [self.PlayLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.PlayImageView = [UIImageView new];
    self.PlayImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.PlayImageView.image = [UIImage imageNamed:@"Home_Play"];
    [self.contentView addSubview:self.PlayImageView];
    
    self.PlayImageView.sd_layout
    .leftSpaceToView(self.PlayLabel, 10)
    .centerYEqualToView(self.PlayLabel)
    .widthIs(20)
    .heightEqualToWidth();
    
    self.contentBackView = [UIView new];
    [self.contentView addSubview:self.contentBackView];
    
    self.contentBackView.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(self.PlayLabel.width+50)
    .topSpaceToView(self.contentView, 10)
    .heightIs(self.PlayLabel.height);
    
    @weakify(self)
    self.PlayLabel.didFinishAutoLayoutBlock = ^(CGRect frame) {
        @strongify(self)
        self.contentBackView.sd_layout
        .leftSpaceToView(self.iconImageView, 15)
        .widthIs(self.PlayLabel.width+60)
        .topSpaceToView(self.contentView, 10)
        .heightIs(frame.size.height+20);
        
    };
    
    [self.contentView bringSubviewToFront:self.PlayLabel];
    
    [self.contentView bringSubviewToFront:self.PlayImageView];
    
    [self setupAutoHeightWithBottomView:self.PlayLabel bottomMargin:15];
    
}

@end
