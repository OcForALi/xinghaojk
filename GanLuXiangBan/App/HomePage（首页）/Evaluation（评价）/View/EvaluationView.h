//
//  EvaluationView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"

@interface EvaluationView : BaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

-(void)addData:(NSArray *)array;

@end
