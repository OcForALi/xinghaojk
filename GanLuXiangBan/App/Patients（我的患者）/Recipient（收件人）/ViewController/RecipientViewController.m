//
//  RecipientViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecipientViewController.h"
#import "RecipientView.h"
#import "GroupEditorViewModel.h"
#import "GroupAddModel.h"

@interface RecipientViewController ()

@property (nonatomic, strong) RecipientView *recipientView;

@end

@implementation RecipientViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"收件人";
    [self.view addSubview:self.recipientView];
    self.recipientView.currentIndex = self.index;
    self.recipientView.groupIds = self.groupIds;
    self.recipientView.users = self.users;
    [self getLabelList];
    
    @weakify(self);
    [self addNavRightTitle:@"确定" complete:^{
     
        @strongify(self);
        //NSMutableString *nameString = [NSMutableString string];
        NSMutableArray *groupIds = [NSMutableArray array];
        NSMutableArray *userNames = [NSMutableArray arrayWithCapacity:1];
        for (GroupEditorModel *model in self.recipientView.contents) {
            
            [groupIds addObject:[NSNumber numberWithInt:[model.label intValue]]];
            [userNames addObject:model.name];
        }
        
        NSMutableArray *userIds = [NSMutableArray array];
        NSArray *users = self.recipientView.userInfos;
        for (GroupAddModel *model in users) {
            [userIds addObject:[NSNumber numberWithInt:[model.mid intValue]]];
            [userNames addObject:model.patient_name];
        }
        
        NSString *tempSting = [userNames componentsJoinedByString:@","];
        if (tempSting.length > 15) {
            tempSting = [tempSting substringWithRange:NSMakeRange(0, 15)];
        }
        
        NSInteger index = self.recipientView.currentIndex;
        if (self.selectType) {
            if (index == 2) {
                tempSting = @"部分不可见";
            }
            self.selectType(index, groupIds, userIds, users, tempSting);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - lazy
- (RecipientView *)recipientView {
    
    if (!_recipientView) {
        
        _recipientView = [[RecipientView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        
        @weakify(self);
        [_recipientView setGoViewControllerBlock:^(UIViewController *viewController) {
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    
    return _recipientView;
}


#pragma mark - request
- (void)getLabelList {
    
    WS(weakSelf)
    [[GroupEditorViewModel new] getLabelListComplete:^(NSArray *list) {
        
        GroupEditorModel *model = [GroupEditorModel new];
        model.name = @"特别关心";
        model.label = @"-1";
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:list];
        [arr addObject:model];
//        weakSelf.recipientView.dataSources = arr;
        [weakSelf.recipientView reloadDatas:arr];
        
    }];
}

@end
