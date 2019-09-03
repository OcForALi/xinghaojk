//
//  AgentVarietyViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentVarietyViewController.h"
#import "AgentVarietyView.h"

@interface AgentVarietyViewController ()

@property (nonatomic, strong) AgentVarietyView *agentVarietyView;

@end

@implementation AgentVarietyViewController
@synthesize agentVarietyView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setTitle:@"代理品种"];
    [self initialization];
}

// 初始化
- (void)initialization {
    
    self.agentVarietyView.dataSources = @[@[@"药品名（通用名)", @"规格：", @"厂家："], @[@"药品名（通用名)", @"规格：", @"厂家："]];
}

#pragma mark - lazy
- (AgentVarietyView *)agentVarietyView {
    
    if (!agentVarietyView) {
        
        agentVarietyView = [[AgentVarietyView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        agentVarietyView.height = ScreenHeight - self.navHeight;
        agentVarietyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:agentVarietyView];
    }
    
    return agentVarietyView;
}

@end
