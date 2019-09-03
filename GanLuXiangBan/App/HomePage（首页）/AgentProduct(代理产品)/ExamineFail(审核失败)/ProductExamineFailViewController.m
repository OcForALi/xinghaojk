//
//  ProductExamineFailViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ProductExamineFailViewController.h"
#import "AgentProductRequest.h"

@interface ProductExamineFailViewController ()

@end

@implementation ProductExamineFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self request];
    
}

- (void)request{
    
    AgentProductRequest *agentRequest = [AgentProductRequest new];
    
    [agentRequest getAgDrugLstStart:@"2" Page:@"1" size:@"10" :^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
    } ];
    
}


@end
