//
//  DrugList.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "DrugListModel.h"

typedef void(^DrugListPushBlock)(NSString *drugID);

typedef void(^CollectBlock)(DrugListModel *model);

typedef void(^SelectedDeleteBlock)(NSArray *array);

@interface DrugList : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) BaseTableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,retain) NSMutableArray *addedList;

@property (nonatomic ,copy) DrugListPushBlock pushBlock;

@property (nonatomic ,copy) CollectBlock collectBlock;

@property (nonatomic ,copy) SelectedDeleteBlock selectedDeleteBlock;

@property (nonatomic ,assign) NSInteger Type;

@property (nonatomic ,copy) NSArray *drug_idArray;

@property (nonatomic ,retain) NSMutableArray *pkids;

@property (nonatomic, assign) BOOL showAll;

-(void)addData:(NSArray *)array;

@end
