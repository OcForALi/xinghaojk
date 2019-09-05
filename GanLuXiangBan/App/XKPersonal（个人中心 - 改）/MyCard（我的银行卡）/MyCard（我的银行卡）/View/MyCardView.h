//
//  MyCardView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "MyCardModel.h"

@interface MyCardView : BaseTableView

@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) void (^selectCardBlock)(MyCardModel *model);
@property (nonatomic, strong) void (^defaultCardBlock)(NSString *cardNumber);

@end
