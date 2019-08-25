//
//  HelpWebViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HelpWebViewController.h"

@interface HelpWebViewController ()

@end

@implementation HelpWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:webView];
    webView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kTabbarSafeBottomMargin, 0);
    
    if (self.bodyString) {
        [webView loadHTMLString:self.bodyString baseURL:nil];
    }
    else if (self.url) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    
}

@end
