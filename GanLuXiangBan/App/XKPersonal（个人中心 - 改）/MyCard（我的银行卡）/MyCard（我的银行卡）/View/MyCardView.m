//
//  MyCardView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyCardView.h"
#import "MyCardCell.h"

@implementation MyCardView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.rowHeight = 70;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    }
    
    return self;
}

- (void)setIsEdit:(BOOL)isEdit {
    
    _isEdit = isEdit;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCardCell"];
    
    if (cell == nil) {
        cell = [[MyCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSources[indexPath.section];
    cell.isEdit = self.isEdit;
    if ([self.selectArray containsObject:cell.model]) {
        cell.isSelect = YES;
    }
    
    [cell setDefaultCardBlock:^{
        
        MyCardModel *model = self.dataSources[indexPath.section];
        self.defaultCardBlock(model.pkid);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isEdit) {
        
        MyCardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelect = !cell.isSelect;

        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.selectArray];
        if (cell.isSelect) {
            [tempArr addObject:self.dataSources[indexPath.section]];
        }
        else {
            [tempArr removeObject:self.dataSources[indexPath.section]];
        }
        
        self.selectArray = tempArr;
    }
    else if (self.selectCardBlock) {
        
        self.selectCardBlock(self.dataSources[indexPath.section]);
    }
}


@end
