//
//  LeftMenuView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/22.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "LeftMenuView.h"

@implementation LeftMenuView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (UITextField *)textField {
    
    UITextField *textField = [UITextField new];
    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"其他科室";
    textField.textColor = kMainColor;
    [textField setValue:[UIColor colorWithHexString:@"0x333333"] forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}

- (void)setupSubviews {
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setDataSources:(NSArray *)dataSources {
    
    [super setDataSources:dataSources];
    if (self.didSelectBlock) {
        DrugModel *model = nil;
        if (dataSources && dataSources.count > 0) {
            model = [dataSources firstObject];
        }
        self.didSelectBlock(model, nil);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DrugModel *sec = [self.dataSources objectAtIndex:section];
    NSInteger count = 1;
    if (sec.isOpen && sec.itmeArray && sec.itmeArray.count > 0) {
        count += sec.itmeArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.rowHeight - 0.5, ScreenWidth, 0.5)];
        lineView.backgroundColor = CurrentLineColor;
        [cell addSubview:lineView];
    }
    
    DrugModel *sec = [self.dataSources objectAtIndex:section];
    if (row == 0 && sec.isOpen) {
        cell.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        cell.textLabel.textColor = kMainColor;
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = kSixColor;
    }
    
    if (row == 0) {
        cell.textLabel.text = sec.name;
    }
    else {
        row--;
        DrugModel *item = [sec.itmeArray objectAtIndex:row];
        cell.textLabel.text = item.name;
        cell.textLabel.textColor = item.isChecked ? kMainColor : kSixColor;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    DrugModel *model = self.dataSources[section];
    if (section == 0) {
        if (self.showDisease) {
            for (DrugModel *old in self.dataSources) {
                old.isOpen = NO;
            }
            model.isOpen = YES;
            [tableView reloadData];
        }
        else if (self.didSelectBlock) {
            self.didSelectBlock(model, nil);
        }
    }
    else if (![model.name isEqualToString:@"其他科室"]) {
        if (self.showDisease) {
            if (row == 0) {
                DrugModel *all = [self.dataSources firstObject];
                all.isOpen = NO;
                self.selectIndex = section;
                if (model.itmeArray && model.itmeArray.count > 0) {
                    model.isOpen = !model.isOpen;
                }
                else if (self.didSelectBlock) {
                    self.didSelectBlock(model, nil);
                }
                [self reloadData];
            }
            else if (self.didSelectBlock) {
                row--;
                for (DrugModel *old in model.itmeArray) {
                    old.isChecked = NO;
                }
                DrugModel *item = [model.itmeArray objectAtIndex:row];
                item.isChecked = YES;
                [tableView reloadData];
                self.didSelectBlock(model, item);
            }
        }
        else if (self.didSelectBlock) {
            self.didSelectBlock(model, nil);
        }
    }
    else {
        
        [self showTitleAlertWithMsg:@"请填写其他科室" isCancel:YES completeBlock:^(id object) {
            
            if (self.backBlock) {
                self.backBlock(object);
            }
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
