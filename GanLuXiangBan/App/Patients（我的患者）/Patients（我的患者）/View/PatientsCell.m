//
//  PatientsCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsCell.h"

@interface PatientsCell ()

/// 头像
@property (nonatomic, strong) UIImageView *headerImgView;
/// 昵称
@property (nonatomic, strong) UILabel *nickNameLabel;
/// 分组
@property (nonatomic, strong) UILabel *groupLabel;
/// 信息
@property (nonatomic, strong) UILabel *infoLabel;
/// 收藏按钮
@property (nonatomic, strong) UIButton *collectionBtn;
/// 类型
@property (nonatomic, strong) NSMutableArray *types;

@end

@implementation PatientsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.types = [NSMutableArray arrayWithArray:@[@"图文", @"电话", @"线下"]];
        NSArray *typeState = [reuseIdentifier componentsSeparatedByString:@"x"];
        for (int i = 1; i < typeState.count; i++) {
            
            if (![typeState[i] boolValue]) {
                
                if (i == 1) {
                    [self.types removeObject:@"图文"];
                }
                else if (i == 2) {
                    [self.types removeObject:@"电话"];
                }
                else {
                    [self.types removeObject:@"线下"];
                }
            }
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 头像
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 65, 65)];
    self.headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImgView.clipsToBounds = YES;
    self.headerImgView.layer.cornerRadius = self.headerImgView.height / 2;
    self.headerImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerImgView];
    
    // 昵称
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgView.frame) + 10, 15, ScreenWidth / 3, 16)];
    self.nickNameLabel.text = @"测试";
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    self.nickNameLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.nickNameLabel];
    
    self.groupLabel = [UILabel new];
    self.groupLabel.font = [UIFont systemFontOfSize:14];
    self.groupLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.groupLabel.textAlignment = NSTextAlignmentRight;
    self.groupLabel.height = 15;
    self.groupLabel.width = ScreenWidth / 3;
    self.groupLabel.centerY = self.nickNameLabel.centerY;
    self.groupLabel.x = ScreenWidth - 15 - self.groupLabel.width;
    [self.contentView addSubview:self.groupLabel];
    
    // 信息
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImgView.frame) + 10, CGRectGetMaxY(self.nickNameLabel.frame) + 10, ScreenWidth, 15)];
    self.infoLabel.text = @"测试";
    self.infoLabel.font = [UIFont systemFontOfSize:13];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    [self.contentView addSubview:self.infoLabel];
    
    // 图标按钮
    UIButton *typeBtn;
    for (int i = 0; i < self.types.count; i++) {
        
        typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.tag = 666 + i;
        typeBtn.layer.cornerRadius = 5;
        typeBtn.layer.borderWidth = 0.5;
        typeBtn.layer.borderColor = [[UIColor colorWithHexString:@"0x4BD6A1"] CGColor];
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [typeBtn setTitle:@"图文10元" forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor colorWithHexString:@"0x4BD6A1"] forState:UIControlStateNormal];
        [self.contentView addSubview:typeBtn];
        
        typeBtn.height = 20;
        typeBtn.width = [typeBtn.titleLabel getTextWidth] + 20;
        typeBtn.x = CGRectGetMaxX(self.headerImgView.frame) + 8 + i * (typeBtn.width + 5);
        typeBtn.y = CGRectGetMaxY(self.infoLabel.frame) + 10;
    }

    // 收藏按钮
    UIImage *img = [UIImage imageNamed:@"collectionImg"];
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectionBtn.size = CGSizeMake(50, 50);
    self.collectionBtn.y = CGRectGetMaxY(self.infoLabel.frame);
    self.collectionBtn.x = ScreenWidth - 50;
    [self.collectionBtn setImage:[UIImage imageNamed:@"collectionNoImg"] forState:UIControlStateNormal];
    [self.collectionBtn setImage:img forState:UIControlStateSelected];
    [self.contentView addSubview:self.collectionBtn];
    
    @weakify(self);
    [[self.collectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        @strongify(self);
        self.collectBlock(!self.collectionBtn.selected);
    }];
    
    self.cellHeight = CGRectGetMaxY(typeBtn.frame) + 15;
    self.headerImgView.centerY = 50;
}

- (void)setModel:(PatientsModel *)model {
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    if (model.head) {
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:place];
    }
    else {
        self.headerImgView.image = place;
    }
    self.nickNameLabel.text = model.membername;
    self.groupLabel.text = [self parseGroup:model.label_name];
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@岁", model.gender, model.age];
    self.collectionBtn.selected = [model.is_attention boolValue];
    
    for (int i = 0; i < self.types.count; i++) {
        
        UIButton *typeBtn = [self.contentView viewWithTag:i + 666];
        NSString *typeString;
        UIColor *color;
        if ([self.types[i] isEqualToString:@"图文"]) {
            
            color = [UIColor colorWithHexString:@"0x4BD6A1"];
            typeString = [NSString stringWithFormat:@"%@%@元", self.types[i], model.tw_cost];
        }
        else {
            
            if ([self.types[i] isEqualToString:@"电话"]) {
                color = kMainColor;
                typeString = [NSString stringWithFormat:@"%@%@元", self.types[i], model.tel_cost];
            }
            else if ([self.types[i] isEqualToString:@"线下"]) {
                color = [UIColor colorWithHexString:@"0xff9500"];
                typeString = [NSString stringWithFormat:@"%@%@元", self.types[i], model.line_cost];
            }
        }
        
        [typeBtn setTitle:typeString forState:UIControlStateNormal];
        [typeBtn setTitleColor:color forState:UIControlStateNormal];
        typeBtn.layer.borderColor = [typeBtn.titleLabel.textColor CGColor];
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

@end

