//
//  DrugDetailsTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugDetailsTableViewCell.h"

@implementation DrugDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(16);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contenLabel = [UILabel new];
    self.contenLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contenLabel];
    
    self.contenLabel.sd_layout
    .leftSpaceToView(self.titleLabel, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(14);
    [self.contenLabel setSingleLineAutoResizeWithMaxWidth:250];
    
}

@end
