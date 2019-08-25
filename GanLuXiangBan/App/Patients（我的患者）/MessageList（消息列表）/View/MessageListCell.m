
//
//  MessageListCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MessageListCell.h"

@interface MessageListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 收件人
    int spacing = 10;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 15, ScreenWidth, 0)];
    self.titleLabel.text = @"收件人:   所有患者";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.titleLabel.height = [self.titleLabel getTextHeight];
    [self.contentView addSubview:self.titleLabel];
    
    // 内容
    UILabel *contentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, CGRectGetMaxY(self.titleLabel.frame) + spacing, ScreenWidth, self.titleLabel.height)];
    contentTitleLabel.text = @"内容:";
    contentTitleLabel.font = [UIFont systemFontOfSize:14];
    contentTitleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:contentTitleLabel];
    
    // 内容
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, CGRectGetMaxY(contentTitleLabel.frame) + spacing, 0, self.titleLabel.height)];
    self.contentLabel.width = ScreenWidth - self.contentLabel.x * 2;
    self.contentLabel.text = @"这里是内容";
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    // 时间
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + spacing, 0, self.titleLabel.height)];
    self.timeLabel.width = ScreenWidth - self.contentLabel.x;
    self.timeLabel.text = @"2018-05-18";
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
    
    self.cellHeight = CGRectGetMaxY(self.timeLabel.frame) + 15;
}

- (void)setModel:(MessageListModel *)model {
    
    NSString *typeString = @"所有患者";
    if ([model.recive_type intValue] == 1) {
        typeString = @"部分可见";
    }
    else if ([model.recive_type intValue] == 2) {
        typeString = @"部分不可见";
    }

    self.titleLabel.text = [NSString stringWithFormat:@"收件人  %@", typeString];
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.createtime;
    
    self.contentLabel.height = [self.contentLabel getTextHeight];
    self.timeLabel.height = [self.timeLabel getTextHeight];
    self.timeLabel.y = CGRectGetMaxY(self.contentLabel.frame) + 15;
    self.cellHeight = CGRectGetMaxY(self.timeLabel.frame) + 15;
}

@end
