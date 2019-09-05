//
//  MyCardViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "MyCardModel.h"

@interface MyCardViewController : BaseViewController

@property (nonatomic, strong) void (^selectBackCard)(MyCardModel *model);

@end
