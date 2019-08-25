//
//  GroupOfMessageView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

@interface GroupOfMessageView : BaseTableView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) void (^goViewControllerBlock)();
@property (nonatomic, strong) NSString *typeString;

@end
