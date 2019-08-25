//
//  CitySelectView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CitySelectView.h"

@implementation CitySelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.provinceArray = [NSMutableArray array];
        
        self.cityArray = [NSMutableArray array];
        
        [self data];
        
        [self initUI];
    }
    
    return self;
}

-(void)data{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *array = [dict allKeys];
    
    [self.provinceArray addObjectsFromArray:array];
    
    for (int i = 0; i < self.provinceArray.count; i++) {
        
        NSArray *array = [dict objectForKey:self.provinceArray[i]];
        
        [self.cityArray addObject:array];
        
    }
    
    NSLog(@"%@",self.cityArray);
    
}

- (UITableView *)leftTableView{
    
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth / 3.0, self.height-200) style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth / 3.0, 200, ScreenWidth / 3.0 * 2, self.height-200) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;

    }
    return _rightTableView;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}

-(void)initUI{
    
    self.BGView = [UIView new];
    self.BGView.backgroundColor = RGBA(37, 37, 37, 0.7);
    self.BGView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap:)];
    [self.BGView addGestureRecognizer:bgTap];
    [self addSubview:self.BGView];
    
    self.BGView.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);

    _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _cityIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    
    self.cityLabel = [UILabel new];
    self.cityLabel.font = [UIFont systemFontOfSize:15];
    self.cityLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.cityLabel];
    
    self.cityLabel.sd_layout
    .leftSpaceToView(self, 0)
    .bottomSpaceToView(self.leftTableView, 0)
    .rightSpaceToView(self, 0)
    .heightIs(40);
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = RGB(241, 241, 241);
    [self addSubview:lineView1];
    
    lineView1.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.cityLabel, 0)
    .heightIs(1);
    
    UILabel *titileLabel = [UILabel new];
    titileLabel.text = @"所在区域";
    titileLabel.font = [UIFont systemFontOfSize:17];
    titileLabel.backgroundColor = [UIColor whiteColor];
    titileLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titileLabel];
    
    titileLabel.sd_layout
    .leftSpaceToView(self, 0)
    .bottomSpaceToView(self.cityLabel, 0)
    .rightSpaceToView(self, 0)
    .heightIs(40);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(241, 241, 241);
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(titileLabel, 0)
    .heightIs(1);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.provinceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
        return 1;
    }
    NSArray *array = self.cityArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        return 44;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == _leftTableView) {
        return 0.01;
//    }
//    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    
    if (tableView == _leftTableView) {
        cell.textLabel.text = self.provinceArray[indexPath.section];
        if (indexPath == _currentIndexPath) {
            cell.textLabel.textColor = [UIColor redColor];
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
        return cell;
    }
    
    if (indexPath == _cityIndexPath) {
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.textLabel.text = self.cityArray[indexPath.section][indexPath.row];
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView == _leftTableView) {
        _currentIndexPath = indexPath;
        [tableView reloadData];
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        _isSelected = YES;
    }else{
        _cityIndexPath = indexPath;
        [tableView reloadData];
        self.cityLabel.text = [NSString stringWithFormat:@"   %@    %@",self.provinceArray[indexPath.section],self.cityArray[indexPath.section][indexPath.row]];
        
    }
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //方案二
    if (scrollView == _rightTableView && _isSelected == NO) {
        //系统方法返回处于tableView某坐标处的cell的indexPath
        NSIndexPath * indexPath = [_rightTableView indexPathForRowAtPoint:scrollView.contentOffset];
        NSLog(@"滑到了第 %ld 组 %ld个",indexPath.section, indexPath.row);
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [_leftTableView reloadData];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    
    //获取处于UITableView中心的cell
    //系统方法返回处于tableView某坐标处的cell的indexPath
    NSIndexPath * middleIndexPath = [_rightTableView  indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + _rightTableView.frame.size.height/2)];
    NSLog(@"中间的cell：第 %ld 组 %ld个",middleIndexPath.section, middleIndexPath.row);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isSelected = NO;
}

-(void)bgTap:(UITapGestureRecognizer *)sender{
    
    NSLog(@"触发背景，关闭城市选择 ,看老凯了哈·嘿嘿 不许锤我！还有·那个·右边·沟沟·忘了老凯加一哈·嘿嘿·");
    
}

@end
