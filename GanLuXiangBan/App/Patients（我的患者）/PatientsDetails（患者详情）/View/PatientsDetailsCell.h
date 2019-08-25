//
//  PatientsDetailsCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientsVisitDetailsModel.h"

@interface PatientsDetailsCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) void(^patientsDetailRecordImageBlock)(PatientsVisitDetailsModel *model, NSInteger index);

@end
