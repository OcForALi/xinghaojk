//
//  RecipientView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RecipientView.h"
#import "RecipientCell.h"
#import "RecipientListCell.h"
#import "GroupEditorModel.h"
#import "PatientListViewController.h"

@interface RecipientView ()

@property (nonatomic, assign) CGFloat selectSectionIndex;
@property (nonatomic, assign) CGFloat selectRowIndex;

@end

@implementation RecipientView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.contents = [NSMutableArray array];
        self.userInfos = [NSMutableArray array];
        self.rowHeight = 60;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)reloadDatas:(NSArray *)datas {
    if (self.currentIndex > 0) {
        self.selectSectionIndex = self.currentIndex;
    }
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    GroupEditorModel *all = [GroupEditorModel new];
    all.name = @"所有患者";
    all.label = @"";
    all.isSelect = self.currentIndex == 0;
    [list addObject:all];
    GroupEditorModel *rece = [GroupEditorModel new];
    rece.name = @"部分收到";
    rece.label = @"选中的分组/个人可收到";
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (GroupEditorModel *item in datas) {
        [res addObject:[item copy]];
    }
    rece.list = res;
    rece.isSelect = self.currentIndex == 1;
    [list addObject:rece];
    GroupEditorModel *unrece = [GroupEditorModel new];
    unrece.name = @"不发给谁";
    unrece.label = @"选中的分组/个人不可收到";
    unrece.list = datas;
    unrece.isSelect = self.currentIndex == 2;
    [list addObject:unrece];
    
    if (self.currentIndex > 0) {
        NSArray *resp = self.currentIndex == 1 ? rece.list : unrece.list;
        for (GroupEditorModel *item in resp) {
            if ([self haveGroup:item.label]) {
                item.isSelect = YES;
                [self.contents addObject:item];
            }
        }
    }
    
    if (self.users && self.users.count > 0) {
        [self.userInfos addObjectsFromArray:self.users];
    }
    
    self.dataSources = list;
}

- (BOOL)haveGroup:(NSString *)groupId {
    if (self.groupIds && self.groupIds.count > 0) {
        NSInteger gid = [groupId integerValue];
        for (NSString *item in self.groupIds) {
            if (gid == [item integerValue]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    GroupEditorModel *group = [self.dataSources objectAtIndex:section];
    if (group.isSelect) {
        return 2 + (group.list ? group.list.count : 0);
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    GroupEditorModel *group = [self.dataSources objectAtIndex:section];
    if (row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
            
            UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 - 1, ScreenWidth, 1)];
            lineView.backgroundColor = kPageBgColor;
            [cell addSubview:lineView];
            
            UIImage *img = [UIImage imageNamed:@"Home_DownTriangle"];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.size = img.size;
            cell.accessoryView = imgView;
        }
        
//        if (self.selectSectionIndex == indexPath.section) cell.imageView.image = [UIImage imageNamed:@"SelectRecipient"];
//        else cell.imageView.image = [UIImage imageNamed:@"NoSelectPatients"];
        
//        NSArray *titles = @[@"所有患者", @"部分收到", @"不发给谁"];
//        NSArray *detailTexts = @[@"", @"选中的分组/个人可收到", @"选中的分组/个人不可收到"];
        
        NSString *name = group.isSelect ? @"SelectRecipient" : @"NoSelectPatients";
        cell.imageView.image = [UIImage imageNamed:name];
        cell.textLabel.text = group.name;
        cell.detailTextLabel.text = group.label;
        return cell;
    }
    else {
        NSInteger count = group.list ? group.list.count : 0;
        if (row == count + 1) {
            
            RecipientListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipientListCell"];
            if (cell == nil) {
                cell = [[RecipientListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipientListCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.idInfos = self.userInfos;
            return cell;
        }
        else {
            
            RecipientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipientCell"];
            if (cell == nil) {
                cell = [[RecipientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipientCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            GroupEditorModel *model = group.list[row - 1];
            cell.titleLabel.text = model.name;
            cell.isSelect = model.isSelect;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    
    GroupEditorModel *group = [self.dataSources objectAtIndex:section];
    if (!group.isSelect) {
        for (NSInteger index = 0; index < self.dataSources.count; index++) {
            GroupEditorModel *group = [self.dataSources objectAtIndex:index];
            group.isSelect = index == section;
            if (index != section && group.list && group.list > 0) {
                for (GroupEditorModel *item in group.list) {
                    item.isSelect = NO;
                    [self.contents removeObject:item];
                }
            }
        }
    }
    
    self.currentIndex = section;
    
    if (section > 0) {
        NSInteger row = indexPath.row;
        NSInteger count = group.list ? group.list.count : 0;
        if (row == count + 1) {
            NSMutableArray *arr = [NSMutableArray array];
            for (GroupAddModel *model in self.userInfos) {
                [arr addObject:model.mid];
            }
            
            PatientListViewController *viewController = [PatientListViewController new];
            viewController.selectIdArray = arr;
            [viewController setCompleteBlock:^(id object) {
                [self.userInfos removeAllObjects];
                [self.userInfos addObjectsFromArray:object];
                [self reloadData];
            }];
            self.goViewControllerBlock(viewController);
        }
        else if (row > 0) {
            GroupEditorModel *model = group.list[row - 1];
            model.isSelect = !(model.isSelect);
            if (model.isSelect) {
                [self.contents addObject:model];
            }
            else [self.contents removeObject:model];
        }
    }
    
    
    
//    if (indexPath.row == self.dataSources.count + 1) {
//
//
//    }
//    else if (indexPath.row == 0) {
//
//        [self.contents removeAllObjects];
//        [self.userInfos removeAllObjects];
//        self.currentIndex = indexPath.section;
//
//        for (int i = 0; i < self.dataSources.count; i++) {
//
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i + 1 inSection:self.selectSectionIndex];
//            RecipientCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            cell.isSelect = NO;
//
////            [self.contents removeAllObjects];
//        }
//    }
//    else {
//
//        RecipientCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.isSelect = !cell.isSelect;
//
//        GroupEditorModel *model = self.dataSources[indexPath.row - 1];
//        if (cell.isSelect) {
//            [self.contents addObject:model];
//        }
//        else [self.contents removeObject:model];
//    }
//
//    self.selectSectionIndex = indexPath.section;
//    self.selectRowIndex = indexPath.row;
    
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (row == 0) {
        return 60;
    }
    else {
        GroupEditorModel *group = [self.dataSources objectAtIndex:section];
        NSInteger count = group.list ? group.list.count : 0;
        if (row == count + 1 && self.userInfos.count > 0) {
            return 65;
        }
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
