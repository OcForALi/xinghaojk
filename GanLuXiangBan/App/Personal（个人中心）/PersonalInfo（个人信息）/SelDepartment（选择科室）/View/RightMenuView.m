//
//  RightMenuView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/22.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "RightMenuView.h"
#import "DrugModel.h"

@implementation RightMenuView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *selImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 14)];
        selImgView.image = [UIImage imageNamed:@"pirce_select"];
        cell.accessoryView = selImgView;
    }
    
    if (indexPath.row == self.selectIndex) {
        cell.textLabel.textColor = kMainColor;
    }
    else {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    }
    
    cell.accessoryView.hidden = self.selectIndex == indexPath.row ? NO : YES;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (self.dataSources.count > 0) {
        
        DrugModel *model = self.dataSources[indexPath.row];
        cell.textLabel.text = model.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = (int)indexPath.row;
    [self reloadData];
}

@end
