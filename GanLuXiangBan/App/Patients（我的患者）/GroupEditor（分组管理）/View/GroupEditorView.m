//
//  GroupEditorView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupEditorView.h"
#import "GroupEditorModel.h"
#import "GroupAddViewController.h"

@implementation GroupEditorView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, 15)];
        numberLabel.text = @"0人";
        numberLabel.font = [UIFont systemFontOfSize:14];
        numberLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        numberLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryView = numberLabel;
    }
    
    GroupEditorModel *model = self.dataSources[indexPath.row];
    
    if (self.picker) {
        NSString *name = model.isSelect ? @"SelectPatients" : @"NoSelectPatients";
        cell.imageView.image = [UIImage imageNamed:name];
    }
    
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    
    UILabel *numberLabel = (UILabel *)cell.accessoryView;
    numberLabel.text = [NSString stringWithFormat:@"%@人", model.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (self.picker) {
        GroupEditorModel *model = self.dataSources[indexPath.row];
        model.isSelect = !model.isSelect;
        [tableView reloadData];
    }
    else {
        GroupEditorModel *model = self.dataSources[indexPath.row];
        GroupAddViewController *viewController = [GroupAddViewController new];
        viewController.title = @"编辑分组";
        viewController.model = model;
        
        if (self.goViewControllerBlock) {
            self.goViewControllerBlock(viewController);
        }
    }
}

@end
