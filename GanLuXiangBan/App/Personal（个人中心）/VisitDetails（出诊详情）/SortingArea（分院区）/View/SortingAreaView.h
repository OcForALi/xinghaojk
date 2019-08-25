//
//  SortingAreaView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "SortingAreaModel.h"

@interface SortingAreaView : BaseTableView

@property (nonatomic, strong) void (^deleteBlock)(SortingAreaModel *model);
@property (nonatomic, strong) void (^addBlock)(NSString *textString);

@end
