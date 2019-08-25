//
//  HomeAddArticleExplainController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeAddArticleExplainController.h"

@interface HomeAddArticleExplainController ()
@property (weak, nonatomic) IBOutlet UILabel *txtLabel;

@end

@implementation HomeAddArticleExplainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新建文章";
    
    NSString *content = self.txtLabel.text;
    NSString *txt = @"service@xinghaojk.com";
    NSRange range = [content rangeOfString:txt];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:content];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.txtLabel.attributedText = att;
}

@end
