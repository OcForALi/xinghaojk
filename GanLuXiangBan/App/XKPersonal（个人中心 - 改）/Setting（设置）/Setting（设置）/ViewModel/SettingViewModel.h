//
//  SettingViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "AboutModel.h"

@interface SettingViewModel : HttpRequest

- (void)getHelpComplete:(void (^)(id object))complete;

- (void)getAboutComplete:(void (^)(AboutModel *model))complete;

@end
