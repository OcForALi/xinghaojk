//
//  PatientListView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientListView.h"
#import "PatientsModel.h"
#import "PatientListCell.h"

@interface PatientListView ()

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSArray *keys;

@end

@implementation PatientListView

#pragma mark - set
- (void)setDictDataSource:(NSDictionary *)dictDataSource {
    
    _dictDataSource = dictDataSource;
    self.defaultImgView.hidden = [dictDataSource count] > 0 ? YES : NO;
    self.keys = [dictDataSource.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSources && self.dataSources.count > 0) {
        return 2;
    }
    return self.keys.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.dataSources && self.dataSources.count > 0) {
        return self.dataSources.count;
    }
    else {
        section--;
        NSArray *list = [self.dictDataSource valueForKey:self.keys[section]];
        return list ? list.count : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientListAllGroupsCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"patientListAllGroupsCell"];
            cell.textLabel.font = kFontRegular(18);
            cell.textLabel.textColor = kSixColor;
        }
        cell.textLabel.text = self.currentGroup ? self.currentGroup.name : @"全部患者";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else {
        section--;
        PatientListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[PatientListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        }
        cell.showFee = self.showFee;
        if (self.dataSources && self.dataSources.count > 0) {
            cell.model = self.dataSources[row];
        }
        else {
            cell.model = self.dictDataSource[self.keys[section]][row];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (self.didSelectPatientGroupBlock) {
            self.didSelectPatientGroupBlock(self.currentGroup);
        }
    }
    else {
        if (self.dataSources && self.dataSources.count > 0) {
            PatientsModel *model = self.dataSources[row];
            model.isSelect = !model.isSelect;
            [tableView reloadData];
        }
        else {
            section--;
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dictDataSource];
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dict[self.keys[section]]];
            
            PatientsModel *model = arr[row];
            model.isSelect = !model.isSelect;
            [arr replaceObjectAtIndex:indexPath.row withObject:model];
            [dict setObject:arr forKey:self.keys[section]];
            
            self.dictDataSource = dict;
        }
        
        if (self.didSelectPatientBlock) {
            self.didSelectPatientBlock(self.dictDataSource);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }
    return self.showFee ? 90 : 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || (self.dataSources && self.dataSources.count > 0)) {
        return 8;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || (self.dataSources && self.dataSources.count > 0)) {
        return nil;
    }
    section--;
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    headerView.textLabel.text = self.keys[section];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    return headerView;
}

@end
