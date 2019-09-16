//
//  AgentProductViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentProductViewController.h"
#import "NinaPagerView.h"
#import "ProductExamineAdoptViewController.h"
#import "ProductExamineInViewController.h"
#import "ProductExamineFailViewController.h"
#import "AgentProductRequest.h"

@interface AgentProductViewController ()<NinaPagerViewDelegate>

@property (nonatomic ,retain) NSMutableDictionary *itemDict;

@property (nonatomic ,assign) NSInteger black;

@end

@implementation AgentProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品代理";
    
    self.black = 0;
    
    self.itemDict = [NSMutableDictionary dictionaryWithDictionary:@{@"item1":@"",@"item2":@"",@"item3":@""}];
    
    [self request];
    
}

- (void)request{
    
    AgentProductRequest *agentRequest = [AgentProductRequest new];
    
    WS(weakSelf)
    [agentRequest getAgDrugLstStart:1 Page:1 size:10 :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        [weakSelf.itemDict setValue:@([generalBackModel.data[@"adoptNum"] integerValue]) forKey:@"item1"];
        weakSelf.black++;
        [weakSelf back:weakSelf.black];
    } ];
    
    [agentRequest getAgDrugLstStart:0 Page:1 size:10 :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        [weakSelf.itemDict setValue:@([generalBackModel.data[@"checkingNum"] integerValue]) forKey:@"item2"];
        weakSelf.black++;
        [weakSelf back:weakSelf.black];
    } ];
    
    [agentRequest getAgDrugLstStart:2 Page:1 size:10 :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        [weakSelf.itemDict setValue:@([generalBackModel.data[@"failedNum"] integerValue]) forKey:@"item3"];
        weakSelf.black++;
        [weakSelf back:weakSelf.black];
    } ];
    
}

- (void)back:(NSInteger)back{
    
    if (back == 3) {
        
        [self addChildViewController];
        
        [self initUI];
        
    }
    
}

- (void)addChildViewController{
    
    ProductExamineAdoptViewController *productExamineAdoptVC = [[ProductExamineAdoptViewController alloc] init];
    [self addChildViewController:productExamineAdoptVC];
    
    ProductExamineInViewController *productExamineInVC = [[ProductExamineInViewController alloc] init];
    [self addChildViewController:productExamineInVC];
    
    ProductExamineFailViewController *productExamineFailVC = [[ProductExamineFailViewController alloc] init];
    [self addChildViewController:productExamineFailVC];
    
}

- (void)initUI{
    
    NSArray *titleArray = @[
                            [NSString stringWithFormat:@"审核通过(%ld)",[self.itemDict[@"item1"]integerValue]],
                            [NSString stringWithFormat:@"审核中(%ld)",[self.itemDict[@"item2"]integerValue]],
                            [NSString stringWithFormat:@"审核不通过(%ld)",[self.itemDict[@"item3"]integerValue]],
                            ];
    
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


@end
