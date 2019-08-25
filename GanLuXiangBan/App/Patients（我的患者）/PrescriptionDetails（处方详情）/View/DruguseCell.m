//
//  DruguseCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DruguseCell.h"

@interface DruguseCell ()

@property (nonatomic, strong) UILabel *noLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation DruguseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubview];
    }
    
    return self;
}


#pragma mark - lazy
- (void)setupSubview {
    
    self.noLabel = [[UILabel alloc] init];
    self.noLabel.font = kFontMedium(14);
    self.noLabel.textColor = kMainTextColor;
    [self.contentView addSubview:self.noLabel];
    self.noLabel.sd_layout.topSpaceToView(self.contentView, 15).leftSpaceToView(self.contentView, kCellSpacing).heightIs(16);
    [self.noLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:13];
    self.nameLabel.textColor = kMainTextColor;
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.sd_layout.topEqualToView(self.noLabel).leftSpaceToView(self.noLabel, 0).heightRatioToView(self.noLabel, 1.0).widthIs(ScreenWidth/2);
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 40, ScreenWidth / 2, 15)];
    self.introduceLabel.font = [UIFont boldSystemFontOfSize:13];
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.introduceLabel];
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing + 8, CGRectGetMaxY(self.introduceLabel.frame) + 10, 0, 15)];
    self.noteLabel.width = ScreenWidth - self.noteLabel.x - 15;
    self.noteLabel.font = [UIFont boldSystemFontOfSize:13];
    self.noteLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.noteLabel.numberOfLines = 0;
    [self.contentView addSubview:self.noteLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-115, 25, 100, 30)];
    self.numLabel.font = kFontRegular(14);
    self.numLabel.textColor = kMainTextColor;
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLabel];
    
    self.cellHeight = CGRectGetMaxY(self.introduceLabel.frame) + 15;
}

- (void)setModel:(DruguseModel *)model {
    self.noLabel.text = [NSString stringWithFormat:@"%@、", @(self.tag+1)];
    self.noteLabel.hidden = YES;
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.drug_name];
    self.introduceLabel.text = model.dosage;
    self.cellHeight = CGRectGetMaxY(self.introduceLabel.frame) + 15;
    self.numLabel.text = [NSString stringWithFormat:@"x%@", model.qty];

//    if (model.remark && model.remark.length > 0 && ![model.remark isEqualToString:@"(null)"]) {
//        self.noteLabel.hidden = NO;
//        self.noteLabel.text = model.remark;
//        self.noteLabel.height = [self.noteLabel getTextHeight];
//        self.cellHeight += self.noteLabel.height + 15;
//    }
}

@end
