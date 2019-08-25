//
//  DiseaseLibraryModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DiseaseLibraryModel : BaseModel
///名字
@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,assign) NSInteger pkid;
/// 0 = 已收藏
@property (nonatomic ,assign) NSInteger disease_id;

@property (nonatomic ,assign) NSInteger id;

@end
