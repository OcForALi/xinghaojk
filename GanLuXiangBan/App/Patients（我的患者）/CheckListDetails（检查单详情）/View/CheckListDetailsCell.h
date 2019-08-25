//
//  CheckListDetailsCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListDetailsModel.h"

@interface CheckListDetailsCell : UITableViewCell

@property (nonatomic, strong) CheckListDetailsModel *model;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat cellHeight;

@end
