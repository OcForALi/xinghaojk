//
//  PrescriptionAddView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecDrugsModel.h"
#import "BaseTextField.h"
//#import "AddDrugsView.h"

typedef void(^PrescriptionPushBlock)(NSArray *pushVC);

typedef void(^OpenBlock)(NSString *openString);

typedef void(^PrescriptionUsePushBlock)(UIViewController *vc);

typedef void(^RequestBlock)(NSString *check_id , NSString *recipelist_id);

@interface PrescriptionAddView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,copy) RecDrugsModel *model;

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) PrescriptionPushBlock pushBlock;

@property (nonatomic ,copy) OpenBlock openBlock;

@property (nonatomic ,copy) RequestBlock requestBlock;

@property (nonatomic, strong) PrescriptionUsePushBlock useBlock;

///临床诊断
@property (nonatomic ,strong) UILabel *diagnosisLabel;
///临床诊断内容
@property (nonatomic ,strong) UILabel *diagnosisContentLabel;
///症状标签
@property (nonatomic ,strong) UIView *symptomsView;

@property (nonatomic ,assign) float labeX;

//@property (nonatomic ,strong) AddDrugsView *addDrugsView;

@property (nonatomic ,assign) NSInteger type;

@end
