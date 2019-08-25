//
//  DrugModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface DrugModel : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *itmeArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isChecked;

@end
