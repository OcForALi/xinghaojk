//
//  HomeArticleSaveModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeArticlePageModel : NSObject
@property (nonatomic, assign) NSInteger drnews_id;
@property (nonatomic, assign) NSInteger number;//编号，顺序由小到大，用户可以编辑排序 ,
@property (nonatomic, copy) NSString *content;//文本内容
@property (nonatomic, copy) NSString *file_path;//图片文件路径
@property (nonatomic, strong) UIImage *image;
@end


@interface HomeArticleSaveModel : NSObject
@property (nonatomic, assign) NSInteger pkid;//pkid
@property (nonatomic, copy) NSString *NewsTitle;//文章标题
@property (nonatomic, copy) NSString *NewsSTitle;//文章副标题
@property (nonatomic, copy) NSString *Tags;//文章标签
@property (nonatomic, copy) NSString *Content;//文章内容
@property (nonatomic, assign) NSInteger drid;//医生ID
@property (nonatomic, copy) NSString *drname;//医生名称
@property (nonatomic, copy) NSString *drtitle;//职称
@property (nonatomic, copy) NSString *cust_name;//科室
@property (nonatomic, copy) NSString *hospital_name;//所属医院
@property (nonatomic, assign) NSInteger clike;//实际阅读人数（医生读取）
@property (nonatomic, assign) NSInteger Sclike;//患者（读取）阅读人数
@property (nonatomic, copy) NSString *ReleaseOn;//发布时间
@property (nonatomic, copy) NSString *createOn;//发布时间
@property (nonatomic, copy) NSString *UpOn;//发布时间
@property (nonatomic, strong) NSArray *PageInfos;
@end
