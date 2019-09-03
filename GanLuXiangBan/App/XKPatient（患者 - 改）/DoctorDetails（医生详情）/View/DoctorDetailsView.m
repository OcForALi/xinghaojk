//
//  DoctorDetailsView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorDetailsView.h"

@implementation DoctorDetailsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = self.dataSources[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    cell.textLabel.textColor = kMainTextColor;
    cell.textLabel.text = text;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}

@end
