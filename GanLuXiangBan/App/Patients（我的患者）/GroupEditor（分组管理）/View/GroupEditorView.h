//
//  GroupEditorView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface GroupEditorView : BaseTableView

@property (nonatomic, assign) BOOL picker;

@property (nonatomic, strong) void (^goViewControllerBlock)(UIViewController *viewController);

@end
