//
//  VisitDetailsView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/24.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "VisitDetailsView.h"
#import "SelectPriceView.h"
#import "DateCell.h"
#import "HelpWebViewController.h"

@interface VisitDetailsView ()

@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) SelectPriceView *selectPriceView;


@end

@implementation VisitDetailsView
@synthesize selectPriceView;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return self;
}

#pragma mark - lazy
- (SelectPriceView *)selectPriceView {
    
    if (!selectPriceView) {
        
        selectPriceView = [[SelectPriceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        selectPriceView.priceArr = self.hospitalList;
        [self addSubview:selectPriceView];
        
        @weakify(self);
        [selectPriceView setDidTextStringBlock:^(NSString *textString) {
            
            @strongify(self);
            
            textString = [textString isEqualToString:@"无"] ? @"本院区" : textString;
            self.scrollEnabled = YES;
            
            self.selectPriceView.isShowList = !self.selectPriceView.isShowList;
 
            NSMutableArray *dataSource = [NSMutableArray arrayWithArray:self.dataSources];
            NSMutableArray *models = [NSMutableArray arrayWithArray:dataSource[0]];
            NSArray *times = [self.timeString componentsSeparatedByString:@","];
            NSInteger index = [times.lastObject intValue] - 1;
            VisitDetailsModel *model = models[index];
            if ([times[0] intValue] == 1) {
                model.amHospital = textString;
            }
            else {
                model.pmHospital = textString;
            }
            
            [models replaceObjectAtIndex:index withObject:model];
            [dataSource replaceObjectAtIndex:0 withObject:models];
            
            self.dataSources = dataSource;
        }];
    }
    
    return selectPriceView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 7;
    }
    
    return [self.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NSString *cellIdentifier = [NSString stringWithFormat:@"DateCell%zd", indexPath.row];
        DateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.index = (int)indexPath.row;
        cell.model = self.dataSources[indexPath.section][indexPath.row];
        
        // 选择类型
        [cell setSelectType:^(VisitTime visitTime) {
            [self selectTypeWithTime:visitTime index:indexPath.row];
        }];
        // 选择医院
        WS(weakSelf)
        [cell setSelectHospital:^(VisitTime visitTime) {
            
            weakSelf.timeString = [NSString stringWithFormat:@"%@,%@", @(visitTime + 1), @(indexPath.row + 1)];
            
            weakSelf.scrollEnabled = NO;
            weakSelf.selectPriceView.priceArr = weakSelf.hospitalList;
            weakSelf.selectPriceView.hidden = NO;
            weakSelf.selectPriceView.isShowList = YES;
        }];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        lineView.backgroundColor = kLineColor;
        [cell addSubview:lineView];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.dataSources[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            if (self.goViewController) {
                self.goViewController([NSClassFromString(@"SortingAreaViewController") new]);
            }
        }
        else {
            
            HelpWebViewController *viewController = [HelpWebViewController new];
            viewController.title = self.dataSources[indexPath.section][indexPath.row];
            viewController.bodyString = self.helpBodyString;
            self.goViewController(viewController);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        VisitDetailsModel *model = self.dataSources[indexPath.section][indexPath.row];
        return model.isVisits ? 90 : 45;
    }
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 0.5;
    }
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kLineColor;
        return lineView;
    }
    
    return nil;
}


#pragma mark - 方法
- (void)selectTypeWithTime:(VisitTime)time index:(NSInteger)currentIndex {
    
    NSArray *titles = @[@"无", @"普通", @"专家", @"特诊"];
    [self actionSheetWithTitle:@"请选择出诊类型" titles:titles isCan:YES completeBlock:^(NSInteger index) {

        if (index > 0) {
            
            VisitDetailsModel *model = self.dataSources[0][currentIndex];
            model.isVisits = YES;
            
            if (time == AM) {
                model.amType = [NSString stringWithFormat:@"%@", @(index - 1)];
                model.amHospital = @"本医院";
            }
            else {
                model.pmType = [NSString stringWithFormat:@"%@", @(index - 1)];
                model.pmHospital = @"本医院";
            }
            
            NSMutableArray *arr = [NSMutableArray arrayWithArray:self.dataSources];
            NSMutableArray *models = [NSMutableArray arrayWithArray:arr[0]];
            [models replaceObjectAtIndex:currentIndex withObject:model];
            [arr replaceObjectAtIndex:0 withObject:models];
            
            self.dataSources = arr;
        }
    }];
}

@end
