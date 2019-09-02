//
//  SelDepartmentViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelDepartmentViewController.h"
#import "LeftMenuView.h"
#import "RightMenuView.h"
#import "DepartmentViewModel.h"

@interface SelDepartmentViewController ()

/// 左菜单
@property (nonatomic, strong) LeftMenuView *leftMenuView;
/// 右菜单
@property (nonatomic, strong) RightMenuView *rightMenuView;

@end

@implementation SelDepartmentViewController

@synthesize leftMenuView;
@synthesize rightMenuView;

- (void)viewDidLoad {

    [super viewDidLoad];

    // 获取数据
    [self getDepartment];
    // 右按钮
    @weakify(self);
    [self addNavRightTitle:@"确认" complete:^{

        @strongify(self);
        DrugModel *model = self.rightMenuView.dataSources[self.rightMenuView.selectIndex];
        [self backWithModel:model];
    }];

    self.view.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    
}

#pragma mark - request
- (void)getDepartment {
    
    DepartmentViewModel *viewModel = [DepartmentViewModel new];
    [viewModel getDepartmentComplete:^(id object) {
       
        if (![object isKindOfClass:[NSError class]]) {
            
            NSString *currentId = self.selectIndex;
            self.leftMenuView.dataSources = object;
            if ([currentId integerValue] > 0) {
                
                for (int i = 0; i < self.leftMenuView.dataSources.count; i++) {
                    
                    int index = 0;
                    DrugModel *tempModel = self.leftMenuView.dataSources[i];
                    for (DrugModel *model in tempModel.itmeArray) {
                        
                        index ++;
                        if ([model.id intValue] == [currentId intValue]) {
                            
                            self.leftMenuView.selectIndex = i;
                            self.leftMenuView.didSelectBlock(tempModel, model);
                            [self.leftMenuView reloadData];
                            
                            self.rightMenuView.selectIndex = index - 1;
                            [self.rightMenuView reloadData];
                            break;
                        }
                    }
                }
            }
        }
    }];
}

#pragma mark - lazy
- (LeftMenuView *)leftMenuView {
    
    if (!leftMenuView) {
        
        leftMenuView = [[LeftMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        leftMenuView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:leftMenuView];
        
        @weakify(self);
        [leftMenuView setBackBlock:^(NSString *nameString) {
            
            @strongify(self);
            DrugModel *model = [DrugModel new];
            model.name = nameString;
            [self backWithModel:model];
        }];
        leftMenuView.didSelectBlock = ^(DrugModel *sec, DrugModel *row) {
            @strongify(self);
//            DrugModel *model = self.leftMenuView.dataSources[currentIndex];
            self.rightMenuView.dataSources = sec.itmeArray;
        };
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftMenuView.width - 0.5, 0, 0.5, ScreenHeight)];
        lineView.backgroundColor = CurrentLineColor;
        [self.view insertSubview:lineView atIndex:0];
    }
    
    return leftMenuView;
}

- (RightMenuView *)rightMenuView {
    
    if (!rightMenuView) {
        
        rightMenuView = [[RightMenuView alloc] initWithFrame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, self.leftMenuView.height) style:UITableViewStyleGrouped];
        [self.view addSubview:rightMenuView];
    }
    
    return rightMenuView;
}

- (void)backWithModel:(DrugModel *)model {
    
    if (self.completeBlock) {
        self.completeBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
