//
//  PrescriptionNumView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionNumView.h"
#import "PrescriptionNumModel.h"

@implementation PrescriptionNumView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PrescriptionNumModel *model = self.dataSources[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = kMainTextColor;
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", model.dr_name, model.hospital_name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@张", model.num];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}

@end
