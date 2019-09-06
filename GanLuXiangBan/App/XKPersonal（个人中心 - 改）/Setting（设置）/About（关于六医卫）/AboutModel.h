//
//  AboutModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface AboutModel : BaseModel

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *remark;

@end
