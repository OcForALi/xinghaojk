//
//  QuickReplyView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"

typedef void(^InputTextBlock)(NSString *inputTextString);

typedef void(^OperationBlock)(NSString *operationString);

typedef void(^QuickReplySelectChanged)(NSArray *list);

@interface QuickReplyView : BaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) InputTextBlock inputTextBlock;

@property (nonatomic ,copy) OperationBlock operationBlock;

@property (nonatomic, strong) QuickReplySelectChanged selectChangeBlock;

@property (nonatomic ,assign) NSInteger typeInteger;

@property (nonatomic ,retain) NSMutableArray *pkids;

-(void)addData:(NSArray *)array;

-(void)allPkids;

-(void)removePkids;

@end
