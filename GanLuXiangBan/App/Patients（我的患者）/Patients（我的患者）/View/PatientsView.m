//
//  PatientsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsView.h"
#import "PatientsCell.h"
#import "PatientsDetailsViewController.h"

@interface PatientsView ()

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSArray *keys;

@end

@implementation PatientsView

#pragma mark - set
- (void)setDictDataSource:(NSDictionary *)dictDataSource {

    _dictDataSource = dictDataSource;
    self.defaultImgView.hidden = [dictDataSource count] > 0 ? YES : NO;
    self.keys = [dictDataSource.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dictDataSource[self.keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PatientsModel *model = self.dictDataSource[self.keys[indexPath.section]][indexPath.row];
    BOOL twCost = [model.tw_cost intValue] == -1 ? NO : YES;
    BOOL telCost = [model.tel_cost intValue] == -1 ? NO : YES;
    BOOL lineCost = [model.line_cost intValue] == -1 ? NO : YES;
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cellx%dx%dx%d", twCost, telCost, lineCost];
    PatientsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PatientsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        self.cellHeight = cell.cellHeight;
    }
    
    [cell setCollectBlock:^(BOOL isCollect) {
       
        if (self.collectBlock) {
            self.collectBlock(isCollect, model.mid);
        }
    }];
    
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PatientsModel *model = self.dictDataSource[self.keys[indexPath.section]][indexPath.row];
    
    PatientsDetailsViewController *viewController = [PatientsDetailsViewController new];
    viewController.midString = model.mid;
    self.goViewController(viewController);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    headerView.textLabel.text = self.keys[section];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    return headerView;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}


@end
