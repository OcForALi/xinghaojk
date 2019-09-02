//
//  PersonalInfoView.h
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "PersonalInfoModel.h"

@interface PersonalInfoView : BaseTableView <UIActionSheetDelegate>

@property (nonatomic, strong) PersonalInfoModel *model;
@property (nonatomic, strong) void (^goViewControllerBlock)(BaseViewController *viewController);

@end
