//
//  SettingView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SettingView.h"
#import "HelpWebViewController.h"
#import "ForgotPasswordViewController.h"

@implementation SettingView

- (void)setPhoneString:(NSString *)phoneString {
    
    _phoneString = phoneString;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    if (indexPath.section == 0) {
        
        cell.detailTextLabel.text = self.phoneString;
    }
    
    cell.textLabel.text = self.dataSources[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSArray *viewControllerNames = @[@[@"PhoneViewController"],
                                     @[@"ForgotPasswordViewController"],
                                     @[@"AboutViewController", @"HelpWebViewController", @""]];
    NSString *viewControllerName = viewControllerNames[indexPath.section][indexPath.row];
    if (self.goViewController && viewControllerName.length > 0) {
        
        BaseViewController *viewCnotroller = [NSClassFromString(viewControllerName) new];
        viewCnotroller.title = self.dataSources[indexPath.section][indexPath.row];
        
        if ([viewCnotroller isKindOfClass:[HelpWebViewController class]]) {    
            [(HelpWebViewController *)viewCnotroller setBodyString:self.helpBodyString];
        }
        if ([viewCnotroller isKindOfClass:ForgotPasswordViewController.class]) {
            ForgotPasswordViewController *forgot = (ForgotPasswordViewController *)viewCnotroller;
            forgot.title = @"修改密码";
            viewCnotroller = forgot;
        }
        self.goViewController(viewCnotroller);
    }
    else {
        
        if (self.callBlock) {
            self.callBlock();
        }
    }
}

@end
