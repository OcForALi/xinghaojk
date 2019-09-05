//
//  MyCardModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface MyCardModel : BaseModel

/// ID
@property (nonatomic, strong) NSString *pkid;
/// 银行
@property (nonatomic, strong) NSString *bank;
/// 卡号
@property (nonatomic, strong) NSString *card_no;
/// 是否默认
@property (nonatomic, strong) NSString *is_default;
/// 银行卡图标
@property (nonatomic, strong) NSString *card_ico;
/// 银行卡类型
@property (nonatomic, strong) NSString *card_type;

@end
