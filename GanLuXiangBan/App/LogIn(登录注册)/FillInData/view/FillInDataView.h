//
//  FillInDataView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FillInDataBlock)(NSMutableArray *array);

typedef void(^ActionSheetCompleteBlock)(NSInteger index);

@interface FillInDataView : UIView <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic ,retain) UITableView *myTable;

@property (nonatomic ,strong) NSMutableArray *dataSountArray;

@property (nonatomic ,copy) FillInDataBlock fillInDataBlock;

@property (nonatomic, strong) UIActionSheet *sheet;

@property (nonatomic, copy) NSString *selDepartmentString;

/// 提示框回调
@property (nonatomic, copy) ActionSheetCompleteBlock complete;

@property (nonatomic, copy) void (^goViewControllerBlock)(UIViewController *viewController);

@end
