//
//  HomeViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeRequest.h"
#import "SDCycleScrollView.h"
#import "QRCodeViewController.h"
#import "ScheduleViewController.h"
#import "MyStudioViewController.h"
#import "HomeMessgeView.h"
#import "EvaluationViewController.h"
#import "CertificationViewModel.h"
#import "HomeMessgeModel.h"
#import "MessageViewController.h"
#import "SignViewController.h"
#import "LogInRequest.h"
#import "AppDelegate.h"

#import "HomeAssistantController.h"
#import "HomeArticleViewController.h"

#import "AgentProductViewController.h"
#import "CheckAchievementViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic ,retain) HomeRequest *homeRequest;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic ,strong) UIImageView *doctorView;

@property (nonatomic ,strong) UIView *toolView;
///头像
@property (nonatomic ,strong) UIImageView *headImageView;
///患者数
@property (nonatomic ,strong) UILabel *patientLabel;
///评价数
@property (nonatomic ,strong) UILabel *evaluateLabel;

@property (nonatomic ,retain) BannerModel *bannerModel;

@property (nonatomic ,retain) HomeModel *homeModel;

@property (nonatomic ,strong) HomeMessgeView *homeMessgeView;

@property (nonatomic ,strong) UIView *signView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic ,assign) NSInteger page;

@end

@implementation HomeViewController

@synthesize bannerView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.page = 1;
    
    self.homeModel = [HomeModel new];
    
    [self request];
    
    [self initUI];

    [self refresh];
    
    [self requestList];
    
    [self block];
    
//    [self Sign];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackgroundStopTimer) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterForegroundStartTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)showAssistant:(HomeAssistantModel *)model {
    HomeAssistantController *assistant = [HomeAssistantController new];
    assistant.hidesBottomBarWhenPushed = YES;
    assistant.model = model;
    [self.navigationController pushViewController:assistant animated:YES];
}

-(void)action{
    [self request];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //开启定时器
    [self applicationEnterForegroundStartTimer];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self applicationEnterBackgroundStopTimer];
    
}

-(void)initUI{
    
    [self bannerView];
    
    [self initDoctorView];
    
    [self initToolView];
    
    self.homeMessgeView = [HomeMessgeView new];
    [self.view addSubview:self.homeMessgeView];
    
    self.homeMessgeView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.toolView, 50)
    .bottomSpaceToView(self.view, 0);
    
}

- (void)applicationEnterBackgroundStopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.bannerView) {
        [self.bannerView toggleCycleScrollViewStatus:NO];
    }
}

- (void)applicationEnterForegroundStartTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    if (self.bannerView) {
        [self.bannerView toggleCycleScrollViewStatus:YES];
    }
}

- (void)requestList{
    
    WS(weakSelf)
    
    [self.homeRequest getRankingLstPage:1 size:self.page*10 :^(HttpGeneralBackModel *generalBackModel) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in generalBackModel.data) {
            
            HomeNewModel *model = [HomeNewModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        if (array.count > 0) {
            [weakSelf.homeMessgeView.dataSource removeAllObjects];
        }
        
        [weakSelf.homeMessgeView addData:array];
        weakSelf.homeMessgeView.NoMessageView.hidden = array.count > 0 ? YES : NO;
        
        [weakSelf.homeMessgeView.myTable.mj_header endRefreshing];
        [weakSelf.homeMessgeView.myTable.mj_footer endRefreshing];
        
    }];
    
}

