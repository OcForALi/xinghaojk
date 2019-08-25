//
//  SelectGroupViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelectGroupViewController.h"
#import "SelectGroupView.h"
#import "GroupEditorViewModel.h"

@interface SelectGroupViewController ()

@property (nonatomic, strong) SelectGroupView *selectGroupView;

@end

@implementation SelectGroupViewController
@synthesize selectGroupView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择分组";
    [self getLabelList];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
        
        @strongify(self);
        NSMutableArray *arr = [NSMutableArray array];
        for (GroupEditorModel *model in self.selectGroupView.dataSources) {
            if (model.isSelect) {
                [arr addObject:model.label];
            }
        }
        [self saveLabelWithIds:arr];
    }];
}


#pragma mark - lazy
- (SelectGroupView *)selectGroupView {
    
    if (!selectGroupView) {
        
        selectGroupView = [[SelectGroupView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:selectGroupView];
    }
    
    return selectGroupView;
}

#pragma mark - request
- (void)getLabelList {
    
    [[GroupEditorViewModel new] getLabelListComplete:^(id object) {
        
        NSMutableArray *dataSources = [NSMutableArray array];
        NSArray *temps = [self.selTitleString componentsSeparatedByString:@","];
        for (GroupEditorModel *model in object) {
            
            if ([temps containsObject:model.name]) {
                model.isSelect = YES;
            }
            
            [dataSources addObject:model];
        }
        
        self.selectGroupView.dataSources = dataSources;
    }];
}

- (void)saveLabelWithIds:(NSArray *)ids {
    
    [[GroupEditorViewModel new] saveLabelWithIds:ids mid:self.mid complete:^(id object) {
        
        [self.view makeToast:object];
        if ([object isEqualToString:@"保存成功"]) {
            
            if (self.completeBlock) {
                self.completeBlock(@"");
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
