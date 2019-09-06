//
//  DoctorsListView.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/7.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"
#import "DoctorsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoctorsListView : BaseTableView

/** 数据 */
@property (nonatomic, strong) NSDictionary *dataDict;

/** 点击事件 */
@property (nonatomic, strong) void (^didSelectBlock)(DoctorsListModel *model);

@end

NS_ASSUME_NONNULL_END
