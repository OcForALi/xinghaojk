//
//  DrugDetailsViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/27.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugDetailsViewController.h"
#import "DrugRequest.h"
#import "DrugDetailsModel.h"
#import "DrugDetailsView.h"

@interface DrugDetailsViewController ()

@property (nonatomic ,retain) DrugRequest *drugRequest;

@property (nonatomic ,retain) DrugDetailsModel *model;

@property (nonatomic ,strong) DrugDetailsView *drugDetailsView;

@property (nonatomic ,strong) UIButton *collectionButton;

@end

@implementation DrugDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"药品详情";
    
    [self initUI];
    
}

-(void)setDrugID:(NSString *)drugID{
    
    _drugID = drugID;
    
    [self request];
    
}

- (void)dealloc
{
    if (self.drugDetailsView) {
        [self.drugDetailsView.bannerView toggleCycleScrollViewStatus:NO];
    }
}

-(void)request{
    
    self.drugRequest = [DrugRequest new];
    WS(weakSelf)
    [self.drugRequest getDrugDetailDrugID:self.drugID :^(HttpGeneralBackModel *model) {
        
        weakSelf.model = [DrugDetailsModel new];
        [weakSelf.model setValuesForKeysWithDictionary:model.data];
        
        weakSelf.drugDetailsView.model = weakSelf.model;
        
        if (weakSelf.model.is_fav == 0) {
            
            self.collectionButton.selected = NO;
            [self.collectionButton setBackgroundColor: kMainColor];
            
        }else{
            
            self.collectionButton.selected = YES;
            [self.collectionButton setBackgroundColor: [UIColor lightGrayColor]];
            
        }
        
        self.collectionButton.hidden = YES;
    }];
}

-(void)initUI{
    
    self.collectionButton = [UIButton new];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.collectionButton setTitle:@"加入常用药" forState:UIControlStateNormal];
    [self.collectionButton setTitle:@"已加入常用药" forState:UIControlStateSelected];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.collectionButton setBackgroundColor: kMainColor];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectionButton];
    
    self.collectionButton.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
    self.drugDetailsView = [DrugDetailsView new];
    [self.view addSubview:self.drugDetailsView];
    
    self.drugDetailsView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

-(void)collection:(UIButton *)sender{
    
    if (sender.selected == NO) {
        
        WS(weakSelf);
        
        [[DrugRequest new] postFavDrugID:self.model.drug_id :^(HttpGeneralBackModel *model) {
            
            if (model.retcode == 0) {
                
                [weakSelf request];
                
            }
            
        }];
        
    }
    
}

@end
