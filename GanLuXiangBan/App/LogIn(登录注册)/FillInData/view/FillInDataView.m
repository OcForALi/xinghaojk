//
//  FillInDataView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "FillInDataView.h"
#import "FillInDataModel.h"
#import "FillInDataTableViewCell.h"
#import "BaseTextField.h"
#import "ModifyViewController.h"
#import "SelDepartmentViewController.h"

@implementation FillInDataView
@synthesize footerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSountArray = [NSMutableArray array];
        
        [self initUI];
        
        [self initData];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}


#pragma mark - set
- (void)setImgDataSource:(NSArray *)imgDataSource {
    
    _imgDataSource = imgDataSource;
    
    [self.footerView removeFromSuperview];
    self.footerView = nil;
    
    self.myTable.tableFooterView = self.footerView;
}


#pragma makr - lazy
- (CityView *)cityView {
    
    if (!_cityView) {
        
        self.cityView = [[CityView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [[UIApplication sharedApplication].keyWindow addSubview:self.cityView];
        
        @weakify(self);
        [self.cityView setSelectCity:^(NSString *provinceString, NSString *cityString) {
            
            @strongify(self);
            self.myTable.scrollEnabled = YES;
//            [self reloadData];
            
            [self.cityView removeFromSuperview];
            self.cityView = nil;
        }];
        
        [self.cityView setSelCityModelBlock:^(CityModel *province, CityModel *city) {
            @strongify(self);
            FillInDataModel *model = self.dataSountArray[1][1];
            
            if (city.name != nil) {
                model.messageString = [province.name stringByAppendingString:city.name];
                model.provinceID = province.cityId;
                model.cityID = city.cityId;
            }else{
                model.messageString = province.name;
                model.provinceID = province.cityId;
            }
            
            NSMutableArray *sectionArray = self.dataSountArray[1];
            [sectionArray replaceObjectAtIndex:1 withObject:model];
            
            [self.dataSountArray replaceObjectAtIndex:1 withObject:sectionArray];
            
            [self.myTable reloadData];
            
        }];
        
        [self.cityView setRemoveBlock:^{
            
            @strongify(self);
            self.myTable.scrollEnabled = YES;
//            [self reloadData];
            
            [self.cityView removeFromSuperview];
            self.cityView = nil;
        }];
    }
    
    return _cityView;
}

- (UIView *)footerView {
    
    if (!footerView) {
        
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerView.width, 5)];
        lineView.backgroundColor = self.superview.backgroundColor;
        [footerView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 20, footerView.width, 15)];
        titleLabel.text = @"上传相关资质";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = RGB(51, 51, 51);
        titleLabel.height = [titleLabel getTextHeight];
        [footerView addSubview:titleLabel];
        
        for (int i = 0; i < self.imgDataSource.count + 1; i++) {
            
            if (i == 6) {
                break;
            }
            
            CGSize size = CGSizeMake(ScreenWidth * 0.145, ScreenWidth * 0.145);
            CGFloat spacing = (ScreenWidth - size.width * 3) / 4;
            
            UIImageView *imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.size = size;
            imageView.x = spacing + (spacing + size.width) * (i % 3);
            imageView.y = titleLabel.maxY + 20 + (size.height + 15) * (i / 3);
            imageView.image = [UIImage imageNamed:@"Keyboard_Image"];

            imageView.userInteractionEnabled = YES;
//            imageView.layer.cornerRadius = 5;
//            imageView.layer.masksToBounds = YES;
            [footerView addSubview:imageView];
            [footerView setHeight:imageView.maxY + 20];
            
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [imageView addGestureRecognizer:tap];
            
            [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                
                if (i >= self.imgDataSource.count) {
                    
                    if (self.imgClickBlock) {
                        self.imgClickBlock();
                    }
                }
            }];
            
            if (self.imgDataSource.count != 0) {
                
                if (i != self.imgDataSource.count) {
                    
                    UIImageView *deleteImage = [UIImageView new];
                    deleteImage.image = [UIImage imageNamed:@"TreatmentDeleteImg"];
                    deleteImage.contentMode = UIViewContentModeScaleAspectFit;
                    deleteImage.userInteractionEnabled = YES;
                    deleteImage.tag = i + 1000;
                    UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteImage:)];
                    [deleteImage addGestureRecognizer:deleteTap];
                    [footerView addSubview:deleteImage];
                    
                    deleteImage.sd_layout
                    .rightSpaceToView(imageView, -10)
                    .bottomSpaceToView(imageView, -10)
                    .widthIs(40)
                    .heightIs(20);
                    
                }
                
            }
            
            // 设置图片
            if (self.imgDataSource.count > i) {
                
                NSURL *url = [NSURL URLWithString:self.imgDataSource[i]];
                [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Keyboard_Image"]];
            }
            
            
            
        }
    }
    
    return footerView;
}


