//
//  CheckListDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListDetailsView.h"
#import "CheckListDetailsCell.h"

@implementation CheckListDetailsView

- (void)setModel:(CheckListDetailsModel *)model {
    
    _model = model;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.items.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == self.model.items.count + 1) {
        
        CheckListDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckListDetailsCell"];
        if (cell == nil) {
            cell = [[CheckListDetailsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CheckListDetailsCell"];
        }
        
        if (indexPath.row == self.model.items.count + 1) {
            cell.content = self.model.chk_remark;
        }
        else {
            cell.model = self.model;
        }
        
        self.cellHeight = cell.cellHeight;
        return cell;
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        }
        
        CheckItemsModel *model = self.model.items[indexPath.row - 1];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = model.chk_item;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        if (model.unti && ![model.unti isEqualToString:@"/"]) {
            NSString *unti = model.unti;
            if ([@"-" isEqualToString:unti]) {
                unti = @"";
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", model.chk_value, unti];
        }
        else {
            NSString *chk = model.chk_value;
            if (chk) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", chk];
            }
            else {
                cell.detailTextLabel.text = @"";
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == self.model.items.count + 1) {
        return self.cellHeight;
    }
    
    return 45;
}
    
@end
