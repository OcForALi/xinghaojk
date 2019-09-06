//
//  IntegralDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "IntegralDetailsView.h"
#import "MyPointDetailsModel.h"
#import "IntegralDetailsViewCell.h"

#import "IntegralDetailInfoViewController.h"

@implementation IntegralDetailsView

- (void)setDictDataSource:(NSDictionary *)dictDataSource {
    
    _dictDataSource = dictDataSource;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.dictDataSource.count;
    self.defaultImgView.hidden = count > 0;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dictDataSource[self.keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralDetailsViewCell"];
    if (!cell) {
        cell = [[IntegralDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralDetailsViewCell"];
    }
    NSArray *dataSource = self.dictDataSource[self.keys[indexPath.section]];
    MyPointDetailsModel *model = dataSource[indexPath.row];
    cell.dateLabel.text = model.integral_date;
    cell.numLabel.text = [NSString stringWithFormat:@"%@", model.integral_number];
    cell.nameLabel.text = model.detail_description;
    cell.statusLabel.text = @"在途中";
    if (model.status) {
        if ([model.status isEqualToString:@"1"]) {
            cell.statusLabel.text = @"可提现";
        }
        else if ([model.status isEqualToString:@"2"]) {
            cell.statusLabel.text = @"已兑换";
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([self.keys count] > 0) {
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
        }
        headerView.textLabel.text = self.keys[section];
        headerView.textLabel.font = [UIFont systemFontOfSize:16];
        return headerView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.goViewControllerBlock) {
        NSArray *dataSource = self.dictDataSource[self.keys[indexPath.section]];
        MyPointDetailsModel *model = dataSource[indexPath.row];
        if (model.detail_description && model.prescriptionId && model.prescriptionId.length > 0) {
            if ([model.detail_description rangeOfString:@"处方"].location != NSNotFound) {
                IntegralDetailInfoViewController *vc = [IntegralDetailInfoViewController new];
                vc.prescriptionId = [NSString stringWithFormat:@"%@", model.prescriptionId];
                self.goViewControllerBlock(vc);
            }
        }
    }
}

@end
