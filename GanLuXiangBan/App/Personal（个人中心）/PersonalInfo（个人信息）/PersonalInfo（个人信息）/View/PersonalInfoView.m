//
//  PersonalInfoView.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalInfoView.h"
#import "ModifyViewController.h"

@implementation PersonalInfoView

- (void)setModel:(PersonalInfoModel *)model {
    
    _model = model;
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
    
    NSString *text = self.dataSources[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        NSString *detailText = @"";
        if ([text containsString:@"姓名"]) {
            detailText = self.model.Name;
        }
        else if ([text containsString:@"性别"]) {
            detailText = self.model.Gender;
        }
        else if ([text containsString:@"身份证号"]) {
            
        }
        else if ([text containsString:@"代理区域"]) {
            
        }
        
        cell.detailTextLabel.text = detailText;
    }
    else {
        
        
        NSString *status = indexPath.row == 0 ? self.model.idt_auth_status : self.model.Auth_Status;
        NSString *auth = @"未认证";
        if ([status intValue] == 1) {
            auth = @"认证中";
        }
        else if ([status intValue] == 2) {
            auth = @"已认证";
        }
        else if ([status intValue] == 3) {
            auth = @"认证失败";
        }
        cell.detailTextLabel.text = auth;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    BaseViewController *vc;
    NSString *vcname = @"";
    NSString *text = self.dataSources[indexPath.section][indexPath.row];

    if (indexPath.section == 0) {
        
        if ([text containsString:@"性别"]) {
            
            NSArray *titles = @[@"男", @"女"];
            [self actionSheetWithTitle:@"请选择性别" titles:titles isCan:NO completeBlock:^(NSInteger index) {
                self.model.Gender = titles[index];
                [self reloadData];
            }];
        }
        else if ([text containsString:@"代理区域"]) {
            
        }
        else {
            
            vcname = @"EditUserInfoViewController";
            vc = [NSClassFromString(vcname) new];
            vc.title = text;
        }
    }
    else {
        
        vcname = @"CertificationViewController";
        vc = [NSClassFromString(vcname) new];
        vc.title = text;
    }
    
    if (self.goViewControllerBlock && vcname.length > 0) {
        self.goViewControllerBlock(vc);
    }
}

@end
