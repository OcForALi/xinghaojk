//
//  CitySelectView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySelectView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * leftTableView;

@property (nonatomic, strong) UITableView * rightTableView;

@property (nonatomic ,strong) UIView *BGView;

@property (nonatomic ,strong) UILabel *cityLabel;

/**
 滑到了第几组
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, strong) NSIndexPath *cityIndexPath;

//用来处理leftTableView的cell的点击事件引起的rightTableView的滑动和用户拖拽rightTableView的事件冲突
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, retain) NSMutableArray *provinceArray;

@property (nonatomic, retain) NSMutableArray *cityArray;

@end
