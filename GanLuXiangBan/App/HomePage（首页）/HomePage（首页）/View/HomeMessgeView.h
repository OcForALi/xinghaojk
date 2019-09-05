//
//  HomeMessgeView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"
#import "HomeModel.h"

typedef NS_ENUM(NSInteger, HomeShowList) {
    HomeShowNormal,
    HomeShowAssistant
};

@interface HomeMessgeView : BaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic, assign) HomeShowList showType;

//@property (nonatomic, strong) UIView *headerView;

-(void)addData:(NSArray *)array;

@end
