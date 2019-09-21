//
//  QRCodeViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "QRCodeViewController.h"
#import "NinaPagerView.h"
#import "QRPatientViewController.h"
#import "QRDoctorViewController.h"
#import <WXApi.h>
#import "HttpRequest.h"

#import "FamousDoctorViewController.h"

@interface QRCodeViewController ()<NinaPagerViewDelegate>

@property (nonatomic ,assign) NSInteger countInteger;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请";
    
    [self initNav];
    
    self.countInteger = 0;
    
}

-(void)initNav{
    
    UIImage *selectedImage=[UIImage imageNamed: @"Home_Share"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBar:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

-(void)rightBar:(UIBarButtonItem *)sender{
    
    [self alert];
    
}

-(void)setModel:(HomeNewModel *)model{
    
    _model = model;
    
    [self addChildViewController];
    
    [self initUI];
    
}

-(void)addChildViewController{
    
    QRPatientViewController *qrPatientView = [[QRPatientViewController alloc] init];
    qrPatientView.model = self.model;
    [self addChildViewController:qrPatientView];
    
    QRDoctorViewController *qrDoctorView = [[QRDoctorViewController alloc] init];
    qrDoctorView.model = self.model;
    [self addChildViewController:qrDoctorView];
    
//    FamousDoctorViewController *famous = [[FamousDoctorViewController alloc] init];
////    qrDoctorView.model = self.model;
//    [self addChildViewController:famous];
}

-(void)initUI{
    
    NSArray *titleArray = @[@"邀请医生",@"邀请同行"];
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) WithTitles:titleArray WithVCs:self.childViewControllers];
    ninaPagerView.ninaPagerStyles = 0;
    ninaPagerView.nina_navigationBarHidden = NO;
    ninaPagerView.selectTitleColor = kMainColor;
    ninaPagerView.unSelectTitleColor = [UIColor blackColor];
    ninaPagerView.underlineColor = kMainColor;
    ninaPagerView.selectBottomLinePer = 0.8;
    ninaPagerView.delegate = self;
    [self.view addSubview:ninaPagerView];
    
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject{
    
    if (currentPage == 0) {
        self.countInteger = 0;
    }else{
        self.countInteger = 2;
    }
    
    if (currentPage < 2) {
        [self initNav];
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)alert{
    
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"请选择分享方式"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                         }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    WS(weakSelf)
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"分享到微信朋友圈" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                             [weakSelf shareWithWX:WXSceneTimeline];
                                                             
                                                         }];
    [deleteAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"发送给微信好友" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           [weakSelf shareWithWX:WXSceneSession];
                                                           
                                                       }];
    [saveAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)shareWithWX:(int)scene {
    NSString *title = [NSString stringWithFormat:@"我是%@，", GetUserDefault(UserName)];
    NSString *url = [NSString stringWithFormat:@"http://nkwxtest.6ewei.com/yy/views/agent.html#/?agid=%@", GetUserDefault(UserID)];
    if (self.countInteger == 2) {
        title = [title stringByAppendingString:@"邀请您加入幸好健康代理 商联盟，服务最权威的男性健康专科管理平台。"];
        url = [url stringByAppendingString:@"&type=0"];
    }
    else {
        title = [title stringByAppendingString:@"邀请您加入幸好健康代理商联盟，服务最权威的男性健康专科管理平台。"];
        url = [url stringByAppendingString:@"&type=1"];
    }
    WS(weakSelf)
    [[HttpRequest new] shortUrl:url complete:^(NSString *shortUrl) {
        if (shortUrl && shortUrl.length > 0) {
            [weakSelf shareToWx:scene title:title url:shortUrl];
        }
        else {
            [weakSelf shareToWx:scene title:title url:url];
        }
    }];
}

- (void)shareToWx:(int)scene title:(NSString *)title url:(NSString *)url {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = url;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

@end
