//
//  CityView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CityView.h"

#define TitleBgheight 65

@interface CityView () <UITableViewDelegate, UITableViewDataSource>

/// 省
@property (nonatomic, strong) UITableView *provinceTableView;
/// 城市
@property (nonatomic, strong) UITableView *cityTableView;
/// 省字段
@property (nonatomic, strong) NSString *provinceString;
/// 城市字段
@property (nonatomic, strong) NSString *cityString;
/// 城市
@property (nonatomic, strong) NSArray *cityDataSource;
/// 标题背景
@property (nonatomic, strong) UIView *titleBgView;
/// 下标线
@property (nonatomic, strong) UIView *lineView;
/// 完成按钮
@property (nonatomic, strong) UIButton *okBtn;

@end

@implementation CityView
@synthesize scrollView;
@synthesize cityTableView;
@synthesize provinceTableView;
@synthesize titleBgView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self.titleBgView setBackgroundColor:[UIColor whiteColor]];
        [self getDataSource];
    }
    
    return self;
}

- (void)getDataSource {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    self.cityDict = [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)getModel {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    id dataSource = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    CityModel *provinceModel = [CityModel new];
    CityModel *cityModel = [CityModel new];
    
    // 获取数据
    if ([self.provinceString length] > 0) {
        
        for (NSDictionary *dict in dataSource) {
            
            NSString *name = [dict objectForKey:@"n"];
            if ([self.provinceString isEqualToString:name]) {
                
                // 省份
                [provinceModel setModelWithDict:dict];
                
                // 获取城市
                if (self.cityString.length > 0) {
                    
                    for (NSDictionary *cityDict in [dict objectForKey:@"c"]) {
                        
                        NSString *name = [cityDict objectForKey:@"n"];
                        if ([self.cityString isEqualToString:name]) {
                            [cityModel setModelWithDict:cityDict];
                        }
                    }
                }
                
                break;
            }
        }
    }
    
    self.selCityModelBlock(provinceModel, cityModel);

}

#pragma mark - set
- (void)setIsShowCityList:(BOOL)isShowCityList {
    
    _isShowCityList = isShowCityList;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3 * isShowCityList];
        self.scrollView.y = isShowCityList ? (self.height / 2 + TitleBgheight) : self.height + TitleBgheight;
        self.scrollView.alpha = isShowCityList;
        self.scrollView.bounces = NO;
        
        self.titleBgView.y = isShowCityList ? self.height / 2 - 20 : self.height - 20;
        self.titleBgView.alpha = isShowCityList;
        
    } completion:^(BOOL finished) {
        
        if (!isShowCityList) {
            
            self.hidden = YES;
            
            if (self.selectCity) {
                self.selectCity(self.provinceString, self.cityString);
            }
            
            if (self.selCityModelBlock) {
                [self getModel];
            }
        }
    }];
    
    [self.provinceTableView reloadData];
    [self.cityTableView reloadData];
}

- (void)setCityDict:(NSDictionary *)cityDict {
    
    _cityDict = cityDict;
    [self.provinceTableView reloadData];
}

- (void)setCityDataSource:(NSArray *)cityDataSource {
    
    _cityDataSource = cityDataSource;
    [self.cityTableView reloadData];
}

#pragma mark - lazy
- (UIView *)titleBgView {
    
    if (!titleBgView) {
        
        CGFloat bgHeight = TitleBgheight;
        titleBgView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height, ScreenWidth, bgHeight)];
        titleBgView.userInteractionEnabled = YES;
        titleBgView.alpha = 0;
        [self addSubview:titleBgView];
        
        [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.scrollView.mas_top);
            make.height.equalTo(@80);
        }];
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 25)];
        titleLabel.text = @"所在区域";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleBgView addSubview:titleLabel];
        
        // 完成、取消按钮
        for (int i = 0; i < 2; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15, 0, 45, 30);
            button.centerY = titleLabel.centerY;
            button.backgroundColor = [UIColor redColor];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.cornerRadius = 5;
            button.alpha = i == 0 ? 1 : 0;
            [button setTitle:i == 0 ? @"取消" : @"完成" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [titleBgView addSubview:button];
            
            if (i == 1) {
                
                button.backgroundColor = kMainColor;
                button.x = titleBgView.width - 60;
                [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    self.isShowCityList = NO;
                }];
                self.okBtn = button;
            }
            else {
                
                [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                   
                    if (self.removeBlock) {
                        
                        [self removeFromSuperview];
                        
                        self.removeBlock();
                    }
                }];
            }
        }
        
        UIButton *selectBtn;
        for (int i = 0; i < 2; i++) {
            
            selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(ScreenWidth / 3 * i, titleLabel.height + 10, ScreenWidth / 3, bgHeight - titleLabel.height);
            selectBtn.tag = i + 666;
            selectBtn.alpha = i == 0 ? 1 : 0;
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [selectBtn setTitle:i == 0 ? @"请选择省份" : @"请选择城市" forState:UIControlStateNormal];
            [selectBtn setTitleColor:kMainColor forState:UIControlStateNormal];
            [titleBgView addSubview:selectBtn];
            
            @weakify(self);
            [[selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self.scrollView setContentOffset:CGPointMake(ScreenWidth * i, 0) animated:YES];
            }];
        }
        
        self.lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectBtn.frame) - 2, ScreenWidth / 3, 2)];
        self.lineView.backgroundColor = kMainColor;
        [titleBgView addSubview:self.lineView];
    }
    
    return titleBgView;
}


