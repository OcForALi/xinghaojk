//
//  PatientsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsViewController.h"
#import "PatientsView.h"
#import "SearchView.h"
#import "PatientsViewModel.h"
#import "InvitationContactViewController.h"

@interface PatientsViewController ()

@property (nonatomic, strong) PatientsView *patientsView;
@property (nonatomic, strong) UIView *headerImgView;

@property (nonatomic ,strong) NSDictionary *allDict;

@end

@implementation PatientsViewController
@synthesize headerImgView;
@synthesize patientsView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"我的患者";
    
    [self initNav];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getList];
}

-(void)initNav{
    
    UIImage *selectedImage=[UIImage imageNamed: @"Patients_Add"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBar:)];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

-(void)rightBar:(UIBarButtonItem *)sender{
    
    InvitationContactViewController *invitationView = [[InvitationContactViewController alloc] init];
    invitationView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:invitationView animated:YES];
    
}

- (void)setupSubviews {
    
    [self initSearchView];
    [self initHeaderImgView];
    [self initPatientsView];
}

- (void)initSearchView {
    
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    searchView.textField.placeholder = @"请输入患者的名字";
    [self.view addSubview:searchView];
    
    [searchView setSearchBlock:^(NSString *searchTextString) {
        
        if (searchTextString.length > 0) {
            NSLog(@"%@", searchTextString);
            
            NSMutableArray *searchArray = [NSMutableArray array];
            
            NSArray *array = [self.allDict allKeys];
            
            for (int i = 0; i < array.count; i++) {
                
                for (PatientsModel *model in [self.allDict objectForKey:array[i]]) {
                    
                    NSLog(@"名字-%@，手机号 %@",model.membername,model.mobile);
                    
                    if ([model.membername containsString:searchTextString] || [model.mobile containsString:searchTextString]) {
                        
                        [searchArray addObject:model];
                        
                    }
                    
                }
                
            }

            if (searchArray.count != 0) {
                NSDictionary *dict = @{@"initils":searchArray};
                self.patientsView.dictDataSource = dict;
            }else{
                [self.view makeToast:@"没有搜索到该患者"];
            }
            
        }else{
            self.patientsView.dictDataSource = self.allDict;
        }
        
    }];
}

- (void)initHeaderImgView {
    
    headerImgView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, 100)];
    headerImgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerImgView];
    
    NSArray *imgs = @[@"PatientsNewImg", @"PatientsGroupImg", @"PatientsMsgImg"];
    NSArray *titles = @[@"新患者", @"标签分组", @"群发消息"];
    CGFloat btnWidth = ScreenWidth / imgs.count;
    UIButton *imgBtn;
    for (int i = 0; i < imgs.count; i++) {
        
        UIImage *img = [UIImage imageNamed:imgs[i]];
        imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(btnWidth * i, 0, btnWidth, 0);
        [headerImgView addSubview:imgBtn];
        
        @weakify(self);
        [[imgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

            @strongify(self);
            NSString *nameString = @"NewPatientViewController";
            if (i == 1) {
                nameString = @"GroupEditorViewController";
            }
            else if (i == 2) {
                nameString = @"GroupOfMessageViewController";
            }
            
            BaseViewController *viewController = [NSClassFromString(nameString) new];
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, img.size.width, img.size.height)];
        imgView.centerX = imgBtn.width / 2;
        imgView.image = img;
        imgView.userInteractionEnabled = NO;
        [imgBtn addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 10, btnWidth, 15)];
        titleLabel.text = titles[i];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [imgBtn addSubview:titleLabel];
        
        imgBtn.height = CGRectGetMaxY(titleLabel.frame) + 15;
        
    }
    
    headerImgView.height = imgBtn.height;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    [headerImgView addSubview:lineView];
}

- (void)initPatientsView {
    
    patientsView = [[PatientsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImgView.frame) + 1, ScreenWidth, 0) style:UITableViewStyleGrouped];
    patientsView.height = ScreenHeight - patientsView.y - self.navHeight - self.tabBarHeight;
    [self.view addSubview:patientsView];
    
    @weakify(self);
    [patientsView setCollectBlock:^(BOOL isCollect, NSString *idString) {
     
        @strongify(self);
        [[PatientsViewModel new] setAttentionWithMid:idString isAttention:isCollect Complete:^(id object) {
            [self.view makeToast:object];
            [self getList];
        }];
    }];
    
    [patientsView setGoViewController:^(UIViewController *viewController) {
       
        @strongify(self);
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

- (void)getList {
    
    [[PatientsViewModel new] getDrPatientWithIds:@[] complete:^(id object) {
        
        self.patientsView.dictDataSource = object;
        
        self.allDict = object;
        
    }];
}

@end
