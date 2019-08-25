//
//  PaidConsultingView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PaidConsultingView.h"
#import "TipCell.h"
#import "PaidConsultingModel.h"
#import "ConsultingViewController.h"

@interface PaidConsultingView ()

@property (nonatomic, assign) CGFloat tipCellHeight;

@end

@implementation PaidConsultingView

- (void)setPrices:(NSArray *)prices {
    
    _prices = prices;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 1;
    }
    
    return self.dataSources ? self.dataSources.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TipCell"];
        if (cell == nil) {
            cell = [[TipCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TipCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tipContent = @" 1、图文咨询目前可设置免费(0元)和收费设置，也可以根据实际情况进行“自定义价格”。\n 2、咨询服务修改价格后，当前咨询不受影响，收费将在下次咨询生效。\n 3、图文咨询默认有效期为24小时（由发起方发起咨询开始计算），或经医患双方沟通由医生主动结束咨询。\n 4、医生主动发起图文咨询，则患者无需付费。\n 5、电话/线下咨询，由患者主动发起，医生审核通过后由患者付费成交。";
        self.tipCellHeight = cell.tipCellHeight;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
//    PaidConsultingModel *model;
//    if (self.prices.count > 0) {
//        
//        model = self.prices[indexPath.row];
//        if (indexPath.row == 0 && model.isFree) {
//            cell.detailTextLabel.text = @"免费";
//        }
//        else {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", model.dr_pay_money];
//        }
//    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSources[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        NSInteger row = indexPath.row;
        // 前往控制器
        if (self.goViewControllerBlock && row < self.dataSources.count) {
            
            ConsultingViewController *viewController = [ConsultingViewController new];
            viewController.title = self.dataSources[row];
            if (row < self.prices.count) {
                viewController.model = self.prices[row];
            }
            WS(weakSelf)
            [viewController setCompleteBlock:^(id object) {
                if (object && weakSelf.prices && row < weakSelf.prices.count) {
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:weakSelf.prices];
                    [arr replaceObjectAtIndex:row withObject:object];
                    weakSelf.prices = arr;
                }
            }];
            
            if (self.goViewControllerBlock) {
                self.goViewControllerBlock(viewController);
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 45;
    }
    
    return self.tipCellHeight;
}

@end
