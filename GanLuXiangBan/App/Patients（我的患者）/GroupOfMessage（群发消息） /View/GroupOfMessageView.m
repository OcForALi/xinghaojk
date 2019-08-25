//
//  GroupOfMessageView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupOfMessageView.h"
#import "GroupListTitleCell.h"
#import "KTextFeildView.h"

@implementation GroupOfMessageView

- (void)setTypeString:(NSString *)typeString {
    
    _typeString = typeString;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        GroupListTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupListTitleCell"];
        if (cell == nil) {
            cell = [[GroupListTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupListTitleCell"];
        }
        cell.textLabel.text = @"医生公告";
        return cell;
    }
    else if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.selected = UITableViewCellSelectionStyleNone;
            
            KTextFeildView *textFeildView = [[KTextFeildView alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, 170)];
            textFeildView.tipString = @"请输入群发消息内容";
    
            self.textView = textFeildView.textView;
            [cell addSubview:textFeildView];
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = @"收件人:";
    cell.detailTextLabel.text = self.typeString.length == 0 ? @"所有患者" : self.typeString;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.row == 2 && self.goViewControllerBlock) {
        self.goViewControllerBlock();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.row == 1) {
        return 200;
    }
    
    return 45;
}

@end