- (void)request {
    BOOL logined = GLAppDelegate.isLogined;
    if (!logined) {
        return;
    }

    self.bannerModel = [BannerModel new];
    self.homeRequest = [HomeRequest new];
    WS(weakSelf)
    
    [self.homeRequest getUserAgentInfo:^(HttpGeneralBackModel *generalBackModel) {
       
        if (generalBackModel.data[@"head"] != nil && [generalBackModel.data[@"head"] rangeOfString:@"http"].location !=NSNotFound) {
            SetUserDefault(UserHead, generalBackModel.data[@"head"]);
        }
        
    }];
    
    [self.homeRequest getPersonalStatics:^(HttpGeneralBackModel *generalBackModel) {

        NSInteger drNum = 0;
        NSInteger amount = 0;
        if (generalBackModel == nil || generalBackModel.data == nil) {
            
            drNum = 0;
            amount = 0;
        }
        else {
            drNum = [generalBackModel.data[@"dr_num"] integerValue];
            amount = [generalBackModel.data[@"order_amount"] integerValue];
        }
        
        weakSelf.patientLabel.text = [NSString stringWithFormat:@"（%ld）", drNum];
        weakSelf.evaluateLabel.text = [NSString stringWithFormat:@"（%ld）", amount];
    }];
    
    if (!GetUserDefault(UserHead)) {
        weakSelf.headImageView.image = [UIImage imageNamed:@"Home_HeadDefault"];
    }
    else{
        [weakSelf.headImageView sd_setImageWithURL:[NSURL URLWithString:GetUserDefault(UserHead)]];
    }
//    [self.homeRequest getIndexInfo:^(HomeModel *model) {
//
//        if (model) {
//            weakSelf.patientLabel.text = [NSString stringWithFormat:@"（%@）",@(model.patientNum)];
//            weakSelf.evaluateLabel.text = [NSString stringWithFormat:@"（%@）",@(model.evaluateNum)];
//            weakSelf.homeModel = model;
//
//            if (!GetUserDefault(UserHead)) {
//                weakSelf.headImageView.image = [UIImage imageNamed:@"Home_HeadDefault"];
//            }
//            else{
//                [weakSelf.headImageView sd_setImageWithURL:[NSURL URLWithString:GetUserDefault(UserHead)]];
//            }
//
//            if (model.indexUnread > 0) {
//                UITabBarItem *firstItem = weakSelf.tabBarController.tabBar.items[model.indexUnread-1];
//                firstItem.badgeCenterOffset = CGPointMake(0, 0);
//                [firstItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
//            }
//            else{
//                UITabBarItem *firstItem = weakSelf.tabBarController.tabBar.items[0];
//                [firstItem clearBadge];
//            }
//
//            UIImageView *imageView = [self.view viewWithTag:101];
//            if (model.orderUnread > 0) {
//                [imageView showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
//            }
//            else{
//                [imageView clearBadge];
//            }
//        }
//
//    }];
    
//    [self.homeRequest getUnreadForMyPatient:^(HttpGeneralBackModel *generalBackModel) {
//
//        if ([generalBackModel.data isEqualToString:@"0"]) {
//
//            UITabBarItem *firstItem = weakSelf.tabBarController.tabBar.items[1];
//            [firstItem clearBadge];
//
//        }else{
//
//            UITabBarItem *firstItem = weakSelf.tabBarController.tabBar.items[1];
//            firstItem.badgeCenterOffset = CGPointMake(0, 0);
//            [firstItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
//
//        }
//
//    }];
    
//    if (self.homeMessgeView.showType == HomeShowAssistant) {
//        [HomeRequest getAssistantList:^(HttpGeneralBackModel *generalBackModel) {
//            if (generalBackModel && generalBackModel.retcode == 0 && weakSelf.homeMessgeView.showType == HomeShowAssistant) {
//                [weakSelf.homeMessgeView.dataSource removeAllObjects];
//
//                NSMutableArray *array = [NSMutableArray array];
//                if (generalBackModel.data) {
//                    NSArray *res = generalBackModel.data;
//                    for (NSDictionary *dic in res) {
//                        HomeAssistantModel *item = [HomeAssistantModel new];
//                        [item setValuesForKeysWithDictionary:dic];
//                        [array addObject:item];
//                    }
//                }
//                [weakSelf.homeMessgeView addData:array];
//
//                weakSelf.homeMessgeView.NoMessageView.hidden = array.count > 0 ? YES : NO;
//                weakSelf.homeMessgeView.myTable.mj_footer.hidden = YES;
//
//                [weakSelf.homeMessgeView.myTable.mj_header endRefreshing];
//                [weakSelf.homeMessgeView.myTable.mj_footer endRefreshing];
//            }
//        }];
//    }
//    else {
//        [self.homeRequest getMsgListLoad_type:@"reload" :^(HttpGeneralBackModel *generalBackModel) {
//            if (generalBackModel && generalBackModel.retcode == 0 && weakSelf.homeMessgeView.showType == HomeShowNormal) {
//                [weakSelf.homeMessgeView.dataSource removeAllObjects];
//
//                NSMutableArray *array = [NSMutableArray array];
//
//                for (NSDictionary *dict in generalBackModel.data) {
//
//                    HomeMessgeModel *model = [HomeMessgeModel new];
//                    [model setValuesForKeysWithDictionary:dict];
//                    [array addObject:model];
//
//                }
//
//                [weakSelf.homeMessgeView addData:array];
//
//                weakSelf.homeMessgeView.NoMessageView.hidden = array.count > 0 ? YES : NO;
//
//                [weakSelf.homeMessgeView.myTable.mj_header endRefreshing];
//                [weakSelf.homeMessgeView.myTable.mj_footer endRefreshing];
//                weakSelf.homeMessgeView.myTable.mj_footer.hidden = NO;
//            }
//        }];
//    }
    
//    [self.homeRequest getIsSign:^(HttpGeneralBackModel *generalBackModel) {
//
////        NSInteger signInteger = [generalBackModel.data integerValue];
////
////        if (signInteger == 0) {
////
////            [weakSelf Sign];
////
////        }else{
////
////        }
////
////
//    }];
    
//    [[HomeRequest new] getNoticeList:^(HttpGeneralBackModel *generalBackModel) {
//
//    }];
    
}

