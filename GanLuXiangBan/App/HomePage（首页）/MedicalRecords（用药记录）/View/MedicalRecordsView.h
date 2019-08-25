//
//  MedicalRecordsView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalRecordsModel.h"

typedef void(^MedicalRecordPushBlock)(MedicalRecordsModel *model);

@interface MedicalRecordsView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) MedicalRecordPushBlock pushBlock;

-(void)addData:(NSArray *)array;

@end
