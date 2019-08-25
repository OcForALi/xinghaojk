//
//  AboutViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AboutViewController.h"
#import "SettingViewModel.h"

@interface AboutViewController ()

@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation AboutViewController
@synthesize versionLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getAbout];
}

- (void)setupSubviewWithModel:(AboutModel *)model {
    
    UIView *headBgView = [UIView new];
    headBgView.frame = CGRectMake(0, 0, ScreenWidth, 155);
    headBgView.backgroundColor = kMainColor;
    [self.view addSubview:headBgView];
    
    // 用户昵称
    versionLabel = [UILabel new];
    versionLabel.font = [UIFont systemFontOfSize:17];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.text = [NSString stringWithFormat:@"版本号: %@", App_Version];
    [headBgView addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@-20);
        make.height.equalTo(@20);
        make.left.right.equalTo(headBgView);
    }];
    
    // 用户头像
    UIImageView *headImgView = [UIImageView new];
    headImgView.layer.cornerRadius = 40;
    headImgView.layer.masksToBounds = YES;
    headImgView.userInteractionEnabled = NO;
    headImgView.backgroundColor = [UIColor whiteColor];
    headImgView.image = [UIImage imageNamed:@"Public_Logo"];
    [headBgView addSubview:headImgView];
    self.logoView = headImgView;
    
    [headImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headBgView);
        make.top.equalTo(@20);
        make.height.width.equalTo(@80);
    }];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 155, ScreenWidth, 0)];
    webView.height = ScreenHeight - webView.y - self.navHeight;
    webView.backgroundColor = [UIColor whiteColor];
    [webView setScalesPageToFit:YES];
    [webView loadHTMLString:model.remark baseURL:nil];
    [self.view addSubview:webView];
}

- (void)getAbout {
    WS(weakSelf)
    [[SettingViewModel new] getAboutComplete:^(AboutModel *model) {
        [weakSelf setupSubviewWithModel:model];
//        weakSelf.versionLabel.text = model.version;
        if (model.logo) {
            [weakSelf.logoView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"Public_Logo"]];
        }
    }];
}

@end
