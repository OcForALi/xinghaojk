//
//  CheckListDetailsViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CheckListDetailsViewController.h"
#import "CheckListDetailsViewModel.h"
#import "CheckListDetailsView.h"
#import "CheckTimeListView.h"
#import "TrendViewController.h"
#import "SDPhotoBrowser.h"

@interface CheckListDetailsViewController () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) CheckListDetailsView *checkListDetailsView;
@property (nonatomic, strong) CheckTimeListView *checkTimeListView;
@property (nonatomic, strong) NSArray *times;
@property (nonatomic, strong) NSMutableArray *imgUrls;

@end

@implementation CheckListDetailsViewController
@synthesize checkListDetailsView;
@synthesize checkTimeListView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = self.model.name;
    self.imgUrls = [NSMutableArray array];
    [self addBtn];
    [self getDataSource:self.model.chk_id];
    [self getYear];

    @weakify(self);
    [self addNavRightTitle:@"列表" complete:^{
        @strongify(self);
        self.checkTimeListView.navName = self.title;
        self.checkTimeListView.dataSource = self.times;
        self.checkTimeListView.isHidden = NO;
    }];
}

- (void)addBtn {

    NSArray *titles = @[@"查看原图", @"趋势图"];
    NSArray *colors = @[[UIColor colorWithHexString:@"0xff9500"], kMainColor];
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth / 2 * i, CGRectGetMaxY(self.checkListDetailsView.frame), ScreenWidth / 2, 50);
        button.backgroundColor = colors[i];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            if (i == 1) {
                
//                NSMutableArray *items = [NSMutableArray array];
//                for (CheckItemsModel *model in self.checkListDetailsView.model.items) {
//                    [items addObject:[NSString stringWithFormat:@"%@",model.chk_demo_id]];
//                }
                
                TrendViewController *vc = [TrendViewController new];
//                vc.items = items;
                vc.midString = self.model.mid;
                vc.chkTypeId = self.model.chk_type_id;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            else {
                
                if (self.imgUrls.count > 0) {
                    
                    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
                    photoBrowser.delegate = self;
                    photoBrowser.currentImageIndex = 0;
                    photoBrowser.imageCount = self.imgUrls.count;
                    photoBrowser.sourceImagesContainerView = self.view;
                    [photoBrowser show];
                }
                else {
                    
                    [self.view makeToast:@"当前无图片"];
                }
            }
        }];
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return nil;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    return [NSURL URLWithString:self.imgUrls[index]];
}

#pragma mark - lazy
- (CheckListDetailsView *)checkListDetailsView {
    
    if (!checkListDetailsView) {
        
        checkListDetailsView = [[CheckListDetailsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
        [self.view addSubview:checkListDetailsView];
    }
    
    return checkListDetailsView;
}

- (CheckTimeListView *)checkTimeListView {
    
    if (!checkTimeListView) {
        
        checkTimeListView = [[CheckTimeListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [[UIApplication sharedApplication].keyWindow addSubview:checkTimeListView];
        
        @weakify(self);
        [checkTimeListView setDismissBlock:^{
           
            @strongify(self);
            [self.checkTimeListView removeFromSuperview];
            self.checkTimeListView = nil;
        }];
        
        [checkTimeListView setSelectChkModel:^(CheckYearItemsModel *model) {
            
            @strongify(self);
            [self.checkTimeListView removeFromSuperview];
            self.checkTimeListView = nil;
            [self getDataSource:model.chk_id];
            
        }];
    }
    
    return checkTimeListView;
}


#pragma mark - request
- (void)getDataSource:(NSString *)chkId {
    
    [[CheckListDetailsViewModel new] getChkTypeListWithChkId:chkId complete:^(id object) {
        
        self.checkListDetailsView.model = object;
        [self getFiles];
    }];
}

- (void)getYear {
    
    [[CheckListDetailsViewModel new] getChkListByYearWithTypeId:self.model.chk_type_id mid:self.model.mid complete:^(id object) {
        self.times = object;
    }];
}

- (void)getFiles {
    
    [[CheckListDetailsViewModel new] getChkFilesWithGroupid:self.checkListDetailsView.model.group_id complete:^(id object) {
        self.imgUrls = object;
    }];
}


@end
