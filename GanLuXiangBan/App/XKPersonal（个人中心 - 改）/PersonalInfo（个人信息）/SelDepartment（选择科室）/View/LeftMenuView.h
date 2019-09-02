//
//  LeftMenuView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/22.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "DrugModel.h"

#define CurrentLineColor [UIColor colorWithHexString:@"0xc6c6c6"]

@interface LeftMenuView : BaseTableView <UITextFieldDelegate>

@property (nonatomic, assign) BOOL showDisease;

@property (nonatomic, assign) NSInteger selectIndex;

#pragma mark - Block
@property (nonatomic, strong) void (^backBlock)(NSString *nameString);
@property (nonatomic, strong) void (^didSelectBlock)(DrugModel *sec, DrugModel *row);

@end
