//
//  MyGiftView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyGiftView.h"

@interface MyGiftCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *giftView;
@end

@implementation MyGiftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.headerView = [[UIImageView alloc] init];
        self.headerView.layer.masksToBounds = YES;
        self.headerView.layer.cornerRadius = 30;
        [self.contentView addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.width.height.mas_equalTo(60);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.giftView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.giftView];
        [self.giftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
            make.width.height.mas_equalTo(60);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = kMainTextColor;
        self.nameLabel.font = kFontRegular(15);
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView);
            make.left.equalTo(self.headerView.mas_right).offset(14);
            make.right.equalTo(self.giftView).offset(-14);
            make.height.mas_equalTo(30);
        }];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.textColor = kSixColor;
        self.dateLabel.font = kFontRegular(14);
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerView);
            make.left.equalTo(self.headerView.mas_right).offset(14);
            make.right.equalTo(self.giftView).offset(-14);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

@end



@implementation MyGiftView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyGiftCell"];
    if (!cell) {
        cell = [[MyGiftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyGiftCell"];
    }
    NSInteger row = indexPath.row;
    if (row < self.dataSources.count) {
        MyGiftModel *obj = [self.dataSources objectAtIndex:row];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@【%@】", obj.patient_name, obj.typestr];
        cell.dateLabel.text = [NSString stringWithFormat:@"赠送时间：%@", obj.createtime];
        UIImage *header = [UIImage imageNamed:@"userHeader"];
        if (obj.patient_head) {
            [cell.headerView sd_setImageWithURL:[NSURL URLWithString:obj.patient_head] placeholderImage:header];
        }
        else {
            cell.headerView.image = header;
        }
        if (obj.icon) {
            [cell.giftView sd_setImageWithURL:[NSURL URLWithString:obj.icon]];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
