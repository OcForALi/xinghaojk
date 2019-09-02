//
//  CerImgModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/7/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CerImgModel.h"

@implementation CerImgModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.emp_card = @"";
        self.practice_card = @"";
        self.qualification_card = @"";
        self.id_card_face = @"";
        self.id_card_con = @"";
    }
    
    return self;
}

@end
