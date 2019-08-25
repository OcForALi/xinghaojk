//
//  HomeModel.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(void)setDrinfo:(NSDictionary *)drinfo{
    
    _drinfo = drinfo;
    
    DrInfoModel *model = [DrInfoModel new];
    [model setValuesForKeysWithDictionary:drinfo];
    
    self.drinfoModel = model;
    
}

@end
