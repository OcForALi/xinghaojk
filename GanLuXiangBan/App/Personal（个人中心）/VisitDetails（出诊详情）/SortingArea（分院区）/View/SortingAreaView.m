//
//  SortingAreaView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SortingAreaView.h"

@implementation SortingAreaView

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 1;
    }
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    SortingAreaModel *model;
    if (self.dataSources.count > indexPath.row) {
        model = self.dataSources[indexPath.row];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"SortingAreaDeleteImg"];
        cell.textLabel.text = model.text;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"SortingAreaAddImg"];
        cell.textLabel.text = @"添加分院区";
        cell.textLabel.textColor = kMainColor;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        if (self.deleteBlock) {
            self.deleteBlock(self.dataSources[indexPath.row]);
        }
    }
    else {
        
        [self showTitleAlertWithMsg:@"请输入分院区" isCancel:YES completeBlock:^(id object) {
            
            if (self.addBlock) {
                self.addBlock(object);
            }
        }];        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0 && self.dataSources.count == 0) {
        return 0;
    }
    
    if (section == 1) {
        return CGFLOAT_MIN;
    }
    
    return 10;
}

@end
