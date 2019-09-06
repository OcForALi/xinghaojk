//
//  PersonalInfoModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalInfoModel.h"

@implementation PersonalInfoModel

- (void)setCity_id:(NSString *)city_id {
    
    _city_id = city_id;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    id dataSource = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    int cityId = [city_id intValue];
    for (NSDictionary *dict in dataSource) {
        
        if ([dict[@"v"] intValue] == cityId) {
            self.city = dict[@"n"];
            return;
        }
        
        for (NSDictionary *cDict in dict[@"c"]) {
            
            if ([cDict[@"v"] intValue] == cityId) {
                self.city = cDict[@"n"];
                return;
            }
        }
    }
}

@end



@implementation PersonalStaticModel

@end
