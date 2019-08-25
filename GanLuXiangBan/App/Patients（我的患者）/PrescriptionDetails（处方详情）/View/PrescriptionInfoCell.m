//
//  PrescriptionInfoCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PrescriptionInfoCell.h"

@implementation PrescriptionInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubview];
    }
    
    return self;
}


#pragma mark - lazy
- (void)setupSubview {

    CGFloat width = (ScreenWidth - 40) / 2;
    NSArray *titles = @[@"编号: ", @"时间: ", @"姓名: ", @"性别: ", @"年龄: ", @"地区: "];
    UILabel *titleLabel;
    for (int i = 0; i < 6; i++) {
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + (width + 10) * (i % 2), 15 + 23 * (i / 2), width, 14)];
        titleLabel.tag = i + 1000;
        titleLabel.text = titles[i];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        [self.contentView addSubview:titleLabel];
    }
    
    self.cellHeight = CGRectGetMaxY(titleLabel.frame) + 15;
}

- (void)setModel:(PrescriptionDetailsModel *)model {
    
    NSArray *titles = @[@"编号: ", @"时间: ", @"姓名: ", @"性别: ", @"年龄: ", @"地区: "];
    NSArray *contents = @[@"", @"", @"", @"", @"", @"", @""];
    if (model.code.length > 0) {
        contents = @[model.code, model.date, model.name, model.gender, model.age, model.region];
    }
    for (int i = 0; i < 6; i++) {

        UILabel *titleLabel = [self.contentView viewWithTag:i + 1000];
        titleLabel.text = [NSString stringWithFormat:@"%@ %@", titles[i], contents[i]];
    }
}

@end
