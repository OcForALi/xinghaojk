//
//  DocCircleExtentionController.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"

#import "DocCircleModel.h"

typedef NS_ENUM(NSInteger, DocCircleShowType) {
    DocCircleShowTypeDoc,
    DocCircleShowTypeNum,
    DocCircleShowTypeMoney
};

@interface DocCircleExtentionController : BaseViewController

@property (nonatomic, assign) DocCircleShowType type;

@property (nonatomic, strong) DocCircleModel *model;

@end