- (void)deleteImage:(UITapGestureRecognizer *)sender{
    
    if (self.imageDeleteBlock) {
        self.imageDeleteBlock(sender.view.tag - 1000);
    }
    
}

-(void)initData{
    
    [self.dataSountArray removeAllObjects];
    
    NSArray *array0 = @[
                        @{@"titleName":@"姓名",@"placeholderString":@"必填"},
                        @{@"titleName":@"性别",@"placeholderString":@"必填"}
                        ];
    NSMutableArray *secton0 = [NSMutableArray array];
    
    for (NSDictionary *dict in array0) {
        FillInDataModel *model = [FillInDataModel new];
        [model setValuesForKeysWithDictionary:dict];
        [secton0 addObject:model];
    }
    
    NSArray *array1 = @[
                        @{@"titleName":@"身份证号",@"placeholderString":@"必填"},
                        @{@"titleName":@"代理区域",@"placeholderString":@"必填"},
                        @{@"titleName":@"代理医院",@"placeholderString":@"必填"}
                        ];
    NSMutableArray *secton1 = [NSMutableArray array];
    
    for (NSDictionary *dict in array1) {
        FillInDataModel *model = [FillInDataModel new];
        [model setValuesForKeysWithDictionary:dict];
        [secton1 addObject:model];
    }
    
//    NSArray *array2 = @[
//                        @{@"titleName":@"擅长",@"placeholderString":@"选填"},
//                        @{@"titleName":@"简介",@"placeholderString":@"选填"}
//                        ];
//    NSMutableArray *secton2 = [NSMutableArray array];
//
//    for (NSDictionary *dict in array2) {
//        FillInDataModel *model = [FillInDataModel new];
//        [model setValuesForKeysWithDictionary:dict];
//        [secton2 addObject:model];
//    }
    
    NSArray *array = @[
                       secton0,
                       secton1
                       ];
    
    [self.dataSountArray addObjectsFromArray:array];
    
    [self.myTable reloadData];
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
//    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorColor = [UIColor clearColor];
    self.myTable.tableFooterView = self.footerView;
    
    [self addSubview:self.myTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.dataSountArray[section];
    
    return array.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSountArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FillInDataModel *model = [self.dataSountArray[indexPath.section] objectAtIndex:indexPath.row];
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[FillInDataTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    
}

- (CGFloat)cellContentViewWith{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    
    return width;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FillInDataTableViewCell";
    FillInDataTableViewCell *cell = [self.myTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FillInDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.model = [self.dataSountArray[indexPath.section] objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}

/**< 每个分组上边预留的空白高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

/**< 每个分组下边预留的空白高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FillInDataModel *model = self.dataSountArray[indexPath.section][indexPath.row];
    
    if ([model.titleName isEqualToString:@"性别"]) {
        
        NSArray *titles = @[@"男", @"女"];
        [self actionSheetWithTitle:@"请选择性别" titles:titles isCan:YES completeBlock:^(NSInteger index) {
            
            if (index == 0) {
                return ;
            }
            
            model.messageString = titles[index-1];
            
            NSMutableArray *sectionArray = self.dataSountArray[indexPath.section];
            [sectionArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            [self.dataSountArray replaceObjectAtIndex:indexPath.section withObject:sectionArray];
            
            [self.myTable reloadData];
            
        }];
        
    }else if ([model.titleName isEqualToString:@"职称"]) {
        
        NSArray *titles = @[@"主任医师", @"副主任医师", @"主治医师", @"医师"];
        [self actionSheetWithTitle:@"请选择职称" titles:titles isCan:NO completeBlock:^(NSInteger index) {
            
            model.messageString = titles[index];
            
            NSMutableArray *sectionArray = self.dataSountArray[indexPath.section];
            [sectionArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            [self.dataSountArray replaceObjectAtIndex:indexPath.section withObject:sectionArray];
            
            [self.myTable reloadData];
            
        }];
        
    }else if ([model.titleName isEqualToString:@"代理区域"]){
        
        self.cityView.isShowCityList = YES;
        self.myTable.scrollEnabled = NO;
        
    } else{
        
        NSDictionary *dict = @{ @"姓名" : @"EditUserInfoViewController",
                                @"医院" : @"SelHospitalViewController",
                                @"科室" : @"SelDepartmentViewController",
                                @"擅长" : @"ModifyViewController",
                                @"简介" : @"ModifyViewController",
                                @"身份证号" : @"EditUserInfoViewController",
                                @"代理医院" : @"SelHospitalViewController" };
        
        NSArray *allKeys = [dict allKeys];
        
        if ([allKeys containsObject:model.titleName]) {
            
            NSInteger index = [allKeys indexOfObject:model.titleName];
            
            if (self.goViewControllerBlock) {
                
                if ([model.titleName isEqualToString:@"擅长"] || [model.titleName isEqualToString:@"简介"]) {
                    
                    ModifyViewController *viewController = [[ModifyViewController alloc] init];
                    viewController.contentString = model.messageString;
                    viewController.title = allKeys[index];
                    
                    if (self.goViewControllerBlock) {
                        self.goViewControllerBlock(viewController);
                    }
                    
                }else if ([model.titleName isEqualToString:@"科室"]){
                 
                    SelDepartmentViewController *selDepartmentView = [[SelDepartmentViewController alloc] init];
                    selDepartmentView.title = allKeys[index];
                    
                    if (self.selDepartmentString != nil) {
                        selDepartmentView.selectIndex = self.selDepartmentString;
                    }
                    
                    if (self.goViewControllerBlock) {
                        self.goViewControllerBlock(selDepartmentView);
                    }
                    
                }
                else {
                    
                    BaseViewController *viewController = [NSClassFromString([dict objectForKey:allKeys[index]]) new];
                    viewController.title = allKeys[index];
                    
                    if ([model.titleName containsString:@"姓名"] || [model.titleName containsString:@"身份证号"]) {
                        [viewController setValue:model.messageString forKey:@"text"];
                    }
                    
                    if (self.goViewControllerBlock) {
                        self.goViewControllerBlock(viewController);
                    }
                    
                }
                
            }
            
        }
        
        
    }

}

#pragma mark - ActionSheet
- (void)actionSheetWithTitle:(NSString *)title titles:(NSArray *)titles isCan:(BOOL)isCan completeBlock:(ActionSheetCompleteBlock)actionSheetComplete {
    
    self.complete = actionSheetComplete;
    self.sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:isCan ? @"取消" : nil destructiveButtonTitle:nil otherButtonTitles:nil];
    self.sheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    for (int i = 0; i < titles.count; i++) {
        [self.sheet addButtonWithTitle:titles[i]];
    }
    
    [self.sheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.complete) {
        self.complete(buttonIndex);
    }
    
    [self.sheet dismissWithClickedButtonIndex:0 animated:YES];
}

//-(void)textFieldTextChange:(NSNotification *)sender{
//
//    BaseTextField *baseText = (BaseTextField *)sender.object;
//
//    FillInDataModel *model = [[self.dataSountArray objectAtIndex:baseText.indextPath.section] objectAtIndex:baseText.indextPath.row];
//
//    model.messageString = baseText.text;
//
//    NSMutableArray *modifyArray = [NSMutableArray arrayWithObject:self.dataSountArray[baseText.indextPath.section]];
//
//    [modifyArray removeObjectAtIndex:baseText.indextPath.row];
//
//    [modifyArray insertObject:model atIndex:baseText.indextPath.row];
//
//    [self.dataSountArray removeObjectAtIndex:baseText.indextPath.section];
//
//    [self.dataSountArray insertObject:modifyArray atIndex:baseText.indextPath.section];
//
//    if (self.fillInDataBlock) {
//        self.fillInDataBlock(self.dataSountArray);
//    }
//
//}

@end
