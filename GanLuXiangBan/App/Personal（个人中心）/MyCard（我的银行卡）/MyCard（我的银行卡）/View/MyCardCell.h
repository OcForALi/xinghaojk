//
//  MyCardCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCardModel.h"

@interface MyCardCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) MyCardModel *model;

#pragma mark - Block
@property (nonatomic, strong) void (^defaultCardBlock)();

@end
