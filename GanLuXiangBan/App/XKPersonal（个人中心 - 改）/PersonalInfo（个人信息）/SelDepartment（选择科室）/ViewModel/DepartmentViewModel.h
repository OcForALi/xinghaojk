//
//  DepartmentViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface DepartmentViewModel : HttpRequest

- (void)getDepartmentComplete:(void (^)(id object))complete;

@end
