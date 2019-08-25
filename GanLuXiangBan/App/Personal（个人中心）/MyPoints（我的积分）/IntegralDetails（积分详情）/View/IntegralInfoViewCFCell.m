//
//  IntegralInfoViewCFCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "IntegralInfoViewCFCell.h"

@implementation IntegralInfoCFBorderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftLine = YES;
        self.rightLine = YES;
    }
    return self;
}

- (void)setBottomLine:(BOOL)bottomLine {
    _bottomLine = bottomLine;
    [self setNeedsDisplay];
}

- (void)setTopLine:(BOOL)topLine {
    _topLine = topLine;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.leftLine) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, height);
    }
    if (self.rightLine) {
        CGContextMoveToPoint(context, width, 0);
        CGContextAddLineToPoint(context, width, height);
    }
    if (self.topLine) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, width, 0);
    }
    if (self.bottomLine) {
        CGContextMoveToPoint(context, 0, height);
        CGContextAddLineToPoint(context, width, height);
    }
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, kMainColor.CGColor);
    CGContextStrokePath(context);
}

@end



@implementation IntegralInfoViewCFUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.borderView];
        self.borderView.sd_layout.topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15);
        
        [self.borderView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.topSpaceToView(self.borderView, 10).leftSpaceToView(self.borderView, 10).heightIs(20).widthRatioToView(self.borderView, 0.4);
        
        [self.borderView addSubview:self.sexLabel];
        self.sexLabel.sd_layout.topSpaceToView(self.borderView, 10).leftSpaceToView(self.nameLabel, 10).rightSpaceToView(self.borderView, 10).heightIs(20);
        
        [self.borderView addSubview:self.ageLabel];
        self.ageLabel.sd_layout.topSpaceToView(self.nameLabel, 10).leftSpaceToView(self.borderView, 10).rightSpaceToView(self.borderView, 10).heightIs(20);
        
        [self.borderView addSubview:self.lczdLabel];
        self.lczdLabel.sd_layout.topSpaceToView(self.ageLabel, 10).leftSpaceToView(self.borderView, 10).rightSpaceToView(self.borderView, 10).bottomSpaceToView(self.borderView, 20);
    }
    return self;
}

- (IntegralInfoCFBorderView *)borderView {
    if (!_borderView) {
        _borderView = [[IntegralInfoCFBorderView alloc] init];
        _borderView.topLine = YES;
        _borderView.bottomLine = YES;
        _borderView.backgroundColor = RGB(205, 235, 251);
    }
    return _borderView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kMainTextColor;
        _nameLabel.font = kFontRegular(14);
    }
    return _nameLabel;
}

- (UILabel *)sexLabel {
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.textColor = kMainTextColor;
        _sexLabel.font = kFontRegular(14);
    }
    return _sexLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.textColor = kMainTextColor;
        _ageLabel.font = kFontRegular(14);
    }
    return _ageLabel;
}

- (UILabel *)lczdLabel {
    if (!_lczdLabel) {
        _lczdLabel = [[UILabel alloc] init];
        _lczdLabel.textColor = kMainTextColor;
        _lczdLabel.font = kFontRegular(14);
        _lczdLabel.numberOfLines = 0;
    }
    return _lczdLabel;
}

@end



@implementation IntegralInfoViewCFTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.borderView];
        self.borderView.sd_layout.topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15);
        
        [self.borderView addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self.borderView, 10).heightIs(20).widthIs(150).centerYEqualToView(self.borderView);
    }
    return self;
}

- (IntegralInfoCFBorderView *)borderView {
    if (!_borderView) {
        _borderView = [[IntegralInfoCFBorderView alloc] init];
        _borderView.backgroundColor = RGB(205, 235, 251);
    }
    return _borderView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Rp";
        _titleLabel.font = kFontRegular(16);
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

@end



@implementation IntegralInfoViewCFCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.borderView];
        self.borderView.sd_layout.topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).bottomSpaceToView(self.contentView, 0);
        
        [self.borderView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.topSpaceToView(self.borderView, 10).leftSpaceToView(self.borderView, 10).rightSpaceToView(self.borderView, 10).heightIs(20);//autoHeightRatio(0);
        
        [self.borderView addSubview:self.priceLabel];
        self.priceLabel.sd_layout.topSpaceToView(self.nameLabel, 10).leftSpaceToView(self.borderView, 26).rightSpaceToView(self.borderView, 10).heightIs(20);
        
        [self.borderView addSubview:self.useLabel];
        self.useLabel.sd_layout.topSpaceToView(self.priceLabel, 10).leftSpaceToView(self.borderView, 26).rightSpaceToView(self.borderView, 10).heightIs(20);//.bottomSpaceToView(self.borderView, 15).autoHeightRatio(0);
        
        //[self setupAutoHeightWithBottomView:self.borderView bottomMargin:80];
    }
    return self;
}

- (void)setModel:(MyPointInfoDrugModel *)model {
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@、%@", @(self.tag), model.drug_name];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f * %@", [model.price floatValue], model.qty];
    self.useLabel.text = [NSString stringWithFormat:@"%@",model.dosage];
}

- (IntegralInfoCFBorderView *)borderView {
    if (!_borderView) {
        _borderView = [[IntegralInfoCFBorderView alloc] init];
        _borderView.backgroundColor = RGB(205, 235, 251);
    }
    return _borderView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFontRegular(14);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = kNightColor;
        _priceLabel.font = kFontRegular(12);
    }
    return _priceLabel;
}

- (UILabel *)useLabel {
    if (!_useLabel) {
        _useLabel = [[UILabel alloc] init];
        _useLabel.textColor = kNightColor;
        _useLabel.font = kFontRegular(12);
        _useLabel.numberOfLines = 0;
    }
    return _useLabel;
}

@end