-(void)refresh{
    
    WS(weakSelf)
    self.homeMessgeView.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [weakSelf requestList];
        
    }];
    
    self.homeMessgeView.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [weakSelf requestList];
        
    }];
}

-(void)block{
    
//    WS(weakSelf);
//    self.homeMessgeView.pushBlock = ^(HomeMessgeModel *model, HomeAssistantModel *assistantModel) {
//        
//        if (model) {
//            [[HomeRequest new] getZeroPushNum:model.mid :^(HttpGeneralBackModel *generalBackModel) {
//                
//            }];
//            
//            MessageViewController *messageView = [[MessageViewController alloc] init];
//            messageView.mid = [NSString stringWithFormat:@"%@",model.mid];
//            messageView.msg_source = [NSString stringWithFormat:@"%@",model.msg_source];
//            messageView.patientName = model.name;
//            messageView.msg_flag = model.msg_source;
//            messageView.msgId = [NSString stringWithFormat:@"%@", model.msg_id];
//            messageView.title = model.name;
//            messageView.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:messageView animated:YES];
//        }
//        else if (assistantModel) {
//            [weakSelf showAssistant:assistantModel];
//        }
//        
//    };
    
}

- (SDCycleScrollView *)bannerView {
    
    if (!bannerView) {
        
        bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, ScreenHeight * 0.214, ScreenWidth, ScreenWidth / 2.5)];
        bannerView.delegate = self;
        bannerView.autoScrollTimeInterval = 5;
        bannerView.backgroundColor = [UIColor whiteColor];
        bannerView.backgroundColor = RGB(233, 233, 233);
        bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        bannerView.clipsToBounds = YES;
        [self.view addSubview:bannerView];
        
        bannerView.sd_layout
        .topSpaceToView(self.view, -kNavbarSafeHeight)
        .centerXEqualToView(self.view)
        .widthIs(ScreenWidth)
        .heightIs(ScreenWidth / 2.5);
        
        //获取轮播图
        self.homeRequest = [HomeRequest new];
        
        NSMutableArray *imageArray = [NSMutableArray arrayWithArray:@[@"banner"]];
