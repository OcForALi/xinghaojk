//
//  HomeArticleView.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleView.h"

#import "HomeArticleTableViewCell.h"

@implementation HomeArticleView

- (void)setShowWaited:(BOOL)showWaited {
    _showWaited = showWaited;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeArticleTableViewCell"];
    if (!cell) {
        cell = [[HomeArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeArticleTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSInteger row = indexPath.row;
    if (row < self.dataSources.count) {
        HomeArticleModel *item = [self.dataSources objectAtIndex:row];
//        NSString *title = item.NewsTitle;
//        if (item.NewsSTitle) {
//            title = [NSString stringWithFormat:@"%@", title];
//        }
        cell.nameLabel.text = item.NewsTitle;
        cell.labelView.text = item.Tags;
        if (self.showWaited) {
            cell.numLabel.hidden = YES;
        }
        else {
            cell.numLabel.hidden = NO;
            cell.numLabel.text = [NSString stringWithFormat:@"%@人已读",@(item.clike)];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.articleListTapItemBlock && row < self.dataSources.count) {
        HomeArticleModel *item = [self.dataSources objectAtIndex:row];
        self.articleListTapItemBlock(item);
    }
}

@end
