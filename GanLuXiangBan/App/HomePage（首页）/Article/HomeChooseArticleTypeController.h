//
//  HomeChooseArticleTypeController.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"

#import "HomeAddArticleModel.h"

@interface HomeChooseArticleTypeController : BaseViewController

@property (nonatomic, assign) BOOL hideTitle;

@property (nonatomic, strong) void(^chooseArticleTypeBlock)(ArticleType type);

@end
