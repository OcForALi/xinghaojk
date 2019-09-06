//
//  IntegralInfoView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/16.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "IntegralInfoView.h"

#import "IntegralInfoViewCell.h"
#import "IntegralInfoViewCFCell.h"

@implementation IntegralInfoView

- (void)setModel:(MyPointInfoModel *)model {
    _model = model;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    else if (section == 1 && self.model) {
        return 1;
    }
    else if (section == 2) {
        NSInteger count = 1;
        if (self.model && self.model.rp_items) {
            count += self.model.rp_items.count;
        }
        if (count == 1) {
            count = 2;
        }
        return count;
    }
    else if (section == 3) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        IntegralInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralInfoViewCell"];
        if (!cell) {
            cell = [[IntegralInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralInfoViewCell"];
        }
        if (row == 0) {
            cell.leftLabel.text = @"服务时间";
        }
        else if (row == 1) {
            cell.leftLabel.text = @"积分来源";
        }
        else if (row == 2) {
            cell.leftLabel.text = @"可获积分";
        }
        else {
            cell.leftLabel.text = @"详细信息";
        }
        cell.rightLabel.text = @"";
        if (self.model) {
            if (row == 0) {
                cell.rightLabel.text = self.model.server_time;
            }
            else if (row == 1) {
                cell.rightLabel.text = self.model.pointsSource;
            }
            else if (row == 2) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",@(self.model.points)];
            }
        }
        return cell;
    }
    else if (section == 1) {
        IntegralInfoViewCFUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralInfoViewCFUserCell"];
        if (!cell) {
            cell = [[IntegralInfoViewCFUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralInfoViewCFUserCell"];
        }
        cell.nameLabel.text = self.model && self.model.member_name ? [NSString stringWithFormat:@"姓名：%@", self.model.member_name] : @"姓名：";
        cell.sexLabel.text = self.model && self.model.gender ? [NSString stringWithFormat:@"性别：%@", self.model.gender] : @"性别：";
        cell.ageLabel.text = self.model ? [NSString stringWithFormat:@"年龄：%@", @(self.model.age)] : @"年龄：";
        cell.lczdLabel.text = self.model && self.model.rcd_result ? [NSString stringWithFormat:@"临床诊断：%@", self.model.rcd_result] : @"临床诊断：";
        return cell;
    }
    else if (section == 2) {
        if (row == 0) {
            IntegralInfoViewCFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralInfoViewCFTitleCell"];
            if (!cell) {
                cell = [[IntegralInfoViewCFTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralInfoViewCFTitleCell"];
            }
            return cell;
        }
        else {
            row--;
            IntegralInfoViewCFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralInfoViewCFCell"];
            if (!cell) {
                cell = [[IntegralInfoViewCFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralInfoViewCFCell"];
            }
            cell.tag = row + 1;
            if (self.model && self.model.rp_items && row < self.model.rp_items.count) {
                cell.model = [self.model.rp_items objectAtIndex:row];
                NSInteger count = self.model.rp_items.count;
                cell.borderView.bottomLine = row >= count - 1;
            }
            else {
                cell.borderView.bottomLine = YES;
            }
            return cell;
        }
    }
    else {
        IntegralInfoViewRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralInfoViewRemarkCell"];
        if (!cell) {
            cell = [[IntegralInfoViewRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralInfoViewRemarkCell"];
        }
        if (self.model) {
            cell.rightLabel.text = self.model.remarks;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 1) {
        CGFloat height = 115;
        if (self.model && self.model.rcd_result) {
            NSString *res = [@"临床诊断：" stringByAppendingFormat:@"%@",self.model.rcd_result];
            CGFloat hh = [res boundingRectWithSize:CGSizeMake(ScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFontRegular(14)} context:nil].size.height;
            if (hh > 20) {
                height += hh - 20;
            }
        }
        return height;
    }
    else if (section == 2) {
        if (row > 0) {
            row--;
            if (self.model && self.model.rp_items && row < self.model.rp_items.count) {
//                MyPointInfoDrugModel *model = [self.model.rp_items objectAtIndex:row];
                return 110;
//                return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:IntegralInfoViewCFCell.class contentViewWidth:ScreenWidth];
            }
        }
    }
    else if (section == 3) {
        CGFloat height = 76;
        if (self.model && self.model.remarks) {
            height += [self.model.remarks boundingRectWithSize:CGSizeMake(ScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFontRegular(14)} context:nil].size.height;
        }
        return height;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
