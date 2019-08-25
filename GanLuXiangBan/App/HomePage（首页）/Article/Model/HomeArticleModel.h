//
//  HomeArticleModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"


@interface HomeArticleModel : NSObject

@property (nonatomic, assign) NSInteger pkid;//integer  pkid
@property (nonatomic, copy) NSString *NewsTitle;//string   标题
@property (nonatomic, copy) NSString *NewsSTitle;//string   副标题
@property (nonatomic, copy) NSString *Tags;//string   关键字
@property (nonatomic, copy) NSString *Content;//string   内容
@property (nonatomic, assign) NSInteger drid;//integer  医生ID
@property (nonatomic, assign) NSInteger clike;//integer  真实点击数
@property (nonatomic, assign) NSInteger Sclike;//integer  患者点击数
@property (nonatomic, assign) NSInteger status;//integer  状态
@property (nonatomic, copy) NSString *UpOn;//string   修改日期
@property (nonatomic, copy) NSString *createOn;//string   创建日期
@property (nonatomic, copy) NSString *ReleaseOn;//string   发布日期
@property (nonatomic, assign) NSInteger isDelete;//integer  是否删除

@end
