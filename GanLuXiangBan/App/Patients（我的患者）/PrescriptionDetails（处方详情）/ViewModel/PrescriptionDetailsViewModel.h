//
//  PrescriptionDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface PrescriptionDetailsViewModel : HttpRequest

- (void)getElectronRecipeDetail:(NSString *)idStirng complete:(void (^)(id object))complete;

@end
