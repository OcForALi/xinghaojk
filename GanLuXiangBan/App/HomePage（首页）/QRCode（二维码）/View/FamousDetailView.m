//
//  FamousDetailView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousDetailView.h"

#import "FamousTableViewCell.h"

@implementation FamousDetailView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FamousGroupModel *group = [self.dataSources objectAtIndex:section];
    return group.expand ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    FamousGroupModel *group = [self.dataSources objectAtIndex:section];
    NSInteger row = indexPath.row;
    if (row == 0) {
        FamouseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamouseDetailTableViewCell"];
        if (!cell) {
            cell = [[FamouseDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FamouseDetailTableViewCell"];
        }
        cell.titleLabel.text = group.name;
        cell.expand = group.expand;
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamousDetailCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FamousDetailCell"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = kFontRegular(14);
        }
        cell.textLabel.text = group.info;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    FamousGroupModel *group = [self.dataSources objectAtIndex:section];
    if (row == 0) {
        return 44;
    }
    else {
        CGFloat height = 44;
        NSString *str = group.info;
        if (str && str.length > 0) {
            height = [str boundingRectWithSize:CGSizeMake(ScreenWidth-50, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFontRegular(14)} context:nil].size.height;
            height = ceilf(height) + 20;
        }
        return height > 44 ? height : 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    FamousGroupModel *group = [self.dataSources objectAtIndex:section];
    if (row == 0) {
        group.expand = !(group.expand);
        [tableView reloadData];
    }
}

@end
