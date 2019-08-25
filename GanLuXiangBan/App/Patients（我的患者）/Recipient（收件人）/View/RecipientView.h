//
//  RecipientView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface RecipientView : BaseTableView

@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSMutableArray *userInfos;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *groupIds;
@property (nonatomic, strong) NSArray *users;

- (void)reloadDatas:(NSArray *)datas;

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
