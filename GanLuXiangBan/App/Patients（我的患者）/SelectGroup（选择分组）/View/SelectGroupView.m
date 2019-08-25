//
//  SelectGroupView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SelectGroupView.h"
#import "GroupEditorModel.h"

@implementation SelectGroupView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.editing = YES;
        self.selectArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)setDataSources:(NSArray *)dataSources {
    
    [super setDataSources:dataSources];
    
    for (int i = 0; i< dataSources.count; i++) {
        
        GroupEditorModel *model = self.dataSources[i];
        if (model.isSelect) {
            
            [self.selectArray addObject:model];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectGroupCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectGroupCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    }
    
    GroupEditorModel *model = self.dataSources[indexPath.row];
    cell.textLabel.text = model.name;
    
//    UILabel *numberLabel = (UILabel *)cell.accessoryView;
//    numberLabel.text = [NSString stringWithFormat:@"%@人", model.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    GroupEditorModel *model = self.dataSources[indexPath.row];
    model.isSelect = !model.isSelect;
    if ([self.selectArray containsObject:model]) {
        [self.selectArray removeObject:model];
    }
    else {
        [self.selectArray addObject:model];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupEditorModel *model = self.dataSources[indexPath.row];
    model.isSelect = !model.isSelect;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

@end
