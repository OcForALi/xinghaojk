//
//  MyPrescriptionView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "MyPrescriptionView.h"

#import "MedicalRecordsTableViewCell.h"

@implementation MyPrescriptionView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MedicalRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedicalRecordsTableViewCell"];
    if (!cell) {
        cell = [[MedicalRecordsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MedicalRecordsTableViewCell"];
    }
    NSInteger row = indexPath.row;
    if (row < self.dataSources.count) {
        cell.model = [self.dataSources objectAtIndex:row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pushBlock) {
        NSInteger row = indexPath.row;
        if (row < self.dataSources.count) {
            MedicalRecordsModel *model = [self.dataSources objectAtIndex:row];
            self.pushBlock(model);
        }
    }
}

@end
