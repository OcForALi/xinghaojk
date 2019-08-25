//
//  CheckTimeListView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckTimeListView.h"


@interface CheckTimeListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat statusBarHeight;

@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation CheckTimeListView
@synthesize navTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(ScreenWidth, self.statusBarHeight + 44, ScreenWidth / 2, ScreenHeight) style:UITableViewStyleGrouped];
        self.tableView.height -= self.tableView.y;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    
    return self;
}


#pragma mark - lazy
- (UILabel *)navTitleLabel {
    
    if (!navTitleLabel) {
        
        navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth / 2, self.statusBarHeight + 44)];
        navTitleLabel.backgroundColor = kMainColor;
        [self addSubview:navTitleLabel];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.statusBarHeight, navTitleLabel.width - 20, 44)];
        titleLabel.text = self.navName;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [navTitleLabel addSubview:titleLabel];
    }
    
    return navTitleLabel;
}


#pragma mark - set
- (void)setNavName:(NSString *)navName {
    
    _navName = navName;
    self.navTitleLabel.text = @"";
}

- (void)setDataSource:(NSArray *)dataSource {
    
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)setIsHidden:(BOOL)isHidden {

    [UIView animateWithDuration:0.3 animations:^{
       
        self.navTitleLabel.x = ScreenWidth - ScreenWidth / 2 * !isHidden;
        self.tableView.x = ScreenWidth - ScreenWidth / 2 * !isHidden;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4 * !isHidden];
        
    } completion:^(BOOL finished) {
        
        if (isHidden && self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CheckYearModel *model = self.dataSource[section];
    return [model.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    CheckYearModel *model = self.dataSource[indexPath.section];
    CheckYearItemsModel *itemModel = model.items[indexPath.row];
    cell.textLabel.text = itemModel.month_day;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.backgroundColor = [UIColor colorWithHexString:@"0x333333"];
    return cell;
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
    
    CheckYearModel *model = self.dataSource[section];
    headerView.textLabel.text = model.year;
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectBlock) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.selectBlock(cell.textLabel.text);
    }
    
    if (self.selectChkModel) {
        CheckYearModel *model = self.dataSource[indexPath.section];
        CheckYearItemsModel *itemModel = model.items[indexPath.row];
        self.selectChkModel(itemModel);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isHidden = YES;
}

@end
