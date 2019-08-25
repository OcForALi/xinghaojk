//
//  HomeAddArticleModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ArticleType) {
    ArticleTitle,
    ArticleSubTitle,
    ArticleTags,
    ArticleParagraph,
    ArticlePicture
};

@interface HomeAddArticleModel : NSObject

@property (nonatomic, assign) NSInteger drnews_id;

@property (nonatomic, assign) ArticleType type;

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) id data;

@end
