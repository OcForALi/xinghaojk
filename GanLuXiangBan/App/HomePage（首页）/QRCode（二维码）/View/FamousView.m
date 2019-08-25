//
//  FamousView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousView.h"

#import "FamousTableViewCell.h"

#import "FamousDetailViewController.h"

@implementation FamousView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamousTableViewCell"];
    if (!cell) {
        cell = [[FamousTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FamousTableViewCell"];
    }
    NSInteger row = indexPath.row;
    if (row < self.dataSources.count) {
        FamousModel *item = [self.dataSources objectAtIndex:row];
        UIImage *place = [UIImage imageNamed:@"userHeader"];
        if (item.head) {
            [cell.iconView sd_setImageWithURL:[NSURL URLWithString:item.head] placeholderImage:place];
        }
        else {
            cell.iconView.image = place;
        }
        cell.nameLabel.text = item.name;
        NSString *info = item.title ? item.title : @"";
        if (item.cust_name) {
            info = [info stringByAppendingFormat:@"    %@", item.cust_name];
        }
        cell.infoLabel.text = info;
        cell.hospitalLabel.text = item.hospital_name;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.pushBlock && row < self.dataSources.count) {
        FamousModel *item = [self.dataSources objectAtIndex:row];
        FamousDetailViewController *info = [FamousDetailViewController new];
        info.model = item;
        self.pushBlock(info);
    }
}

@end
