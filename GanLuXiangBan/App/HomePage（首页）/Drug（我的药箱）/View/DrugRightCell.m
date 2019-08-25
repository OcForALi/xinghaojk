//
//  DrugRightCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugRightCell.h"

@implementation DrugRightCell
@synthesize titleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
    }
    
    return self;
}

- (void)setModel:(DrugModel *)model {
    
    _model = model;
    titleLabel.text = model.name;
}

@end
