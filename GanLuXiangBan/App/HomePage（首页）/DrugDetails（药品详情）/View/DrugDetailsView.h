//
//  DrugDetailsView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDetailsModel.h"
#import "SDCycleScrollView.h"

@interface DrugDetailsView : UIView <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic ,copy) DrugDetailsModel *model;

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *titleArray;

@property (nonatomic ,retain) NSMutableArray *contentArray;

@property (nonatomic, strong) UIView *headerView;
//药品轮播图
@property (nonatomic, strong) SDCycleScrollView *bannerView;
//药品名字
@property (nonatomic, strong) UILabel *drugNameLabel;
//药品规格
@property (nonatomic, strong) UILabel *drugStandardLabel;
//药品厂
@property (nonatomic, strong) UILabel *drugProducerLabel;


@end
