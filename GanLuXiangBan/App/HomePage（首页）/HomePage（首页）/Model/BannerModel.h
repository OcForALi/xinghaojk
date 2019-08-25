//
//  BannerModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/15.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

///轮播图
@property (nonatomic ,copy) NSString *file_path;

@property (nonatomic ,copy) NSString *pkid;

@end
