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
                        @{@"titleName":@"医院",@"placeholderString":@"必填"},
                        @{@"titleName":@"科室",@"placeholderString":@"必填"},
                        @{@"titleName":@"职称",@"placeholderString":@"必填"}
                        ];
    NSMutableArray *secton1 = [NSMutableArray array];
    
    for (NSDictionary *dict in array1) {
        FillInDataModel *model = [FillInDataModel new];
        [model setValuesForKeysWithDictionary:dict];
        [secton1 addObject:model];
    }
    
    NSArray *array2 = @[
                        @{@"titleName":@"擅长",@"placeholderString":@"选填"},
                        @{@"titleName":@"简介",@"placeholderString":@"选填"}
                        ];
    NSMutableArray *secton2 = [NSMutableArray array];
    
    for (NSDictionary *dict in array2) {
        FillInDataModel *model = [FillInDataModel new];
        [model setValuesForKeysWithDictionary:dict];
        [secton2 addObject:model];
    }
    
    NSArray *array = @[
                       secton0,
                       secton1,
                       secton2];
    
    [self.dataSountArray addObjectsFromArray:array];
    
    [self.myTable reloadData];
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorColor = [UIColor clearColor];
    
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
        [self actionSheetWithTitle:@"请选择性别" titles:titles isCan:NO completeBlock:^(NSInteger index) {
            
            model.messageString = titles[index];
            
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
        
    }else{
        
        NSDictionary *dict = @{@"姓名":@"EditUserInfoViewController",@"医院":@"SelHospitalViewController",@"科室":@"SelDepartmentViewController",@"擅长":@"ModifyViewController",@"简介":@"ModifyViewController"};
        
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
                    
                }else{
                    
                    BaseViewController *viewController = [NSClassFromString([dict objectForKey:allKeys[index]]) new];
                    viewController.title = allKeys[index];
                    
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
