//
//  PatientsDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsDetailsView.h"
#import "PatientsInfoCell.h"
#import "GroupListTitleCell.h"
#import "PatientsDetailsCell.h"
#import "CheckListTableViewCell.h"

@interface PatientsDetailsView ()

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation PatientsDetailsView

- (void)setModel:(PatientsDetailsModel *)model {
    
    _model = model;
    [self reloadData];
}

- (void)setUnread:(NSInteger)unread {
    _unread = unread;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    
    NSInteger number = 0;
    for (NSDictionary *dict in self.dataSources) {
        number += [dict[@"Months"] count];
    }
    
    return 1 + number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            PatientsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientsInfoCell"];
            if (cell == nil) {
                cell = [[PatientsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatientsInfoCell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
            
            cell.model = self.model;
            return cell;
        }
        
        NSArray *titles = @[@"分组", @"检查单"];
        CheckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCheckTableViewCell"];
        if (cell == nil) {
            cell = [[CheckListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PatientCheckTableViewCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.title.text = titles[indexPath.row - 1];
        cell.redPoints.hidden = YES;
        cell.date.hidden = YES;
        if (indexPath.row == 1) {
            cell.date.hidden = NO;
            cell.date.text = self.model.label_name;
        }
        else {
            cell.redPoints.hidden = self.unread > 0 ? NO : YES;
        }
        
        return cell;
    }
    
    // 出诊详情
    if (indexPath.row != 0) {
        
        NSInteger count = 0;
        NSInteger currentIndex = indexPath.row - 1;
        NSString *cellIdentifier = @"PatientsDetailsCell";
        if (indexPath.row == 1) {
            
            cellIdentifier = @"PatientsDetailsCell-001";
        }
        else {
            
            NSInteger number = 0;
            count = -1;
            for (NSDictionary *dict in self.dataSources) {

                number += [dict[@"Months"] count];
                count ++;
                if (number + 1 == indexPath.row) {
                    
                    cellIdentifier = @"PatientsDetailsCell-01";
                    currentIndex = 0;
                    count ++;
                    break;
                }
                else if (number + 1 < indexPath.row) {
                    
                    currentIndex = 0;
                    continue;
                }
                else if (number >= indexPath.row) {
                    
                    currentIndex = indexPath.row - (number - [dict[@"Months"] count]) - 1;
                    break ;
                }
            }
        }
        
        NSDictionary *tempDict = self.dataSources[count];
        PatientsVisitDetailsModel *model = tempDict[@"Months"][currentIndex];
        NSArray *imgs = (NSArray *)model.files;
        
        cellIdentifier = [NSString stringWithFormat:@"%@-type%@-imgCount%02zd", cellIdentifier, model.type, imgs.count];
        PatientsDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PatientsDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.dataDict = @{ @"year_month" : tempDict[@"year_month"],
                           @"model" : model };
        self.cellHeight = cell.cellHeight;
        cell.patientsDetailRecordImageBlock = self.patientsDetailViewImageBlock;
        
        return cell;
    }
    
    GroupListTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupListTitleCell"];
    if (cell == nil) {
        cell = [[GroupListTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupListTitleCell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.textLabel.text = @"诊疗记录";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            PatientInfoViewController *vc = [PatientInfoViewController new];
            vc.model = self.model;
            self.goViewControlleBlock(vc);
        }
        else if (indexPath.row == 1) {
            
            CheckListTableViewCell *cell = (CheckListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            SelectGroupViewController *vc = [SelectGroupViewController new];
            vc.mid = self.model.pkid;
            vc.selTitleString = cell.date.text;
            self.goViewControlleBlock(vc);
        }
        else if (indexPath.row == 2) {
            
            CheckListViewController *vc = [CheckListViewController new];
            vc.mid = self.model.pkid;
            self.goViewControlleBlock(vc);
        }
    }
    else {
        
        if (indexPath.section == 1 && indexPath.row > 0) {
            
            PatientsDetailsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            PatientsVisitDetailsModel *detailsModel = cell.dataDict[@"model"];
            
            if ([detailsModel.type intValue] == 1) {
                
                PrescriptionDetailsViewController *vc = [PrescriptionDetailsViewController new];
                vc.idString = detailsModel.id;
                self.goViewControlleBlock(vc);
            }
            else {
                
                TreatmentViewController *vc = [TreatmentViewController new];
                vc.text = detailsModel.content;
                vc.imgs = cell.imgs;
                vc.pkid = detailsModel.id;
                vc.mid = self.model.pkid;
                self.goViewControlleBlock(vc);
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 95;
    }
    else if (indexPath.section == 1 && indexPath.row != 0) {
        return self.cellHeight;
    }
    else return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
