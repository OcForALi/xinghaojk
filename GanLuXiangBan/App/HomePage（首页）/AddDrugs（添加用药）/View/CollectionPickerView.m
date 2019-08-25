//
//  CollectionPickerView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/25.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "CollectionPickerView.h"

#import "AddDrugsRequest.h"

@interface CollectionPickerCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) BOOL selectedLabel;
@end

@implementation CollectionPickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.layer.masksToBounds = YES;
        self.label.layer.cornerRadius = 4;
        self.label.font = kFontRegular(14);
        [self.contentView addSubview:self.label];
        self.label.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    }
    return self;
}

- (void)setSelectedLabel:(BOOL)selectedLabel {
    _selectedLabel = selectedLabel;
    self.label.backgroundColor = selectedLabel ? kMainColor : kSixColor;
}

@end


@interface CollectionPickerView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UICollectionView *listView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *customButton;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) PickerType type;
@property (nonatomic, strong) PickerViewBlock block;
@property (nonatomic, strong) id lastModel;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation CollectionPickerView

+ (void)show:(PickerType)type lastModel:(id)lastModel complete:(PickerViewBlock)complete {
    CollectionPickerView *view = [[CollectionPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) type:type];
    view.block = complete;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view requestDatas];
}

- (instancetype)initWithFrame:(CGRect)frame type:(PickerType)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(0);
            make.height.mas_equalTo(300);
        }];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton.titleLabel setFont:kFontRegular(14)];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(touchCancelPicker) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton setTitleColor:kSixColor forState:UIControlStateNormal];
        [self.mainView addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.mas_equalTo(0);
            make.width.and.height.mas_equalTo(40);
        }];
        
        if (type == PickerTypeDuring) {
            self.saveButton = [self setupButton:1];
            [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.bottom.mas_equalTo(0);
                make.width.height.mas_equalTo(44);
            }];
        }
        else {
            self.customButton = [self setupButton:0];
            [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.bottom.mas_equalTo(0);
                make.height.mas_equalTo(44);
            }];
            self.saveButton = [self setupButton:1];
            [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.customButton.mas_right);
                make.right.and.bottom.mas_equalTo(0);
                make.width.height.equalTo(self.customButton);
            }];
        }
        
        self.selectedIndex = -1;
        
        CGFloat space = 14;
        CGFloat width = (ScreenWidth - 56)/3;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, 30);
        layout.minimumInteritemSpacing = space;
        layout.minimumLineSpacing = space;
        self.listView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.mainView addSubview:self.listView];
        [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancelButton.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(space);
            make.right.mas_equalTo(-space);
            make.bottom.equalTo(self.saveButton.mas_top).mas_offset(-20);
        }];
        
        self.listView.backgroundColor = [UIColor whiteColor];
        self.listView.dataSource = self;
        self.listView.delegate = self;
        [self.listView registerClass:CollectionPickerCell.class forCellWithReuseIdentifier:@"CollectionPickerCell"];
    }
    return self;
}

- (void)requestDatas {
    WS(weakSelf)
    if (self.type == PickerTypeNum) {
        [[AddDrugsRequest new] getBaseUseNumList:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0 && model.data) {
                [weakSelf generateDatas:model.data model:BaseUseNumItem.class];
            }
        }];
    }
    else if (self.type == PickerTypeInfo) {
        [[AddDrugsRequest new] getBaseUseInfoList:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0 && model.data) {
                [weakSelf generateDatas:model.data model:BaseUseInfoItem.class];
            }
        }];
    }
    else if (self.type == PickerTypeUnit) {
        [[AddDrugsRequest new] getBaseUnitMinList:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0 && model.data) {
                [weakSelf generateDatas:model.data model:BaseUnitMinItem.class];
            }
        }];
    }
    else if (self.type == PickerTypeCycle) {
        [[AddDrugsRequest new] getBaseUseCycleList:^(HttpGeneralBackModel *model) {
            if (model.retcode == 0 && model.data) {
                [weakSelf generateDatas:model.data model:BaseUseCycleItem.class];
            }
        }];
    }
    else if (self.type == PickerTypeDuring) {
        NSArray *list = @[@"天", @"周", @"月"];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        for (NSString *name in list) {
            BaseUseDuring *item = [BaseUseDuring new];
            item.name = name;
            [res addObject:item];
        }
        [self reloadDatas:res];
    }
}

- (void)generateDatas:(NSArray *)datas model:(Class)model {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in datas) {
        NSObject *item = [model new];
        [item setValuesForKeysWithDictionary:dic];
        [list addObject:item];
    }
    [self reloadDatas:list];
}

