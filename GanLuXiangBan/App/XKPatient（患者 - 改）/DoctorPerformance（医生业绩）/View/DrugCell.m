//
//  DrugCell.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DrugCell.h"

@implementation DrugCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSubvewis];
    }
    
    return self;
}

- (void)setSubvewis {
    
    float maxy = 0;
    NSArray *texts = @[@"药品名（通用名）", @"规格", @"厂家名称XXXXXXXX"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 0, 15)];
        titleLabel.y += 25 * i;
        titleLabel.width = ScreenWidth - (titleLabel.x) * 2;
        titleLabel.text = texts[i];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = kMainTextColor;
        [self.contentView addSubview:titleLabel];
        
        maxy = titleLabel.maxY;
    }
    
    UILabel *numberLbel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 15)];
    numberLbel.text = @"50";
    numberLbel.font = [UIFont systemFontOfSize:14];
    numberLbel.textColor = kMainColor;
    numberLbel.textAlignment = NSTextAlignmentRight;
    self.accessoryView = numberLbel;
    
    self.cellHeight = maxy + 20;
}

@end
