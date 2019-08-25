//
//  SortView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortView : UIView

//排序类型 0 = 默认 1 = 价格 2 = 销量
@property (nonatomic ,assign) NSInteger sort;

//降序
@property (nonatomic ,assign) BOOL isDesc;

@property (nonatomic, strong) void (^sortBlock)(NSInteger sort , BOOL isDesc);

@end
