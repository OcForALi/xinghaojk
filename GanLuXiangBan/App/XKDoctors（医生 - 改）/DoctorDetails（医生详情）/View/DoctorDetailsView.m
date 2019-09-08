//
//  DoctorDetailsView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorDetailsView.h"

@implementation DoctorDetailsView

- (void)setModel:(DoctorDetailsModel *)model {
    
    _model = model;
    [self reloadData];
}

- (NSString *)setTitle:(NSString *)title {
    
    NSString *value = @"";

    if (self.model == nil) {
        return @"";
    }
    
    title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([title containsString:@"推荐人"]) {
        return self.model.refenence_person;
    }
    else if ([title containsString:@"跟进人"]) {
        return self.model.follow_up_person;
    }
    else if ([title containsString:@"医生姓名"]) {
        return self.model.drname;
    }
    else if ([title containsString:@"职称"]) {
        return self.model.title;
    }
    else if ([title containsString:@"医院名称"]) {
        return self.model.hospital_name;
    }
    else if ([title containsString:@"科室"]) {
        return self.model.cust_name;
    }
    else if ([title containsString:@"加入时间"]) {
        return self.model.join_date;
    }
    else if ([title containsString:@"联系电话"]) {
        return self.model.mobile;
    }
    
    if (value.length == 0) {
        value = @"无";
    }
    
    return value;
}

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
        cell.detailTextLabel.text = [self setTitle:text];
    }
    
    cell.textLabel.textColor = kMainTextColor;
    cell.textLabel.text = text;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = kMainTextColor;
    
    
    return cell;
}

@end
