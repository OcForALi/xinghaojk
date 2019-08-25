//
//  PrescriptionDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PrescriptionDetailsView.h"
#import "PrescriptionInfoCell.h"
#import "DruguseCell.h"

@interface PrescriptionDetailsView ()

@property (nonatomic, assign) CGFloat infoCellHeight;
@property (nonatomic, assign) CGFloat druguseCellHeight;

@property (nonatomic ,strong) UIView *footerView;

@end

@implementation PrescriptionDetailsView

@synthesize footerView;

- (void)setModel:(PrescriptionDetailsModel *)model {
    
    _model = model;
    self.tableFooterView = self.footerView;

    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 + self.model.druguses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 信息
    if (indexPath.row == 0) {
        
        PrescriptionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrescriptionInfoCell"];
        if (cell == nil) {
            cell = [[PrescriptionInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrescriptionInfoCell"];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        cell.model = self.model;
        self.infoCellHeight = cell.cellHeight;
        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        if (indexPath.row == 1) {
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = [NSString stringWithFormat:@"临床诊断: %@", self.model.check_result];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        }
        else {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.textLabel.text = @"Rp";
            cell.textLabel.textColor = [UIColor blackColor];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWidth);
        }
        
        return cell;
    }
    else if (indexPath.row < self.model.druguses.count + 3) {
        
        NSInteger index = indexPath.row - 3;
        
        DruguseModel *model = self.model.druguses[index];
        
        DruguseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DruguseCell"];
        if (cell == nil) {
            cell = [[DruguseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DruguseCell"];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        cell.tag = index;
        cell.model = model;
        self.druguseCellHeight = cell.cellHeight;
        return cell;
    }
    else {
        
        return nil;
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return self.infoCellHeight;
    }
    else if (indexPath.row == 1) {
        return 45;
    }
    else if (indexPath.row == 2) {
        return 50;
    }
    else if (indexPath.row < self.model.druguses.count + 3) {
        return self.druguseCellHeight;
    }
    
    return 45;
}

- (UIView *)footerView {
  
     if (!footerView) {
         
         footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 102)];
         footerView.backgroundColor = [UIColor whiteColor];
         
         UIView *BGView = [UIView new];
         BGView.layer.borderWidth = 1;
         BGView.layer.borderColor = RGB(255, 0, 0).CGColor;
         [footerView addSubview:BGView];
         
         BGView.sd_layout
         .rightSpaceToView(footerView, 15)
         .topSpaceToView(footerView, 15)
         .widthIs(250)
         .heightIs(85);
         
         UILabel *doctLabel = [UILabel new];
         doctLabel.text = [NSString stringWithFormat:@"医生: %@", self.model.recipe_drname];
         doctLabel.font = [UIFont systemFontOfSize:14];
         doctLabel.textColor = RGB(255, 0, 0);
         doctLabel.textAlignment = NSTextAlignmentCenter;
         [BGView addSubview:doctLabel];
         
         doctLabel.sd_layout
         .leftEqualToView(BGView)
         .rightEqualToView(BGView)
         .topSpaceToView(BGView, 10)
         .heightIs(15);
         
         UILabel *hospitalLabel = [UILabel new];
         
         if ([self.model.channel integerValue] == 0) {
             hospitalLabel.text = @"鼎康慈桦互联网医院";
         }else{
             hospitalLabel.text = @"广州东泰医疗门诊部电子专用章";
         }
         hospitalLabel.textColor = RGB(255, 0, 0);
         hospitalLabel.font = [UIFont systemFontOfSize:14];
         hospitalLabel.textAlignment = NSTextAlignmentCenter;
         [BGView addSubview:hospitalLabel];
         
         hospitalLabel.sd_layout
         .leftEqualToView(BGView)
         .rightEqualToView(BGView)
         .topSpaceToView(doctLabel, 10)
         .heightIs(14);
         
         UILabel *dateLabel = [UILabel new];
         dateLabel.text = self.model.date;
         dateLabel.font = [UIFont systemFontOfSize:14];
         dateLabel.textColor = RGB(255, 0, 0);
         dateLabel.textAlignment = NSTextAlignmentCenter;
         [BGView addSubview:dateLabel];
         
         dateLabel.sd_layout
         .leftEqualToView(BGView)
         .rightEqualToView(BGView)
         .topSpaceToView(hospitalLabel, 10)
         .heightIs(14);
         
     }
    
    return footerView;
    
}

@end
