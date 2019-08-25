//
//  DiseasesView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DiseasesView.h"

#import "DiseaseLibraryTableViewCell.h"

@implementation DiseasesView

- (void)addData:(NSArray *)array {
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.dataSources];
    [list addObjectsFromArray:array];
    self.dataSources = [NSArray arrayWithArray:list];
    [self reloadData];
}

- (void)setTypeInteger:(NSInteger)typeInteger {
    
    _typeInteger = typeInteger;
    
    [self reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiseaseLibraryModel *model = self.dataSources[indexPath.row];
    // 获取cell高度
    return [self cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DiseaseLibraryTableViewCell class]  contentViewWidth:ScreenWidth];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"DiseaseTableViewCell";
    
    DiseaseLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DiseaseLibraryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.type = self.typeInteger;
    cell.model = self.dataSources[indexPath.row];
    cell.collectButton.tag = indexPath.row;
    [cell.collectButton addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.collectImage.tag = indexPath.row;
    cell.collectImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *collectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectTap:)];
    [cell.collectImage addGestureRecognizer:collectTap];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeInteger == 1) {
        DiseaseLibraryModel *model = self.dataSources[indexPath.row];
        if (self.collectBlock) {
            self.collectBlock(model);
        }
    }
}

-(void)collect:(UIButton *)sender{
    
    DiseaseLibraryModel *model = self.dataSources[sender.tag];
    
    if (model.disease_id == 0) {
        
        if (self.collectBlock) {
            self.collectBlock(model);
        }
        
    }
    
}

-(void)collectTap:(UITapGestureRecognizer *)sender{
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.dataSources];
    DiseaseLibraryModel *model = list[sender.view.tag];
    [list removeObject:model];
    self.dataSources = list;
    [self reloadData];
    if (self.collecDeleteBlock) {
        self.collecDeleteBlock(model);
    }
}

@end
