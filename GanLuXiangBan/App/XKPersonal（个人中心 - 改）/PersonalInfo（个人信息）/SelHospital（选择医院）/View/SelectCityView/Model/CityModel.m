//
//  CityModel.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (void)setModelWithDict:(NSDictionary *)dict {
    
    self.name = [dict objectForKey:@"n"];
    self.cityId = [dict objectForKey:@"v"];
}

@end
