//
//  DocCircleExtentionTableView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleExtentionTableView.h"

#import "DocCircleModel.h"

@interface DocCircleExtentionTableCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end

@implementation DocCircleExtentionTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width = (ScreenWidth - 60)/3;
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.sd_layout.leftSpaceToView(self.contentView, 15).heightIs(24).widthIs(width).centerYEqualToView(self.contentView);
        
        [self.contentView addSubview:self.numLabel];
        self.numLabel.sd_layout.leftSpaceToView(self.nameLabel, 15).heightIs(24).widthIs(width).centerYEqualToView(self.contentView);
        
        [self.contentView addSubview:self.moneyLabel];
        self.moneyLabel.sd_layout.heightIs(24).widthIs(width).rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView);
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFontRegular(14);
    }
    return _nameLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [UIColor blackColor];
        _numLabel.font = kFontRegular(14);
    }
    return _numLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = kFontRegular(14);
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}

@end


#pragma mark -

@implementation DocCircleExtentionTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 1;
    if (self.dataSources) {
        count += self.dataSources.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DocCircleExtentionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocCircleExtentionTableCell"];
    if (!cell) {
        cell = [[DocCircleExtentionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DocCircleExtentionTableCell"];
    }
    NSInteger row = indexPath.row;
    if (row == 0) {
        cell.nameLabel.text = @"姓名";
        cell.numLabel.text = @"开单数（张）";
        cell.moneyLabel.text = @"开单金额（元）";
    }
    else {
        row--;
        DocCircleOrderModel *item = [self.dataSources objectAtIndex:row];
        cell.nameLabel.text = item.drName;
        cell.numLabel.text = [NSString stringWithFormat:@"%@", @(item.sumOrder)];
        cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",item.sumAmount];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
