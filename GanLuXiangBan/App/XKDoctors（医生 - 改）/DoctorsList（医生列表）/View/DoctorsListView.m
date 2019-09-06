//
//  DoctorsListView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/7.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DoctorsListView.h"

@interface DoctorsListView ()

@property (nonatomic, strong) NSArray *keys;

@end

@implementation DoctorsListView

#pragma mark - set
- (void)setDataDict:(NSDictionary *)dataDict {
    
    _dataDict = dataDict;
    
    NSMutableArray *keys = [NSMutableArray arrayWithArray:dataDict.allKeys];
    [keys sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    self.keys = keys;
    self.defaultImgView.hidden = [dataDict count] != 0;
    
    [self reloadData];
}


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.rowHeight = 65;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        [self resetEmptyTips:@"您暂时没有邀请的医生"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataDict count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataDict[self.keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DoctorsListModel *model = self.dataDict[self.keys[indexPath.section]][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", model.drname, model.title];
    cell.textLabel.textColor = kMainTextColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = model.hospital_name;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    // 设置图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"userHeader"]];
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.image = [cell.imageView.image changeSize:CGSizeMake(40, 40)];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DoctorsListModel *model = self.dataDict[self.keys[indexPath.section]][indexPath.row];
    if (self.didSelectBlock) {
        self.didSelectBlock(model);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    headerView.textLabel.text = self.keys[section];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    return headerView;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}

@end
