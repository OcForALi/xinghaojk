//
//  DrugRightView.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugRightView.h"
#import "DrugRightCell.h"

@interface DrugRightView () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation DrugRightView
@synthesize collectionView;

#pragma mark - set
- (void)setDataSource:(NSArray *)dataSource {
    
    _dataSource = dataSource;
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    [self.collectionView reloadData];
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    
    if (!collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.itemSize = CGSizeMake((self.width - 15) / 2, (self.width - 15) / 2);
        
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[DrugRightCell class] forCellWithReuseIdentifier:@"DrugRightCell"];
        [self addSubview:collectionView];
    }
    
    return collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DrugRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DrugRightCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.item];
    cell.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DrugModel *model = self.dataSource[indexPath.row];
    
    if (self.didSelectBlock) {
        self.didSelectBlock(model.id, model.name);
    }
    
}

@end
