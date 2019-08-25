//
//  NewPatientView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "NewPatientView.h"
#import "PatientsCell.h"
#import "PatientsDetailsViewController.h"

@interface NewPatientView ()

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSArray *keys;

@end

@implementation NewPatientView

#pragma mark - set
- (void)setDictDataSource:(NSDictionary *)dictDataSource {
    
    _dictDataSource = dictDataSource;
    self.defaultImgView.hidden = [dictDataSource count] > 0 ? YES : NO;
    self.keys = [dictDataSource.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dictDataSource[self.keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 3, 15)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        titleLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryView = titleLabel;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    
    PatientsModel *model = self.dictDataSource[self.keys[indexPath.section]][indexPath.row];
    UILabel *titleLabel = (UILabel *)cell.accessoryView;
    titleLabel.text = [NSString stringWithFormat:@"添加于 %@", model.createtime];
    
    cell.textLabel.text = model.membername;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@岁", model.gender, model.age];
    
    // 图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.head]];
    
    CGSize itemSize = CGSizeMake(45, 45);
    UIGraphicsBeginImageContext(itemSize);

    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];

    cell.imageView.layer.cornerRadius = itemSize.height / 2;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (self.goViewController) {
        
        PatientsModel *model = self.dictDataSource[self.keys[indexPath.section]][indexPath.row];
        PatientsDetailsViewController *viewController = [PatientsDetailsViewController new];
        viewController.midString = model.mid;
        self.goViewController(viewController);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    headerView.textLabel.text = [self.keys[section] stringValue];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    return headerView;
}



@end
