//
//  CheckListView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListView.h"
#import "CheckListModel.h"
#import "CheckListTableViewCell.h"
#import "CheckListDetailsViewController.h"

@implementation CheckListView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckListViewCell"];
    if (cell == nil) {
        cell = [[CheckListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CheckListViewCell"];
    }
    
    CheckListModel *model = self.dataSources[indexPath.row];
    cell.title.text = model.name;
    cell.date.text = model.last_time;
    cell.redPoints.hidden = !model.unread;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    CheckListDetailsViewController *vc = [CheckListDetailsViewController new];
    vc.model = self.dataSources[indexPath.row];
    vc.model.unread = NO;
    [tableView reloadData];
    
    if (self.goViewController) {
        self.goViewController(vc);
    }
}

@end