//
        self.bannerView.localizationImageNamesGroup = imageArray;
        
        WS(weakSelf)
        [self.homeRequest getBanner:^(HttpGeneralBackModel *model) {

            NSArray *array = model.data;

            for (NSDictionary *dict in array) {

                [imageArray addObject:[dict objectForKey:@"file_path"]];

            }

            weakSelf.bannerView.imageURLStringsGroup = imageArray;

        }];
        
    }
    
    return bannerView;
}

-(void)initDoctorView{
    
    self.doctorView = [UIImageView new];
    self.doctorView.image = [UIImage imageNamed:@"HomeBG"];
    self.doctorView.contentMode = UIViewContentModeScaleAspectFill;
    self.doctorView.clipsToBounds = YES;
    self.doctorView.userInteractionEnabled = YES;
    [self.view addSubview:self.doctorView];
    
//    if (IS_iPhoneX) {
//
//        self.doctorView.sd_layout
//        .topSpaceToView(self.view, -20)
//        .centerXEqualToView(self.view)
//        .widthIs(ScreenWidth)
//        .heightIs(ScreenHeight * 0.214);
//
//    }else{
    
        self.doctorView.sd_layout
        .topSpaceToView(bannerView, 0)
        .centerXEqualToView(self.view)
        .widthIs(ScreenWidth)
        .heightIs(ScreenHeight * 0.08);
        
//    }
    
//    UILabel *label = [UILabel new];
//    label.text = @"首页";
//    label.font = [UIFont systemFontOfSize:24];
//    label.textColor = [UIColor whiteColor];
//    [self.doctorView addSubview:label];
//
//    if (IS_iPhoneX) {
//
//        label.sd_layout
//        .centerXEqualToView(self.doctorView)
//        .topSpaceToView(self.doctorView, 70)
//        .heightIs(18);
//        [label setSingleLineAutoResizeWithMaxWidth:200];
//
//    }else{
//
//        label.sd_layout
//        .centerXEqualToView(self.doctorView)
//        .topSpaceToView(self.doctorView, 30)
//        .heightIs(18);
//        [label setSingleLineAutoResizeWithMaxWidth:200];
//
//    }
    
    self.headImageView = [UIImageView new];
    if (!GetUserDefault(UserHead)) {
        self.headImageView.image = [UIImage imageNamed:@"Home_HeadDefault"];
    }else{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:GetUserDefault(UserHead)]];
    }
    [self.headImageView.layer setMasksToBounds:YES];
    [self.headImageView.layer setCornerRadius:ScreenWidth*0.08];
    self.headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(head:)];
    [self.headImageView addGestureRecognizer:headTap];
    
    [self.view addSubview:self.headImageView];
    
    self.headImageView.sd_layout
    .leftSpaceToView(self.view, ScreenWidth*0.05)
    .topSpaceToView(self.bannerView, -10)
    .widthIs(ScreenWidth * 0.16)
    .heightEqualToWidth();
    
    NSArray *imageArray = @[@"Home_Patient",@"Home_Comment"];
    NSArray *titleArray = @[@"医生",@"开单金额"];
    
    for (int i = 0; i < imageArray.count; i++) {

        UIImageView *iconView = [UIImageView new];
//        iconView.image = [UIImage imageNamed:imageArray[i]];
//        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconView.userInteractionEnabled = YES;
        iconView.tag = i + 200;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doctor:)];
        [iconView addGestureRecognizer:tap];
        [self.doctorView addSubview:iconView];

        iconView.sd_layout
        .leftSpaceToView(self.headImageView, 30 + i * ScreenWidth * 0.3)
        .centerYEqualToView(self.doctorView)
        .widthIs(100)
        .heightIs(30);
        
        UILabel *label = [UILabel new];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        [self.doctorView addSubview:label];
        
        label.sd_layout
        .centerYEqualToView(self.doctorView)
        .leftSpaceToView(self.headImageView, 30 + i * ScreenWidth * 0.3)
        .heightIs(12);
        [label setSingleLineAutoResizeWithMaxWidth:100];
        
        if (i == 0) {
            
            self.patientLabel = [UILabel new];
            self.patientLabel.textColor = [UIColor whiteColor];
            self.patientLabel.font = [UIFont systemFontOfSize:14];
            [self.doctorView addSubview:self.patientLabel];
            
            self.patientLabel.sd_layout
            .leftSpaceToView(label, 5)
            .centerYEqualToView(self.doctorView)
            .heightIs(14);
            [self.patientLabel setSingleLineAutoResizeWithMaxWidth:100];
            
//            UIView *lineView = [UIView new];
//            lineView.backgroundColor = RGB(235, 235, 235);
//            [self.doctorView addSubview:lineView];
//
//            lineView.sd_layout
//            .leftSpaceToView(self.patientLabel, ScreenWidth * 0.1)
//            .topSpaceToView(self.doctorView, 5)
//            .bottomSpaceToView(self.doctorView, 5)
//            .widthIs(0.5);
            
        }else{
            
            self.evaluateLabel = [UILabel new];
            self.evaluateLabel.textColor = [UIColor whiteColor];
            self.evaluateLabel.font = [UIFont systemFontOfSize:14];
            [self.doctorView addSubview:self.evaluateLabel];
            
            self.evaluateLabel.sd_layout
            .leftSpaceToView(label, 5)
            .centerYEqualToView(self.doctorView)
            .heightIs(14);
            [self.evaluateLabel setSingleLineAutoResizeWithMaxWidth:100];
            
        }
        
    }
    
}

