//
//  SubscribeDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeDetailsView.h"
#import "SubscribeHeadCell.h"
#import "SubscribeContentCell.h"

@interface SubscribeDetailsView ()

@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation SubscribeDetailsView
@synthesize endLabel;

#pragma mark - set
- (void)setModel:(SubscribeDetailsModel *)model {
    
    _model = model;
    if ([model.status intValue] == 4 || [model.status intValue] == 5) {
        self.tableHeaderView = self.endLabel;
    }
    
    [self reloadData];
}

#pragma mark - lazy
- (UILabel *)endLabel {
    
    if (!endLabel) {
        
        endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        endLabel.text = self.model.closing_reason;
        endLabel.font = [UIFont systemFontOfSize:12];
        endLabel.textColor = [UIColor colorWithHexString:@"0xbb4e03"];
        endLabel.textAlignment = NSTextAlignmentCenter;
        endLabel.backgroundColor = [UIColor colorWithHexString:@"0xffde02"];
    }
    
    return endLabel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SubscribeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubscribeHeadCell"];
        if (cell == nil) {
            cell = [[SubscribeHeadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SubscribeHeadCell"];
        }
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.row == 3) {
        
        SubscribeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubscribeContentCell"];
        if (cell == nil) {
            cell = [[SubscribeContentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SubscribeContentCell"];
        }
        cell.model = self.model;
        self.cellHeight = cell.cellHeight;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    NSInteger type = [self.model.pre_type integerValue];
    NSInteger status = [self.model.status integerValue];
    NSArray *titles = @[@"申请时间", @"期望预约时间", @"咨询方式"];
    NSArray *contents = @[self.model.createtime, self.model.except_date, self.model.pre_type];
    if (type == 2 || type == 3) {
        if (status != 0) {
            titles = @[@"申请时间", @"咨询时间", @"咨询方式"];
            contents = @[self.model.createtime, self.model.pre_date, self.model.pre_type];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = contents[indexPath.row];
    if (indexPath.row == 2) {
        
        NSString *typeString = @"图文";
        if ([self.model.pre_type intValue] == 2) {
            typeString = @"电话";
        }
        else if ([self.model.pre_type intValue] == 3) {
            typeString = @"线下";
        }
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@咨询", typeString];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 70;
    }
    else if (indexPath.row == 3) {
        return self.cellHeight;
    }
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        if (self.goViewController) {
            self.goViewController();
        }
    }
}

@end
