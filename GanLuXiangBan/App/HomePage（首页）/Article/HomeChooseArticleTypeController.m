//
//  HomeChooseArticleTypeController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeChooseArticleTypeController.h"

@interface HomeChooseArticleTypeController ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *paraView;
@property (weak, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paraTopConstraint;

@end

@implementation HomeChooseArticleTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.hideTitle) {
        [self.view setNeedsUpdateConstraints];
        self.titleView.hidden = YES;
        self.paraTopConstraint.constant = 20;
    }
}

- (IBAction)touchAddTitle {
    if (self.chooseArticleTypeBlock) {
        self.chooseArticleTypeBlock(ArticleTitle);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchAddParagraph {
    if (self.chooseArticleTypeBlock) {
        self.chooseArticleTypeBlock(ArticleParagraph);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchAddPicture {
    if (self.chooseArticleTypeBlock) {
        self.chooseArticleTypeBlock(ArticlePicture);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