-(void)doctor:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag - 200 == 0) {
        
        [self.tabBarController setSelectedIndex:1];
        
    }else{
        
//        EvaluationViewController *evaluationView = [[EvaluationViewController alloc] init];
//        evaluationView.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:evaluationView animated:YES];
        
    }
    
}

-(void)initToolView{
    
    self.toolView = [UIView new];
    self.toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.toolView];
    
    self.toolView.sd_layout
    .topSpaceToView(self.doctorView, 13)
    .centerXEqualToView(self.view)
    .heightIs(88)
    .widthIs(ScreenWidth);
    
    NSArray *imageArray = @[@"Home_Invitation",@"Home_Schedule",@"Home_Studio"];
    NSArray *titleArray = @[@"邀请加入",@"产品代理",@"业绩查看"];
    CGFloat width = ScreenWidth/titleArray.count;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.tag = i + 100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tool:)];
        [imageView addGestureRecognizer:tap];
        [self.toolView addSubview:imageView];
        
        imageView.sd_layout
        .leftSpaceToView(self.toolView, width*i + (width-40)/2)
        .topSpaceToView(self.toolView, ScreenHeight*0.02)
        .widthIs(40)
        .heightEqualToWidth();
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
//        if (i == imageArray.count - 1) {
//            titleLabel.textColor = [UIColor lightGrayColor];
//        }
        [self.toolView addSubview:titleLabel];
        
        titleLabel.sd_layout
        .centerXEqualToView(imageView)
        .topSpaceToView(imageView, 10)
        .widthIs(width)
        .heightIs(14);
    }
    
    self.leftButton = [self menuButton:@"开单排行榜" tag:1];
    [self.view addSubview:self.leftButton];
    self.leftButton.sd_layout.topSpaceToView(self.toolView, 0).leftSpaceToView(self.view, 0).widthRatioToView(self.view, 1).heightIs(50);
    self.leftButton.selected = YES;
//    self.rightButton = [self menuButton:@"药师助理" tag:2];
//    [self.view addSubview:self.rightButton];
//    self.rightButton.sd_layout.topSpaceToView(self.toolView, 0).rightSpaceToView(self.view, 0).widthRatioToView(self.leftButton, 1.0).heightRatioToView(self.leftButton, 1.0);
    
//    self.lineView = [[UIView alloc] init];
//    self.lineView.backgroundColor = kMainColor;
//    [self.view addSubview:self.lineView];
//    self.lineView.sd_layout.topSpaceToView(self.leftButton, -3).widthRatioToView(self.leftButton, 0.8).heightIs(3).centerXEqualToView(self.leftButton);
    
}

