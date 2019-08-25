//
//  AddressBookTableViewCell.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddressBookTableViewCell.h"

@implementation AddressBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
        
    }
    
    return self;
}

-(void)setModel:(PhoneContactModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.name;
    
}

-(void)setupUI{
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(15);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.rightButton = [IndexPathButton new];
    [self.rightButton setImage:[UIImage imageNamed:@"Home_Hollow"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"Login_Correct"] forState:UIControlStateSelected];
    self.rightButton.selected = NO;
    [self.contentView addSubview:self.rightButton];
    
    self.rightButton.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .widthIs(30)
    .heightEqualToWidth();
    
}

@end
