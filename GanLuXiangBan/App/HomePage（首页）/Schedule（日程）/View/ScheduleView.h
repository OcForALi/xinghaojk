//
//  ScheduleView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"

//跳转页面
typedef void(^SchedulePushBlock)(NSString *pushString);

@interface ScheduleView : BaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) SchedulePushBlock pushBlock;

-(void)addData:(NSArray *)array;

@end
