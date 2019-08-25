//
//  MedicationDetailsView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicationDetailsModel.h"

@interface MedicationDetailsView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,copy)MedicationDetailsModel *model;

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong) UIView *footerView;

///头像
@property (nonatomic ,strong) UIImageView *headImageView;
///名字
@property (nonatomic ,strong) UILabel *patient_nameLabel;
///性别
@property (nonatomic ,strong) UILabel *patient_genderLebl;
///年龄
@property (nonatomic ,strong) UILabel *patient_ageLabel;
///推荐用药
@property (nonatomic ,strong) UILabel *recommendedTimeLabel;
//状态
@property (nonatomic, strong) UILabel *stateLabel;
///总价
@property (nonatomic ,strong) UILabel *totalPriceLabel;

@property (nonatomic ,copy) NSString *status;

@property (nonatomic ,copy) NSString *recipeid;

@property (nonatomic ,strong) UIView *qrcodeBGView;

- (void)reloadStatus:(NSString *)status payStatus:(NSString *)payStatus;

@end
