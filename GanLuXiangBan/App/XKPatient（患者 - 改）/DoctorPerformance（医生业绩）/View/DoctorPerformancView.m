//
//  DoctorPerformancView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorPerformancView.h"
#import "DrugCell.h"

@interface DoctorPerformancView ()

@property (nonatomic, assign) float cellHeight;

@end

@implementation DoctorPerformancView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DrugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugCell"];
    if (cell == nil) {
        
        cell = [[DrugCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DrugCell"];
        self.cellHeight = cell.cellHeight;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

@end
