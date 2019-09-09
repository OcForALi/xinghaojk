//
//  AddProductView.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseView.h"
#import "DrugListModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^AddProductPushBlock)(DrugListModel *model);

@interface AddProductView : BaseView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) AddProductPushBlock pushBlock;

-(void)addData:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
