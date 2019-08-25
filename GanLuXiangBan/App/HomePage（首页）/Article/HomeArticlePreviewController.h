//
//  HomeArticlePreviewController.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"

#import "HomeArticleSaveModel.h"

@interface HomeArticlePreviewController : BaseViewController

@property (nonatomic, strong) HomeArticleSaveModel *model;

@property (nonatomic, assign) BOOL canEdit;

@end
