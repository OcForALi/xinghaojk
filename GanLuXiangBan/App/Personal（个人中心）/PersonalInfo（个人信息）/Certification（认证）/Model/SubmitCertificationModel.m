//
//  SubmitCertificationModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubmitCertificationModel.h"

@implementation SubmitCertificationModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.pkid = @"0";
        self.drid = GetUserDefault(UserID);
    }
    
    return self;
}

@end
