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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.dataSources[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.model.Name;
        }
        else {
            cell.detailTextLabel.text = self.model.Gender;
        }
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.model.HospitalName;
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.model.CustName;
        }
        else {
            cell.detailTextLabel.text = self.model.Title;
        }
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.model.Remark;
        }
        else {
            cell.detailTextLabel.text = self.model.Introduction;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    if (indexPath.section > 1) {
        
        NSArray *viewControllerNames = @[@[@"EditUserInfoViewController",@""],
                                         @[@"SelHospitalViewController", @"SelDepartmentViewController", @""],
                                         @[@"ModifyViewController", @"ModifyViewController"],
                                         @[@"CertificationViewController", @"CertificationViewController"]];
        NSString *viewControllerName = viewControllerNames[indexPath.section][indexPath.row];
        
        // 前往控制器
        if (self.goViewControllerBlock && ![viewControllerName isEqualToString:@""]) {
            
            BaseViewController *viewController = [NSClassFromString(viewControllerName) new];
            viewController.title = self.dataSources[indexPath.section][indexPath.row];
            
            if ([viewControllerName isEqualToString:@"ModifyViewController"]) {
             
                ModifyViewController *vc = (ModifyViewController *)viewController;
                vc.contentString = self.model.Introduction;
                if (indexPath.row == 0) {
                    vc.contentString = self.model.Remark;
                }
            }
            
            if (self.goViewControllerBlock) {
                self.goViewControllerBlock(viewController);
            }
        }
        else {
            
            // 选择性别
            if (indexPath.section == 0) {
                NSArray *titles = @[@"男", @"女"];
                [self actionSheetWithTitle:@"请选择性别" titles:titles isCan:NO completeBlock:^(NSInteger index) {
                    self.model.Gender = titles[index];
                    [self reloadData];
                }];
            }
            else {
                
                NSArray *titles = @[@"主任医师", @"副主任医师", @"主治医师", @"医师"];
                [self actionSheetWithTitle:@"请选择职称" titles:titles isCan:NO completeBlock:^(NSInteger index) {
                    self.model.Title = titles[index];
                    [self reloadData];
                }];
            }
        }
    }
}

@end
