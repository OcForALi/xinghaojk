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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model.drugModels.count > 0) {
        return self.model.drugModels.count;
    }
    
    return self.model.recipeModels.count;
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

    PrescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrescriptionCell"];
    if (cell == nil) {

        cell = [[PrescriptionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PrescriptionCell"];
    }
    
    self.cellHeight = cell.cellHeight;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

@end
