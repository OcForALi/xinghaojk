//
//  RecDrugsView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecDrugsModel.h"
#import "BaseTextField.h"
//#import "AddDrugsView.h"

typedef void(^RecDrugsPushBlock)(NSArray *pushVC);

typedef void(^OpenBlock)(NSString *openString);

typedef void(^RequestBlock)(NSString *check_id , NSString *recipelist_id);

typedef void(^RecDrugsUsePushBlock)(UIViewController *vc);

@interface RecDrugsView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic ,copy) RecDrugsModel *model;

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic ,strong) NSMutableArray *dataSource;

@property (nonatomic ,copy) RecDrugsPushBlock pushBlock;

@property (nonatomic ,copy) OpenBlock openBlock;

@property (nonatomic ,copy) RequestBlock requestBlock;

@property (nonatomic, copy) RecDrugsUsePushBlock useBlock;

///编号
@property (nonatomic ,strong) UILabel *serialNumberLabel;
///编号内容
@property (nonatomic ,strong) UILabel *serialNumberContentLabel;
///日期
@property (nonatomic ,strong) UILabel *dateLabel;
///日期内容
@property (nonatomic ,strong) UILabel *dateContentLabel;
///姓名
@property (nonatomic ,strong) BaseTextField *nameTextField;
///年龄
@property (nonatomic ,strong) BaseTextField *ageTextField;
///性别
@property (nonatomic ,strong) BaseTextField *genderTextField;
//性别button
@property (nonatomic ,strong) UIButton *genderBtn;
///临床诊断
@property (nonatomic ,strong) UILabel *diagnosisLabel;
@property (nonatomic ,strong) UIView *diagnosisView;
///临床诊断内容
@property (nonatomic ,strong) UILabel *diagnosisContentLabel;
///症状标签
@property (nonatomic ,strong) UIView *symptomsView;
//添加药品
@property (nonatomic ,strong) UIView *addView;

@property (nonatomic ,assign) float labeX;

//@property (nonatomic ,strong) AddDrugsView *addDrugsView;

@property (nonatomic, strong) void (^RecDrugsEditBlock)();

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic, assign) BOOL canEdit;

//- (void)resetTouchEnable:(BOOL)enable;

- (void)reloadDatas:(NSArray *)datas;

@end
