//
//  ConsultingView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ConsultingView.h"
#import "CustomCell.h"
#import "SelectPriceView.h"
#import "SelectPatientListViewController.h"
#import "PatientListViewController.h"

@interface ConsultingView ()

@property (nonatomic, strong) SelectPriceView *selectPriceView;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation ConsultingView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.paySetModel = [PaySetModel new];
    }
    
    return self;
}

#pragma mark - lazy
- (SelectPriceView *)selectPriceView {
    
    if (!_selectPriceView) {
        
        _selectPriceView = [[SelectPriceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _selectPriceView.hidden = YES;
        [self addSubview:_selectPriceView];
        
        @weakify(self);
        [_selectPriceView setDidIndexTextBlock:^(NSInteger index, NSString *textString) {
            
            @strongify(self);
            [self endEditing:NO];
            self.selectPriceView.isShowList = !self.selectPriceView.isShowList;
            self.paySetModel.index = index;
            if ([textString intValue] > 0) {
                self.paySetModel.is_open = @"1";
                self.paySetModel.pay_money = textString;
            }
            else if ([textString isEqualToString:@"自定义价格"]) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入价格" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    CGFloat money = [[alertController.textFields.lastObject text] floatValue];
                    self.paySetModel.is_open = @"1";
                    self.paySetModel.pay_money = [NSString stringWithFormat:@"%.2f", money];
                    [self reloadData];
                    
                }];
                
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"请输入价格";
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [NavController presentViewController:alertController animated:YES completion:nil];
                
            }
            else {
                
                self.paySetModel.is_open = @"0";
                self.paySetModel.pay_money = @"-1";
            }
            
            [self reloadData];
            
        }];
    }
    
    return _selectPriceView;
}

- (void)setModel:(PaidConsultingModel *)model {
    
    _model = model;
    self.paySetModel.visit_type = model.visit_type;
    self.paySetModel.pay_money = model.dr_pay_money;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.dataSources[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            if ([self.paySetModel.pay_money integerValue] == -1) {
                cell.detailTextLabel.text = @"未开通";
            }
            else {
                NSInteger price = [self.paySetModel.pay_money integerValue];
                if (price <= 0) {
                    price = 0;
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元/次", @(price)];
            }
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"已选择%zd个患者", self.patientsArray.count];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            if ([self.model.visit_type intValue] == 1) {
                self.selectPriceView.priceArr = @[@"0", @"19", @"29", @"39", @"自定义价格"];
            }
            else {
                self.selectPriceView.priceArr = @[@"29", @"39", @"49", @"59", @"自定义价格", @"未开通"];
            }
            
            [self endEditing:YES];
            self.selectPriceView.hidden = NO;
            self.selectPriceView.isShowList = YES;
        }
        else {
            
            NSMutableArray *selectArray = [NSMutableArray array];
            for (GroupAddModel *groupAddModel in self.patientsArray) {
                [selectArray addObject:groupAddModel.mid];
            }
            
//            SelectPatientListViewController *vc = [SelectPatientListViewController new];
            PatientListViewController *vc = [PatientListViewController new];
            vc.showConsultFee = YES;
            if (self.isFirst) {
                vc.selectIdArray = selectArray;
            }
            
            [vc setCompleteBlock:^(id object) {
                self.patientsArray = object;
                self.isFirst = YES;
                [self reloadData];
            }];
            
            if (self.goViewControllerBlock) {
                self.goViewControllerBlock(vc);
            }
        }
    }
    else {
        
        self.goViewControllerBlock([NSClassFromString(@"HelpWebViewController") new]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

@end
