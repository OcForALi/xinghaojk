//
//  IntegralDetailsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface IntegralDetailsView : BaseTableView

@property (nonatomic, strong) NSDictionary *dictDataSource;
@property (nonatomic, strong) NSArray *keys;

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
