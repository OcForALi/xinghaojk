//
//  CityModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cityId;

- (void)setModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
