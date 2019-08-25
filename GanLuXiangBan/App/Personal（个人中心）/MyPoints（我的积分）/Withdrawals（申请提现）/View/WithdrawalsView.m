//
//  WithdrawalsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

// View
#import "WithdrawalsView.h"
// Cell
#import "ExchangeCell.h"
#import "TipCell.h"
// Controller
#import "MyCardViewController.h"


@implementation WithdrawalsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self registerClass:[TipCell class] forCellReuseIdentifier:@"TipCell"];
        [self registerClass:[ExchangeCell class] forCellReuseIdentifier:@"ExchangeCell"];
    }
    
    return self;
}

- (void)setPointString:(NSString *)pointString {
    
    _pointString = pointString;
    [self reloadData];
}

- (void)setMyCardModel:(MyCardModel *)myCardModel {
    
    _myCardModel = myCardModel;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TipCell"];
        cell.tipContent = @"1、积分申请兑换后，T+2（工作日）到账；\n2、如积分兑换遇不可抗因素，如自然灾害、节假日、银行系统问题、账户问题等，兑换日期则可能顺延，具体日期视实际情况而定，敬请谅解！";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1) {
        
        ExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeCell"];
        cell.pointString = self.pointString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setEchangeBlock:^(NSString *number) {
            
            if (self.myCardModel.pkid.length > 0) {
                self.echangeBlock(number, self.myCardModel.pkid);
            }
            else {
                [self makeToast:@"请选择银行卡"];
            }
        }];
        return cell;
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.detailTextLabel.text = @"请选择银行卡";
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = @"银行卡";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
        
        if (self.myCardModel.pkid.length > 0) {
            NSString *mantissaString = [self.myCardModel.card_no substringWithRange:NSMakeRange(self.myCardModel.card_no.length - 4, 4)];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"尾号%@ (%@)", mantissaString, self.myCardModel.bank];
        }
        
        return cell;
    }
}

#pragma mark - UITablViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        MyCardViewController *cardVC = [MyCardViewController new];
        [cardVC setSelectBackCard:^(MyCardModel *model) {
            self.myCardModel = model;
        }];
        
        if (self.goViewController) {
            self.goViewController(cardVC);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        TipCell *cell = [tableView cellForRowAtIndexPath:cellIndexPath];
        return cell.tipCellHeight;
    }
    else if (indexPath.section == 1) {
        
        return 100;
    }
    
    return 45;
}

@end
