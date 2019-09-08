//
//  DoctorPerformancView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorPerformancView.h"
#import "PerformanceModel.h"
#import "DrugCell.h"
#import "PrescriptionCell.h"

@interface DoctorPerformancView ()

@property (nonatomic, assign) float cellHeight;

@end

@implementation DoctorPerformancView

- (void)setModel:(PerformanceModel *)model {
    
    _model = model;
    
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.model.recipeModels.count > 0) {
        return self.model.recipeModels.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model.drugModels.count > 0) {
        return self.model.drugModels.count;
    }
    
    PerformanceRecipesModel *model = self.model.recipeModels[section];
    return model.drugModels.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.model.drugModels.count > 0) {
        
        DrugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugCell"];
        if (cell == nil) {
            
            cell = [[DrugCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DrugCell"];
        }

        cell.model = self.model.drugModels[indexPath.row];
        self.cellHeight = cell.cellHeight;
        return cell;
    }

    if (indexPath.row == 0) {
        
        PrescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrescriptionCell"];
        if (cell == nil) {
            
            cell = [[PrescriptionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PrescriptionCell"];
        }
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWidth);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.recipeModels[indexPath.section];
        self.cellHeight = cell.cellHeight;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = kMainTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = kMainTextColor;
    }
    
    PerformanceRecipesModel *model = self.model.recipeModels[indexPath.section];
    PerformanceDrugsModel *drugsModel = model.drugModels[indexPath.row - 1];
    cell.textLabel.text = drugsModel.drug_name;
    cell.detailTextLabel.text = [@"X " stringByAppendingString:drugsModel.num];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWidth);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.model.recipeModels.count > 0) {
        
        if (indexPath.row == 0) {
            return self.cellHeight;
        }
        
        return 45;
    }
    
    return self.cellHeight;
}

@end