- (UIButton *)setupButton:(NSInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = index == 1 ? kMainColor : KRedColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *title = index == 1 ? @"保存" : @"自定义";
    [btn setTitle:title forState:UIControlStateNormal];
    if (index == 1) {
        [btn addTarget:self action:@selector(touchConfirmPicker) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [btn addTarget:self action:@selector(touchCustomPicker) forControlEvents:UIControlEventTouchUpInside];
    }
    [btn.titleLabel setFont:kFontRegular(15)];
    [self.mainView addSubview:btn];
    return btn;
}

- (void)reloadDatas:(NSArray *)datas {
    if (datas) {
        if (self.lastModel) {
            if (self.type == PickerTypeDuring) {
                BaseUseDuring *last = (BaseUseDuring *)self.lastModel;
                for (BaseUseDuring *item in datas) {
                    if ([item.name isEqualToString:last.name]) {
                        item.check = YES;
                        break;
                    }
                }
            }
            else if (self.type == PickerTypeCycle) {
                BaseUseCycleItem *last = (BaseUseCycleItem *)self.lastModel;
                for (BaseUseCycleItem *item in datas) {
                    if ([item.name isEqualToString:last.name]) {
                        item.check = YES;
                        break;
                    }
                }
            }
            else if (self.type == PickerTypeUnit) {
                BaseUnitMinItem *last = (BaseUnitMinItem *)self.lastModel;
                for (BaseUnitMinItem *item in datas) {
                    if ([item.minunitname isEqualToString:last.minunitname]) {
                        item.check = YES;
                        break;
                    }
                }
            }
            else if (self.type == PickerTypeNum) {
                BaseUseNumItem *last = (BaseUseNumItem *)self.lastModel;
                for (BaseUseNumItem *item in datas) {
                    if ([item.use_num_name isEqualToString:last.use_num_name]) {
                        item.check = YES;
                        break;
                    }
                }
            }
            else if (self.type == PickerTypeInfo) {
                BaseUseInfoItem *last = (BaseUseInfoItem *)self.lastModel;
                for (BaseUseInfoItem *item in datas) {
                    if ([item.use_name isEqualToString:last.use_name]) {
                        item.check = YES;
                        break;
                    }
                }
            }
        }
        self.datas = datas;
    }
    else {
        self.datas = @[];
    }
    [self.listView reloadData];
}

- (NSArray *)datas {
    if (!_datas) {
        _datas = [NSArray new];
    }
    return _datas;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionPickerCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row < self.datas.count) {
        if (self.type == PickerTypeNum) {
            BaseUseNumItem *item = [self.datas objectAtIndex:row];
            cell.label.text = item.use_num_name;
            cell.selectedLabel = item.check;
        }
        else if (self.type == PickerTypeInfo) {
            BaseUseInfoItem *item = [self.datas objectAtIndex:row];
            cell.label.text = item.use_name;
            cell.selectedLabel = item.check;
        }
        else if (self.type == PickerTypeUnit) {
            BaseUnitMinItem *item = [self.datas objectAtIndex:row];
            cell.label.text = item.minunitname;
            cell.selectedLabel = item.check;
        }
        else if (self.type == PickerTypeCycle) {
            BaseUseCycleItem *item = [self.datas objectAtIndex:row];
            cell.label.text = item.name;
            cell.selectedLabel = item.check;
        }
        else if (self.type == PickerTypeDuring) {
            BaseUseDuring *item = [self.datas objectAtIndex:row];
            cell.label.text = item.name;
            cell.selectedLabel = item.check;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row < self.datas.count && row != self.selectedIndex) {
        if (self.selectedIndex >= 0) {
            BaseUseModel *last = [self.datas objectAtIndex:self.selectedIndex];
            last.check = NO;
        }
        self.selectedIndex = row;
        BaseUseModel *current = [self.datas objectAtIndex:row];
        current.check = YES;
        [collectionView reloadData];
    }
}

- (void)touchCustomPicker {
    if (self.block) {
        self.block(PickerActionCustom, nil);
        self.block = nil;
    }
    [self touchHidePicker];
}

- (void)touchConfirmPicker {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.datas.count) {
        [self makeToast:@"请先选择"];
        return;
    }
    
    if (self.block) {
        id obj = self.datas[self.selectedIndex];
        self.block(PickerActionConfirm, obj);
        self.block = nil;
    }
    [self touchHidePicker];
}

- (void)touchCancelPicker {
    if (self.block) {
        self.block(PickerActionCancel, nil);
        self.block = nil;
    }
    [self touchHidePicker];
}

- (void)touchHidePicker {
    self.listView.dataSource = nil;
    self.listView.delegate = nil;
    [self removeFromSuperview];
}

@end
