//
//  GroupAddViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupAddViewController.h"
#import "GroupAddView.h"
#import "GroupAddViewModel.h"
#import "PatientListViewController.h"

@interface GroupAddViewController ()

@property (nonatomic, strong) GroupAddView *groupAddView;
@property (nonatomic, strong) NSMutableArray *delArray;
@property (nonatomic, strong) NSMutableArray *addArray;

@end

@implementation GroupAddViewController
@synthesize groupAddView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.title.length == 0) {
        self.title = @"新建分组";
    }
    else {
        [self getDataSource];
    }
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
        @strongify(self);
        [self savePatientLabel];
    }];
    
    self.delArray = [NSMutableArray array];
    self.addArray = [NSMutableArray array];
    self.groupAddView.groupNameString = self.model.name;
}

- (BOOL)checkUserIsIn:(NSString *)mid {
    NSArray *dataSource = self.groupAddView.dataSources[0];
    if (dataSource && dataSource.count > 0) {
        for (GroupAddModel *item in dataSource) {
            if ([mid isEqualToString:item.mid]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)checkOldUserIsIn:(NSArray *)objs {
    NSArray *dataSource = self.groupAddView.dataSources[0];
    if (dataSource && dataSource.count > 0) {
        for (GroupAddModel *item in dataSource) {
            BOOL isIn = NO;
            for (GroupAddModel *obj in objs) {
                if ([item.mid isEqualToString:obj.mid]) {
                    isIn = YES;
                    break;
                }
            }
            if (!isIn) {
                [self.delArray addObject:item.mid];
            }
        }
    }
}

- (GroupAddView *)groupAddView {
    
    if (!groupAddView) {
        
        groupAddView = [[GroupAddView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:groupAddView];
        
        @weakify(self);
        [groupAddView setDeleteBlock:^(NSArray *dels) {
            
            @strongify(self);
            [self.delArray addObjectsFromArray:dels];
            
            for (NSString *addIdString in [self.addArray mutableCopy]) {
                
                if ([addIdString isEqualToString:dels[0]]) {
                    [self.addArray removeObject:addIdString];
                }
            }
        }];
        
        [groupAddView setGoViewControllerBlock:^{
            
            @strongify(self);
            NSMutableArray *selectIdArray = [NSMutableArray array];
            NSArray *dataSource = self.groupAddView.dataSources[0];
            for (int i = 0; i < [dataSource count]; i++) {
                
                GroupAddModel *model = dataSource[i];
                [selectIdArray addObject:model.mid];
            }
            
            PatientListViewController *viewController = [PatientListViewController new];
            viewController.selectIdArray = selectIdArray;
            [viewController setCompleteBlock:^(id object) {
                
                for (GroupAddModel *model in object) {
                    if (![self checkUserIsIn:model.mid]) {
                        [self.addArray addObject:model.mid];
                    }
                }
                [self checkOldUserIsIn:object];
                
                self.groupAddView.dataSources = @[object];
                
            }];
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
        if (self.model.name.length > 0) {
            
            groupAddView.height -= 50;
            
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = CGRectMake(0, CGRectGetMaxY(groupAddView.frame), ScreenWidth, 50);
            deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            deleteBtn.backgroundColor = [UIColor redColor];
            [deleteBtn setTitle:@"删除分组" forState:UIControlStateNormal];
            [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:deleteBtn];
            
            [[deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                [self alertWithTitle:@"温馨提示" msg:@"是否删除分组?" isShowCancel:YES complete:^{
                    [self delPatientLabel];
                }];
            }];
        }
    }
    
    return groupAddView;
}

#pragma mark - request
- (void)getDataSource {
    
    [[GroupAddViewModel new] getLabelLabelDetailWithId:self.model.label complete:^(id object) {
        
        NSArray *arr = object;
        if (arr.count != 0) {
            self.groupAddView.dataSources = @[object];
        }
        else {
            self.groupAddView.dataSources = nil;
        }
    }];
}

- (void)savePatientLabel {
    
    if (self.model != nil) {
        
        GroupAddModel *model = [GroupAddModel new];
        model.label = self.model.label;
        model.label_name = self.groupAddView.groupNameString;
        [[GroupAddViewModel new] savePatientLabelWithAddIds:self.addArray delIds:self.delArray moedl:model complete:^(id object) {
            [self.view makeToast:object];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    else {
        
        if (self.groupAddView.groupNameString.length == 0) {
            return [self.view makeToast:@"请输入分组名称"];
        }
        
        if (self.groupAddView.groupNameString.length > 10) {
            return [self.view makeToast:@"分组名最多支持十位"];
        }
        
        [[GroupAddViewModel new] addLabelWithAddIds:self.addArray name:self.groupAddView.groupNameString complete:^(id object) {
            [[UIApplication sharedApplication].keyWindow makeToast:object];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void)delPatientLabel {
    
    [[GroupAddViewModel new] delPatientLabelWithId:self.model.label complete:^(id object) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication].keyWindow makeToast:object];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

@end
