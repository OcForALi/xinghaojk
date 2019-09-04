//
//  ProductExamineFailView.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseView.h"
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ProductExamineFailPushBlock)(ProductModel *model);

typedef void(^ReconsiderBlock)(ProductModel *model);

@interface ProductExamineFailView : BaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) ProductExamineFailPushBlock pushBlock;

@property (nonatomic ,copy) ReconsiderBlock reconsiderBlock;

-(void)addData:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
