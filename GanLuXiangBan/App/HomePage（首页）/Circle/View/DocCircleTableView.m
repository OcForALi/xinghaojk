//
//  DocCircleTableView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleTableView.h"

#import "DocCircleTableCell.h"
#import "DocCircleTableNameCell.h"

@implementation DocCircleTableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    if (self.model) {
        count = 1;
        if (self.model.expand && self.model.childs) {
            count += self.model.childs.count;
        }
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        section--;
        NSInteger count = 1;
        DocCircleSecondLevelModel *model = [self.model.childs objectAtIndex:section];
        if (model && model.childs) {
            count += model.childs.count;
        }
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        DocCircleTableNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocCircleTableNameCell"];
        if (!cell) {
            cell = [[DocCircleTableNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DocCircleTableNameCell"];
        }
        cell.nameLabel.text = self.model && self.model.invited_drid_name ? self.model.invited_drid_name : @"";
        cell.expand = self.model ? self.model.expand : NO;
        cell.iconView.hidden = !(self.model && self.model.childs && self.model.childs.count > 0);
        cell.dotView.hidden = YES;
        return cell;
    }
    else {
        section--;
        DocCircleSecondLevelModel *model = [self.model.childs objectAtIndex:section];
        if (row == 0) {
            DocCircleTableNextNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocCircleTableNextNameCell"];
            if (!cell) {
                cell = [[DocCircleTableNextNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DocCircleTableNextNameCell"];
            }
            cell.nameLabel.text = model.invited_drid_name;
            cell.expand = model.expand;
            cell.iconView.hidden = !(model.childs && model.childs.count > 0);
            cell.dotView.hidden = !model.is_active;
            return cell;
        }
        else {
            row--;
            DocCircleLevelBaseModel *item = [model.childs objectAtIndex:row];
            DocCircleTableLastNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocCircleTableLastNameCell"];
            if (!cell) {
                cell = [[DocCircleTableLastNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DocCircleTableLastNameCell"];
                cell.iconView.hidden = YES;
            }
            cell.nameLabel.text = item.invited_drid_name;
            cell.dotView.hidden = !item.is_active;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