- (UIButton *)menuButton:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitleColor:[UIColor colorWithHexString:@"0x999999"] forState:UIControlStateNormal];
    [btn setTitleColor:kMainColor forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchHomeMenu:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)touchHomeMenu:(UIButton *)btn {
    if (![btn isSelected]) {
        if (btn.tag == 2) {
            self.leftButton.selected = NO;
            self.homeMessgeView.showType = HomeShowAssistant;
        }
        else {
            self.rightButton.selected = NO;
            self.homeMessgeView.showType = HomeShowNormal;
        }
        [self.homeMessgeView.dataSource removeAllObjects];
        [self.homeMessgeView.myTable reloadData];
        
        btn.selected = YES;
        self.lineView.sd_resetLayout.topSpaceToView(btn, -3).widthRatioToView(btn, 0.8).heightIs(3).centerXEqualToView(btn);
        
        [self applicationEnterForegroundStartTimer];
    }
}

-(void)tool:(UITapGestureRecognizer *)sender{
    NSInteger tag = sender.view.tag - 100;
    if (tag == 0) {
        
        QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc] init];
        qrCodeVC.model = self.homeModel;
        qrCodeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qrCodeVC animated:YES];
        
    }
    else if (tag == 1) {
        
        AgentProductViewController *agentProductVC = [[AgentProductViewController alloc] init];
        agentProductVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:agentProductVC animated:YES];
        
    }
    else if (tag == 2) {
        
        CheckAchievementViewController *checkAchievementVC = [[CheckAchievementViewController alloc] init];
        checkAchievementVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:checkAchievementVC animated:YES];
        
    }
    else if (tag == 3) {
        
        HomeArticleViewController *vc = [[HomeArticleViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)head:(UITapGestureRecognizer *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotos = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
                //拍照
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

        }
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
        
    }];

    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"从相册选取一张照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            //相册
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
        
    }];

    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [alert addAction:takePhotos];

    [alert addAction:ok];//添加确认按钮
    
    [alert addAction:cancel];//添加取消按钮
    
    //以modal的形式
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        self.headImageView.image = image;
        
        NSData *imageData = UIImageJPEGRepresentation(self.headImageView.image, 0.3);
        
        [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
            
            SetUserDefault(UserHead, object);
            
            [[HomeRequest new] postUpdateDrHeadUrl:object :^(HttpGeneralBackModel *generalBackModel) {
                
            }];
            
        }];
        
        
        
    });
}

-(void)Sign{
    
    if (!self.signView) {
     
        self.signView = [UIView new];
        self.signView.backgroundColor = RGBA(137, 137, 137, 0.7);
        self.signView.userInteractionEnabled = YES;
        self.signView.layer.cornerRadius = 5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signTap:)];
        [self.signView addGestureRecognizer:tap];
        [self.view addSubview:self.signView];
        
        self.signView.sd_layout
        .rightSpaceToView(self.view, -10)
        .topSpaceToView(self.view, 40)
        .widthIs(100)
        .heightIs(40);
        
        UIImageView *signImageView = [UIImageView new];
        signImageView.image = [UIImage imageNamed:@"Home_Sign"];
        signImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.signView addSubview:signImageView];
        
        signImageView.sd_layout
        .leftSpaceToView(self.signView, 10)
        .centerYEqualToView(self.signView)
        .widthIs(30)
        .heightEqualToWidth();
        
        UILabel *signLabel = [UILabel new];
        signLabel.textColor = [UIColor whiteColor];
        signLabel.text = @"签到";
        signLabel.font = [UIFont systemFontOfSize:16];
        [self.signView addSubview:signLabel];
        
        signLabel.sd_layout
        .rightSpaceToView(self.signView, 20)
        .centerYEqualToView(self.signView)
        .heightIs(16);
        [signLabel setSingleLineAutoResizeWithMaxWidth:60];
        
    }
    
}

-(void)signTap:(UITapGestureRecognizer *)sender{
    
    //[self.signView removeFromSuperview];
    
    SignViewController *signView = [[SignViewController alloc] init];
    signView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:signView animated:YES];
    
}

@end
