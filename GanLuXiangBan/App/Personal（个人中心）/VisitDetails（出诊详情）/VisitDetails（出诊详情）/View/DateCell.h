//
//  DateCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitDetailsModel.h"

typedef enum : NSUInteger {
    
    AM = 0,
    PM,
    
} VisitTime;

@interface DateCell : UITableViewCell

@property (nonatomic, strong) VisitDetailsModel *model;
@property (nonatomic, assign) int index;

#pragma mark - Block
@property (nonatomic, strong) void (^selectType)(VisitTime visitTime);
@property (nonatomic, strong) void (^selectHospital)(VisitTime visitTime);

@end
