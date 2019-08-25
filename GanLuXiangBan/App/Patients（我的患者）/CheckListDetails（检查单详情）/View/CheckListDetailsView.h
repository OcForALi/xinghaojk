//
//  CheckListDetailsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "CheckListDetailsModel.h"

@interface CheckListDetailsView : BaseTableView

@property (nonatomic, strong) CheckListDetailsModel *model;
@property (nonatomic, assign) CGFloat cellHeight;

@end
