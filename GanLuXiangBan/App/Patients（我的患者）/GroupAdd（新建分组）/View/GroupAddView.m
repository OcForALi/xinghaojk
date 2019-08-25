//
//  GroupAddView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupAddView.h"
#import "GroupAddCell.h"
#import "GroupListTitleCell.h"
#import "GroupEditCell.h"
#import "GroupHeadImgCell.h"

@interface GroupAddView ()

@property (nonatomic, assign) CGFloat editCellHeight;
@property (nonatomic, assign) CGFloat headImgCellHeight;
@property (nonatomic, assign) BOOL isEdit;

@end

@implementation GroupAddView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }

    return self.dataSources.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        GroupAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupAddCell"];
        if (cell == nil) {
            cell = [[GroupAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupAddCell"];
        }
        
        cell.textField.text = self.groupNameString;
        @weakify(self);
        [[cell.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            
            @strongify(self);
            self.groupNameString = x;
        }];
        return cell;
    }
    else {
        
        if (indexPath.row == 0) {
            
            GroupListTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupListTitleCell"];
            if (cell == nil) {
                cell = [[GroupListTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupListTitleCell"];
            }
            return cell;
        }
        else {
            
            if (indexPath.row == self.dataSources.count + 1) {
             
                GroupEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupEditCell"];
                if (cell == nil) {
                    cell = [[GroupEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupEditCell"];
                    self.editCellHeight = cell.editCellHeight;
                }
                [cell setBtnClick:^(NSInteger index) {
                   
                    if (index == 1) {
                        
                        if (self.dataSources.count > 0) {
                            
                            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                            GroupHeadImgCell *cell = [tableView cellForRowAtIndexPath:tempIndexPath];
                            cell.isShowDel = YES;
                        }
                    }
                    else if (self.goViewControllerBlock) {
                        self.goViewControllerBlock();
                    }
                }];
                return cell;
            }
            
            GroupHeadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupHeadImgCell"];
            if (cell == nil) {
                cell = [[GroupHeadImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupHeadImgCell"];
                self.headImgCellHeight = cell.groupHeadImgCellHeight;
            }
            cell.imgUrls = self.dataSources[0];
            cell.isShowDel = self.isEdit;
            
            @weakify(self);
            [cell setDelImgBlock:^(int index) {
             
                @strongify(self);
                self.isEdit = YES;
                if (self.deleteBlock) {
                    GroupAddModel *model = self.dataSources[0][index];
                    self.deleteBlock(@[model.mid]);
                }
                
                NSMutableArray *arr = [NSMutableArray arrayWithArray:self.dataSources[0]];
                [arr removeObjectAtIndex:index];
                if (arr.count == 0) self.dataSources = nil;
                else self.dataSources = @[arr];
            }];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            return 45;
        }
        else if (indexPath.row == self.dataSources.count + 1) {
            return self.editCellHeight;
        }
        else return self.headImgCellHeight;
    }
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
