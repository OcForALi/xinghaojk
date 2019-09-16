//
//  AgentVarietyViewController.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentVarietyViewController.h"
#import "AgentVarietyViewModel.h"
#import "AgentVarietyView.h"

@interface AgentVarietyViewController ()

@property (nonatomic, strong) AgentVarietyView *agentVarietyView;
@property (nonatomic, assign) int page;

@end

@implementation AgentVarietyViewController
@synthesize agentVarietyView;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.page = 1;
    
    [self setTitle:@"代理品种"];
    [self getList];
}

#pragma mark - lazy
- (AgentVarietyView *)agentVarietyView {
    
    if (!agentVarietyView) {
        
        agentVarietyView = [[AgentVarietyView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        agentVarietyView.y = 0;
        agentVarietyView.height = ScreenHeight - self.navHeight;
        agentVarietyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:agentVarietyView];
    }
    
    return agentVarietyView;
}


#pragma mark - request
- (void)getList {
    
    self.agentVarietyView.dataSources = @[];
    
    AgentVarietyViewModel *viewModel = [AgentVarietyViewModel new];
    [viewModel getListWithPage:self.page complete:^(NSArray * _Nonnull list) {
        self.agentVarietyView.dataSources = list;
    }];
}

@end
