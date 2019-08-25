//
//  PatientListCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientListCell.h"

@interface PatientListCell ()

/// 头像
@property (nonatomic, strong) UIImageView *imgView;
/// 昵称
@property (nonatomic, strong) UILabel *nickNameLabel;
/// 信息
@property (nonatomic, strong) UILabel *infoLabel;
/// 分组
@property (nonatomic, strong) UILabel *groupNameLabel;

//图文
@property (nonatomic, strong) UILabel *picFeeLabel;

//电话
@property (nonatomic, strong) UILabel *telLabel;

//线下
@property (nonatomic, strong) UILabel *offlineLabel;

@end

@implementation PatientListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    CGFloat y = 15;
    if (self.showFee) {
        y = 25;
    }
    
    // 头像
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, y, 40, 40)];
    self.imgView.layer.cornerRadius = self.imgView.height / 2;
    self.imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    // 昵称
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 10, 15, ScreenWidth / 2, 15)];
    self.nickNameLabel.text = @"测试";
    self.nickNameLabel.font = [UIFont systemFontOfSize:14];
    self.nickNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.nickNameLabel];

    // 信息
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 10, CGRectGetMaxY(self.nickNameLabel.frame) + 10, ScreenWidth / 2, 15)];
    self.infoLabel.text = @"测试";
    self.infoLabel.font = [UIFont systemFontOfSize:13];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    [self.contentView addSubview:self.infoLabel];
 
    // 分组昵称
    self.groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, 15)];
    self.groupNameLabel.x = ScreenWidth - ScreenWidth / 2 - 15;
    self.groupNameLabel.centerY = self.nickNameLabel.centerY;
    self.groupNameLabel.font = [UIFont systemFontOfSize:14];
    self.groupNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.groupNameLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.groupNameLabel];

    // 选中
    UIImage *img = [UIImage imageNamed:@"SelectPatients"];
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.size = CGSizeMake(15, 15);
    self.selectBtn.centerY = self.infoLabel.centerY;
    self.selectBtn.x = ScreenWidth - self.selectBtn.width - 15;
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"NoSelectPatients"] forState:UIControlStateNormal];
    [self.selectBtn setBackgroundImage:img forState:UIControlStateSelected];
    [self.contentView addSubview:self.selectBtn];
    
    self.picFeeLabel = [self setupFeeLabel:0];
    self.picFeeLabel.text = @"图文0元";
    
    self.telLabel = [self setupFeeLabel:1];
    self.telLabel.text = @"电话0元";
    
    self.offlineLabel = [self setupFeeLabel:2];
    self.offlineLabel.text = @"线下0元";
}

- (UILabel *)setupFeeLabel:(NSInteger)index {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 10 + index * 76, CGRectGetMaxY(self.infoLabel.frame) + 4, 66, 18)];
    label.font = kFontRegular(10);
    label.layer.borderWidth = 1.0;
    label.layer.borderColor = index % 2 == 0 ? kMainColor.CGColor : KRedColor.CGColor;
    label.textColor = kMainTextColor;
    label.hidden = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    return label;
}

- (void)setModel:(PatientsModel *)model {
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    if (model.head) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:place];
    }
    else {
        self.imgView.image = place;
    }
    self.nickNameLabel.text = model.membername;
    self.groupNameLabel.text = [self parseGroup:model.label_name];
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@岁", model.gender, model.age];
    self.selectBtn.selected = model.isSelect;
    
    if (self.showFee) {
        NSString *pic = [self parseFee:0 cost:model.tw_cost];
        if (pic) {
            self.picFeeLabel.text = pic;
            self.picFeeLabel.hidden = NO;
        }
        else {
            self.picFeeLabel.hidden = YES;
        }
        
        NSString *tel = [self parseFee:1 cost:model.tel_cost];
        if (tel) {
            self.telLabel.text = tel;
            self.telLabel.hidden = NO;
        }
        else {
            self.telLabel.hidden = YES;
        }

        NSString *offtxt = [self parseFee:2 cost:model.line_cost];
        if (offtxt) {
            self.offlineLabel.text = offtxt;
            self.offlineLabel.hidden = NO;
        }
        else {
            self.offlineLabel.hidden = YES;
        }
    }
}

- (NSString *)parseGroup:(NSString *)groups {
    if (groups && groups.length > 0) {
        NSArray *list = [groups componentsSeparatedByString:@","];
        NSMutableSet *sets = [[NSMutableSet alloc] init];
        for (NSString *item in list) {
            [sets addObject:item];
        }
        NSArray *res = [sets allObjects];
        return [res componentsJoinedByString:@","];
    }
    return @"";
}

- (NSString *)parseFee:(NSInteger)index cost:(NSString *)cost {
    NSString *fee = @"图文";
    if (index == 1) {
        fee = @"电话";
    }
    else if (index == 2) {
        fee = @"线下";
    }
    
    NSInteger num = 0;
    if (cost && ![cost isKindOfClass:NSNull.class]) {
        num = [cost integerValue];
    }
    if (num < 0) {
        return nil;//[fee stringByAppendingString:@"未开通"];
    }
    else if (num == 0) {
        return [fee stringByAppendingString:@"免费"];
    }
    return [NSString stringWithFormat:@"%@%@元", fee, @(num)];
}

@end
