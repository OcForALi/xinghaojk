//
//  WithdrawalsView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "MyCardModel.h"

@interface WithdrawalsView : BaseTableView

@property (nonatomic, strong) NSString *pointString;
@property (nonatomic, strong) MyCardModel *myCardModel;

#pragma mark - Block
@property (nonatomic, strong) void (^goViewController)(UIViewController *viewController);
@property (nonatomic, strong) void (^echangeBlock)(NSString *number, NSString *bankId);

@end
