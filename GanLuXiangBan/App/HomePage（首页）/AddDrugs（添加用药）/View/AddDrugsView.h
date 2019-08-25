//
//  AddDrugsView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDosageModel.h"
#import "AddCountView.h"
#import "BaseTextField.h"
#import "PickerListView.h"
#import "CustomTextView.h"

typedef void(^BackBlock)(NSString *back);

typedef void(^AddDurgDosageBlock)(DrugDosageModel *drugModel);

typedef void(^AddDrugPushBlock)(PickerType type);

@interface AddDrugsView : UIView <UITextViewDelegate>

@property (nonatomic ,copy) BackBlock backBlock;

@property (nonatomic ,copy) AddDrugPushBlock pushBlock;

@property (nonatomic ,copy) AddDurgDosageBlock addDurgDosageBlock;

@property (nonatomic ,strong) DrugDosageModel *model;

//@property (nonatomic ,strong) UIScrollView *scorllView;

@property (nonatomic ,assign) NSInteger type;

///药品名字
//@property (nonatomic ,strong) UILabel *drugNameLabel;
///规格
//@property (nonatomic ,strong) UILabel *standardLabel;
///数量
//@property (nonatomic ,strong) AddCountView *use_numView;
@property (nonatomic ,strong) UILabel *use_numView;
@property (nonatomic ,assign) NSInteger use_numInteger;
///一日 几次
@property (nonatomic ,strong) AddCountView *day_useView;
@property (nonatomic ,assign) NSInteger day_useInteger;
///一日 用量
//@property (nonatomic ,strong) BaseTextField *day_use_numTextField;
///单位
@property (nonatomic ,strong) UILabel *unit_nameLabel;
@property (nonatomic ,copy) NSArray *unitsArray;
@property (nonatomic, strong) PickerListView *unit_nameListView;
///用法
@property (nonatomic ,strong) UILabel *use_typeLabel;
@property (nonatomic ,copy) NSArray *use_typeArray;
@property (nonatomic, strong) PickerListView *use_typeListView;

//周期
@property (nonatomic ,strong) UILabel *use_cycleLabel;

//药品数量
@property (nonatomic ,assign) NSInteger use_drugNum;
@property (nonatomic ,strong) AddCountView *use_drugNumView;

///备注
//@property (nonatomic ,strong) CustomTextView *remarkTextView;
//@property (nonatomic ,strong) UILabel *residueLabel;// 输入文本时剩余字数

@property (nonatomic ,strong) UIButton *collectionButton;
@property (nonatomic ,strong) UIButton *deleteButton;

@end
