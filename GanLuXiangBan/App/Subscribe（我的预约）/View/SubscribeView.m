//
//  SubscribeView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeView.h"
#import "SubscribeCell.h"
#import "SubscribeDetailsViewController.h"

@interface SubscribeView ()

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation SubscribeView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[SubscribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.model = self.dataSources[indexPath.row];
    self.cellHeight = cell.cellHeight;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    SubscribeModel *model = self.dataSources[indexPath.row];
    
    SubscribeDetailsViewController *vc = [SubscribeDetailsViewController new];
    vc.idString = model.pkid;
    vc.fromMyPoint = self.offlinePoint;
    self.goViewController(vc);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

@end
