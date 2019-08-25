//
//  HospitalView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HospitalView.h"
#import "CityView.h"
#import "HospitalModel.h"

@interface HospitalView ()

@property (nonatomic, strong) CityView *cityView;

@end

@implementation HospitalView
@synthesize cityView;

#pragma makr - lazy
- (CityView *)cityView {
    
    if (!cityView) {
        
        cityView = [[CityView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        [self addSubview:cityView];
        
        @weakify(self);
        [cityView setSelectCity:^(NSString *provinceString, NSString *cityString) {
         
            @strongify(self);
            self.scrollEnabled = YES;
            self.provinceString = provinceString;
            self.cityString = cityString;
            [self reloadData];
            
//            if (self.didSelectedCity) {
//                self.didSelectedCity(provinceString, cityString);
//            }
            
        }];
    }
    
    return cityView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if (indexPath.section == 0) {
        
        if (self.provinceString.length > 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.provinceString, self.cityString];
        }
        else {
            
            cell.textLabel.text = @"选择城市";
        }
        
        cell.imageView.image = [UIImage imageNamed:@"positioningImg"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        cell.imageView.image = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if (self.dataSources.count > 0) {
            
            HospitalModel *model = self.dataSources[indexPath.row];
            cell.textLabel.text = model.name;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        [self.superview endEditing:YES];
        
        self.cityView.hidden = NO;
        self.cityView.isShowCityList = !self.cityView.isShowCityList;
//        self.scrollEnabled = !self.cityView.isShowCityList;
        self.scrollEnabled = NO;
    }
    else if (self.didSelectBlock) {
        
        HospitalModel *model = self.dataSources[indexPath.row];
        self.didSelectBlock(model.pkid, model.name);
    }
}

@end
