//
//  GroupEditorViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupEditorViewController.h"
#import "GroupEditorViewModel.h"
#import "GroupEditorView.h"

@interface GroupEditorViewController ()

@property (nonatomic, strong) GroupEditorView *groupEditorView;

@end

@implementation GroupEditorViewController
@synthesize groupEditorView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if (!self.title || self.title.length == 0) {
        self.title = @"分组管理";
    }
    
    if (self.pickGroup) {
        WS(weakSelf)
        [self addNavRightTitle:@"确定" complete:^{
            [weakSelf finishPickerGroup];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getLabelList];
}

- (void)finishPickerGroup {
    if (self.pickerGroupBlock) {
        NSArray *list = self.groupEditorView.dataSources;
        NSMutableArray *datas = [[NSMutableArray alloc] init];
        for (GroupEditorModel *item in list) {
            if (item.isSelect) {
                [datas addObject:item];
            }
        }
        self.pickerGroupBlock(datas);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (GroupEditorView *)groupEditorView {
    
    if (!groupEditorView) {
        
        CGFloat height = ScreenHeight - self.navHeight - 50;
        if (self.pickGroup) {
            height += 50;
        }
        groupEditorView = [[GroupEditorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) style:UITableViewStyleGrouped];
        groupEditorView.picker = self.pickGroup;
        [self.view addSubview:groupEditorView];
        
        @weakify(self);
        [groupEditorView setGoViewControllerBlock:^(UIViewController *viewController) {
            @strongify(self);
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
        if (self.pickGroup == NO) {
            UIButton *addGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addGroupBtn.frame = CGRectMake(0, ScreenHeight - 50 - self.navHeight, ScreenWidth, 50);
            addGroupBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            addGroupBtn.backgroundColor = kMainColor;
            [addGroupBtn setTitle:@"新建分组" forState:UIControlStateNormal];
            [addGroupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:addGroupBtn];
            
            [[addGroupBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self.navigationController pushViewController:[NSClassFromString(@"GroupAddViewController") new] animated:YES];
            }];
        }
    }
    
    return groupEditorView;
}

#pragma mark - request

- (BOOL)haveGroup:(NSString *)label {
    if (self.pickGroupIdS && self.pickGroupIdS.count > 0) {
        for (NSString *item in self.pickGroupIdS) {
            if ([label isEqualToString:item]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)loadGroupDatas:(NSArray *)list {
    if (!list) {
        list = @[];
    }
    if (self.pickGroup) {
        for (GroupEditorModel *item in list) {
            if ([self haveGroup:item.label]) {
                item.isSelect = YES;
            }
        }
    }
    self.groupEditorView.dataSources = list;
}

- (void)getLabelList {
    WS(weakSelf)
    [[GroupEditorViewModel new] getLabelListComplete:^(id object) {
        [weakSelf loadGroupDatas:object];
    }];
}

@end
