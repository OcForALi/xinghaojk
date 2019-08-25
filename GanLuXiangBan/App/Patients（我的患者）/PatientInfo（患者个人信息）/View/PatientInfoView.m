//
//  PatientInfoView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientInfoView.h"
#import "EditUserInfoViewController.h"

@implementation PatientInfoView

- (void)setModel:(PatientsDetailsModel *)model {
    
    _model = model;
    [self reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.dataSources[indexPath.row];
    
    NSString *valueString = @"";
    NSString *keyString = cell.textLabel.text;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if ([keyString isEqualToString:@"备注名"]) {
        if (self.model.remarks && self.model.remarks.length > 0) {
            valueString = self.model.remarks;
        }
        else {
            valueString = @"未填写";
        }
    }
    else if ([keyString isEqualToString:@"昵称"]) {
        valueString = self.model.name;
    }
    else if ([keyString isEqualToString:@"性别"]) {
        valueString = self.model.gender;
    }
    else if ([keyString isEqualToString:@"地址"]) {
        valueString = self.model.addr;
    }
    else if ([keyString isEqualToString:@"电话"]) {
        valueString = self.model.mobile_no;
    }
    else if ([keyString isEqualToString:@"加入时间"]) {
        valueString = self.model.join_time;
    }
    cell.detailTextLabel.text = valueString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        EditUserInfoViewController *vc = [EditUserInfoViewController new];
        vc.title = @"备注名";
        vc.placeholderString = @"请输入备注名";
        
        if (self.goViewController) {
            self.goViewController(vc);
        }
    }
}

@end