#pragma mark - lazy
- (UIScrollView *)scrollView {
    
    if (!scrollView) {
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.height + TitleBgheight, ScreenWidth, self.height / 2 - TitleBgheight)];
        scrollView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.alpha = 0;
        [self addSubview:scrollView];
    }
    
    return scrollView;
}

// 城市
- (UITableView *)cityTableView {
    
    if (!cityTableView) {
        
        cityTableView = [[UITableView alloc] initWithFrame:self.provinceTableView.frame];
        cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cityTableView.x = ScreenWidth;
        cityTableView.dataSource = self;
        cityTableView.delegate = self;
        [self.scrollView addSubview:self.cityTableView];
    }
    
    return cityTableView;
}

// 省
- (UITableView *)provinceTableView {
    
    if (!provinceTableView) {
        
        provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scrollView.height)];
        provinceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        provinceTableView.dataSource = self;
        provinceTableView.delegate = self;
        [self.scrollView addSubview:provinceTableView];
    }
    
    return provinceTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 判断是否省份
    if (tableView == provinceTableView) {
        return self.cityDict.allKeys.count;
    }
    
    return self.cityDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CityCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        
        UIImageView *selImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 14)];
        selImgView.image = [UIImage imageNamed:@"pirce_select"];
        cell.accessoryView = selImgView;
        cell.accessoryView.hidden = YES;
    }
    
    if (tableView == provinceTableView) {
        cell.textLabel.text = self.cityDict.allKeys[indexPath.row];
    }
    else {
        cell.textLabel.text = self.cityDataSource[indexPath.row];
    }
    
    NSString *titleString = tableView == provinceTableView ? self.provinceString : self.cityString;
    if ([cell.textLabel.text isEqualToString:titleString]) cell.accessoryView.hidden = NO;
    else cell.accessoryView.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == provinceTableView) {
        
        self.provinceString = self.cityDict.allKeys[indexPath.row];
        self.cityDataSource = self.cityDict[self.provinceString];
        [self.provinceTableView reloadData];
        
        UIButton *button = [self viewWithTag:666];
        [UIView animateWithDuration:0.3 animations:^{
            
            [button setTitleColor:[UIColor colorWithHexString:@"0x333333"] forState:UIControlStateNormal];
            [button setTitle:self.provinceString forState:UIControlStateNormal];
        }];
        
        self.scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    }
    else {
     
        self.cityString = self.cityDataSource[indexPath.row];
        
        UIButton *button = [self viewWithTag:667];
        [UIView animateWithDuration:0.3 animations:^{
            
            [button setTitleColor:[UIColor colorWithHexString:@"0x333333"] forState:UIControlStateNormal];
            [button setTitle:self.cityString forState:UIControlStateNormal];
        }];
    }
    
    [tableView reloadData];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *titleString = tableView == provinceTableView ? self.provinceString : self.cityString;
    if ([cell.textLabel.text isEqualToString:titleString]) cell.accessoryView.hidden = NO;
    else cell.accessoryView.hidden = YES;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.isShowCityList = !self.isShowCityList;
//}

#pragma mark - UIScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        
        CGFloat offsetX = scrollView.contentOffset.x / ScreenWidth;
        
        UILabel *cityLabel = [self viewWithTag:667];
        if (cityLabel.alpha != 1) {
            cityLabel.alpha = offsetX;
            self.okBtn.alpha = offsetX;
        }
        
        NSLog(@"%.2f", scrollView.contentOffset.x);
        self.lineView.x = ScreenWidth / 3 * offsetX;
    }
}

@end
