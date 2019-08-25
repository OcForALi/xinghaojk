//
//  GroupOfMessageViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupOfMessageViewController.h"
#import "GroupOfMessageView.h"
#import "GroupOfMessageViewModel.h"
#import "RecipientViewController.h"

@interface GroupOfMessageViewController ()

@property (nonatomic, strong) GroupOfMessageView *groupOfMessageView;
@property (nonatomic, strong) NSArray *groupIds;
@property (nonatomic, strong) NSArray *userIds;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) UIButton *sendMsgBtn;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation GroupOfMessageViewController
@synthesize groupOfMessageView;
@synthesize tipLabel;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"新建群发";
    self.index = @"0";
    [self initGroupOfMessageView];
    [self getCount];
    
    @weakify(self);
    [self addNavRightTitle:@"消息列表" width:66 complete:^{
        @strongify(self);
        [self.navigationController pushViewController:[NSClassFromString(@"MessageListViewController") new] animated:YES];
    }];
}

- (void)initGroupOfMessageView {
    
    // 消息
    groupOfMessageView = [[GroupOfMessageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
    [self.view addSubview:groupOfMessageView];
    
    // 前往控制器
    @weakify(self);
    [groupOfMessageView setGoViewControllerBlock:^{
       
        @strongify(self);
        RecipientViewController *viewController = [RecipientViewController new];
        viewController.index = [self.index integerValue];
        viewController.groupIds = self.groupIds;
        viewController.users = self.users;
        [viewController setSelectType:^(NSInteger index, NSArray *groupIds, NSArray *userIds, NSArray *users, NSString *nameString) {
            
            self.index = [NSString stringWithFormat:@"%@", @(index)];
            self.groupIds = groupIds;
            self.userIds = userIds;
            self.users = users;
            self.groupOfMessageView.typeString = nameString;
            
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
    // 发送消息按钮
    self.sendMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendMsgBtn.frame = CGRectMake(0, CGRectGetMaxY(groupOfMessageView.frame), ScreenWidth, 50);
    self.sendMsgBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.sendMsgBtn.backgroundColor = kMainColor;
    [self.sendMsgBtn setTitle:@"发送消息（0/3）" forState:UIControlStateNormal];
    [self.sendMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sendMsgBtn];
    
    [[self.sendMsgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self sendMessage];
    }];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sendMsgBtn.y - 25, ScreenWidth, 15)];
    tipLabel.text = @"为了避免影响患者，每天仅限3次";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
}

#pragma mark - request
- (void)sendMessage {
    NSString *text = groupOfMessageView.textView.text;
    if (!text || text.length == 0) {
        [self.view makeToast:@"请输入群发消息内容"];
        return;
    }
    
    self.sendMsgBtn.enabled = NO;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.groupIds];
    BOOL isAttention = NO;
    if ([self.groupIds containsObject:@(-1)]) {
        
        isAttention = YES;
        [arr removeObject:@(-1)];
        self.groupIds = arr;
    }
    
    NSInteger type = [self.index integerValue];
    WS(weakSelf)
    [[GroupOfMessageViewModel new] sendMessageWithContent:text reciveType:type labels:self.groupIds mids:self.userIds isAttention:isAttention complete:^(NSInteger code, NSString *msg) {
        
        if (code == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = msg;
                if (!message) {
                    message = @"发送成功";
                }
                [[UIApplication sharedApplication].keyWindow makeToast:message];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
        else {
            [weakSelf.view makeToast:msg];
            weakSelf.sendMsgBtn.enabled = YES;
        }
        
    }];
}

- (void)getCount {
    
    @weakify(self);
    [[GroupOfMessageViewModel new] getCountComplete:^(id object) {
     
        @strongify(self);
        NSString *sendString = [NSString stringWithFormat:@"发送消息（%@/%@）", object[@"count"], object[@"total"]];
        [self.sendMsgBtn setTitle:sendString forState:UIControlStateNormal];
        self.tipLabel.text = [NSString stringWithFormat:@"为了避免影响患者，每天仅限%@次", object[@"total"]];
        
        if ([object[@"count"] intValue] == [object[@"total"] intValue]) {
            
            self.sendMsgBtn.enabled = NO;
            [self.sendMsgBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }];
}

@end
