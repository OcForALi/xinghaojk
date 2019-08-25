//
//  GroupEditCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupEditCell : UITableViewCell

@property (nonatomic, assign) CGFloat editCellHeight;
@property (nonatomic, strong) void (^btnClick)(NSInteger index);

@end
