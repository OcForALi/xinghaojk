//
//  ChatRemindTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatRemindTableViewCell.h"
#import "ChatDrugsModel.h"

@implementation ChatRemindTableViewCell

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
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
   
    switch ([_model.user_type integerValue]) {
            
        case 0:{
            
            self.iconImageView.sd_resetLayout
            .leftSpaceToView(self.contentView, 15)
            .topSpaceToView(self.contentView, 10)
            .widthIs(40)
            .heightEqualToWidth();
            
            self.contentBackView.sd_resetLayout
            .leftSpaceToView(self.iconImageView, 15)
            .widthIs(240)
            .topSpaceToView(self.contentView, 10)
            .heightIs(50 + model.druguse.count * 82);
            
            self.drugContentView.sd_resetNewLayout
            .leftSpaceToView(self.iconImageView, 15)
            .widthIs(240)
            .topSpaceToView(self.contentView, 10)
            .bottomSpaceToView(self.contentView, 40);
            
            for (UIView *subView in self.drugContentView.subviews) {
                [subView removeFromSuperview];
            }
            
//            UILabel *seekLabel = [UILabel new];
//            seekLabel.text = [NSString stringWithFormat:@"咨询编号：%@",model.zx_no];
//            seekLabel.font = [UIFont systemFontOfSize:14];
//            [self.drugContentView addSubview:seekLabel];
//
//            seekLabel.sd_layout
//            .leftSpaceToView(self.drugContentView, 15)
//            .topSpaceToView(self.drugContentView, 10)
//            .heightIs(14);
//            [seekLabel setSingleLineAutoResizeWithMaxWidth:200];
            
//            UIView *line1View = [UIView new];
//            line1View.backgroundColor = RGB(237, 237, 237);
//            [self.drugContentView addSubview:line1View];
//
//            line1View.sd_layout
//            .leftSpaceToView(self.drugContentView, 0)
//            .rightSpaceToView(self.drugContentView, 0)
//            .topSpaceToView(self.drugContentView, 5)
//            .heightIs(0.5);
            
            for (int i = 0; i < model.druguse.count; i++) {
                
                ChatDrugsModel *drugModel = [ChatDrugsModel new];
                [drugModel setValuesForKeysWithDictionary:model.druguse[i]];
                
                UILabel *drugNameLabel = [UILabel new];
                drugNameLabel.font = [UIFont systemFontOfSize:14];
                drugNameLabel.textColor = kMainTextColor;
                [self.drugContentView addSubview:drugNameLabel];
                
                drugNameLabel.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(self.drugContentView, 10 + i *82)
                .heightIs(14);
                [drugNameLabel setSingleLineAutoResizeWithMaxWidth:200];
                
                UILabel *standardLaebl = [UILabel new];
                standardLaebl.font = [UIFont systemFontOfSize:14];
                [self.drugContentView addSubview:standardLaebl];
                
                standardLaebl.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(drugNameLabel, 10)
                .heightIs(14);
                [standardLaebl setSingleLineAutoResizeWithMaxWidth:200];
                
                UILabel *qtyLaebl = [UILabel new];
                qtyLaebl.font = [UIFont systemFontOfSize:14];
                qtyLaebl.textColor = kSixColor;
                [self.drugContentView addSubview:qtyLaebl];
                
                qtyLaebl.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(standardLaebl, 10)
                .heightIs(14);
                [qtyLaebl setSingleLineAutoResizeWithMaxWidth:200];
                
                
                if (i < model.druguse.count - 1) {
                    UIView *lineView = [UIView new];
                    lineView.backgroundColor = RGB(237, 237, 237);
                    [self.drugContentView addSubview:lineView];
                    
                    lineView.sd_layout
                    .leftSpaceToView(self.drugContentView, 0)
                    .rightSpaceToView(self.drugContentView, 0)
                    .topSpaceToView(qtyLaebl, 10)
                    .heightIs(0.5);
                }
                
                
                drugNameLabel.text = [NSString stringWithFormat:@"%d、%@ %@",(i+1),drugModel.drug_name,drugModel.common_name];
                
                standardLaebl.text = drugModel.standard;
                
                qtyLaebl.text = [NSString stringWithFormat:@"需求数量：x%@",drugModel.qty];
                
            }
            
            self.contentBackView.layer.sublayers = nil;
            
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
            
            self.detailsButton.sd_resetNewLayout
            .bottomSpaceToView(self.contentView, 10)
            .widthIs(240)
            .heightIs(40)
            .rightSpaceToView(self.iconImageView, 15);
            
            self.contentBackView.sd_resetLayout
            .rightSpaceToView(self.iconImageView, 15)
            .widthIs(240)
            .topSpaceToView(self.contentView, 10)
            .heightIs(50 + model.druguse.count * 82);
            
            for (UIView *subView in self.drugContentView.subviews) {
                [subView removeFromSuperview];
            }
            
            NSInteger count = model.druguse.count;
            for (int i = 0; i < count; i++) {
                
                ChatDrugsModel *drugModel = [ChatDrugsModel new];
                [drugModel setValuesForKeysWithDictionary:model.druguse[i]];
                
                UILabel *drugNameLabel = [UILabel new];
                drugNameLabel.font = [UIFont systemFontOfSize:14];
                [self.drugContentView addSubview:drugNameLabel];
                
                drugNameLabel.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(self.drugContentView, 10 + i *82)
                .heightIs(14);
                [drugNameLabel setSingleLineAutoResizeWithMaxWidth:200];
                
                UILabel *standardLaebl = [UILabel new];
                standardLaebl.font = [UIFont systemFontOfSize:14];
                [self.drugContentView addSubview:standardLaebl];
                
                standardLaebl.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(drugNameLabel, 10)
                .heightIs(14);
                [standardLaebl setSingleLineAutoResizeWithMaxWidth:200];
                
                UILabel *qtyLaebl = [UILabel new];
                qtyLaebl.font = [UIFont systemFontOfSize:14];
                [self.drugContentView addSubview:qtyLaebl];
                
                qtyLaebl.sd_layout
                .leftSpaceToView(self.drugContentView, 15)
                .topSpaceToView(standardLaebl, 10)
                .heightIs(14);
                [qtyLaebl setSingleLineAutoResizeWithMaxWidth:200];
                
                
                if (i < count - 1) {
                    UIView *lineView = [UIView new];
                    lineView.backgroundColor = RGB(237, 237, 237);
                    [self.drugContentView addSubview:lineView];
                    
                    lineView.sd_layout
                    .leftSpaceToView(self.drugContentView, 0)
                    .rightSpaceToView(self.drugContentView, 0)
                    .topSpaceToView(qtyLaebl, 10)
                    .heightIs(0.5);
                }
                
                
                drugNameLabel.text = [NSString stringWithFormat:@"%d、%@ %@", (i+1),drugModel.drug_name,drugModel.common_name];
                
                standardLaebl.text = drugModel.standard;
                
                qtyLaebl.text = [NSString stringWithFormat:@"需求数量：x%@",drugModel.qty];
                
            }
            
            self.contentBackView.layer.sublayers = nil;
            
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
                shapeLayer.fillColor = [UIColor whiteColor].CGColor;
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

- (NSString *)parseUnitName:(NSString *)standard {
    if (standard && [standard rangeOfString:@"/"].location != NSNotFound) {
        NSArray *list = [standard componentsSeparatedByString:@"/"];
        if (list.count > 1) {
            return [list lastObject];
        }
    }
    return @"";
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
    
    self.contentBackView = [UIView new];
    [self.contentView addSubview:self.contentBackView];
    
    self.contentBackView.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(240)
    .topSpaceToView(self.contentView, 10)
    .heightIs(127);
    
    self.detailsButton = [UIButton new];
    self.detailsButton.titleLabel.font = [UIFont systemFontOfSize: 16];
//    [self.detailsButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.detailsButton setTitle:@"用药建议" forState:UIControlStateNormal];
    [self.detailsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.detailsButton setBackgroundColor: kMainColor];
    [self.contentView addSubview:self.detailsButton];
    
    self.detailsButton.sd_layout
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(240)
    .heightIs(40)
    .leftSpaceToView(self.iconImageView, 15);
    
    self.drugContentView = [UIView new];
    [self.contentView addSubview:self.drugContentView];
    
    self.drugContentView.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(240)
    .topSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 40);
    
    [self setupAutoHeightWithBottomView:self.contentBackView bottomMargin:10];
    
}
@end
