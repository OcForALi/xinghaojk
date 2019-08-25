//
//  RecipientListCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecipientListCell.h"
#import "GroupAddModel.h"

@interface RecipientListCell ()

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *lineView;

@end

@implementation RecipientListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, ScreenWidth - 55, 15)];
    titleLabel.centerY = self.centerY;
    titleLabel.text = @"从列表中选择";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:titleLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(titleLabel.frame) + 5, ScreenWidth - 80, 15)];
    self.idLabel.font = [UIFont systemFontOfSize:12];
    self.idLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.idLabel];
    
    UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 45 - 1, ScreenWidth, 1)];
    lineView.backgroundColor = kPageBgColor;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)setIdInfos:(NSArray *)idInfos {
    
    _idInfos = idInfos;
    
    if (idInfos.count > 0) {
        
        NSMutableString *idString = [NSMutableString string];
        GroupAddModel *model = idInfos[0];
        [idString appendString:model.patient_name];
        
        for (int i = 1; i < idInfos.count; i++) {
            GroupAddModel *model = idInfos[i];
            [idString appendFormat:@", %@", model.patient_name];
        }
        
        self.idLabel.text = idString;
    }
}

@end
