//
//  MessageListViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListView.h"
#import "MessageListViewModel.h"

@interface MessageListViewController ()

@property (nonatomic, strong) MessageListView *messageListView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation MessageListViewController
@synthesize messageListView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"消息列表";
    self.page = 1;
    [self getDataSrouceWithPage:self.page];
}


#pragma mark - lazy
- (MessageListView *)messageListView {
    
    if (!messageListView) {
        
        messageListView = [[MessageListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:messageListView];
        
        messageListView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self.page ++;
            [self getDataSrouceWithPage:self.page];
        }];
    }
    
    return messageListView;
}


#pragma mark - request
- (void)getDataSrouceWithPage:(NSInteger)page {
    
    NSString *pageString = [NSString stringWithFormat:@"%@", @(page)];
    [[MessageListViewModel new] getDrNoticeListWithPage:pageString complete:^(id object) {
        
        NSArray *list = object;
        [self.messageListView.mj_footer endRefreshing];
        self.messageListView.dataSources = list;
        if (list && list.count > 0) {
            MessageListModel *model = object[0];
            if ([model.total intValue] == self.messageListView.dataSources.count) {
                [self.messageListView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    }];
}

@end
