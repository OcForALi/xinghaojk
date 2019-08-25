//
//  CheckListDetailsCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListDetailsCell.h"

@interface CheckListDetailsCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CheckListDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 15, ScreenWidth, 15)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, CGRectGetMaxY(self.titleLabel.frame) + 10, 0, 0)];
    self.contentLabel.text = @"2018-04-25";
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.width = ScreenWidth - (self.contentLabel.x * 2);
    self.contentLabel.height = [self.contentLabel getTextHeight];
    [self.contentView addSubview:self.contentLabel];
    
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 15;
}

- (void)setModel:(CheckListDetailsModel *)model {
    
    self.titleLabel.text = model.hospital_name;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    self.contentLabel.text = model.chk_time;
    self.contentLabel.height = [self.contentLabel getTextHeight];
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 15;
}

- (void)setContent:(NSString *)content {
    
    self.titleLabel.text = @"结论";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.contentLabel.text = content;
    self.contentLabel.height = [self.contentLabel getTextHeight];
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 15;
}

@end
