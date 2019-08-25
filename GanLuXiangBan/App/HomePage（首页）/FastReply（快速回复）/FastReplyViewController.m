//
//  FastReplyViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "FastReplyViewController.h"
#import "QuickReplysReuqest.h"
#import "QuickReplyView.h"
#import "QuickReplyModel.h"
#import "AddFasetReplyViewController.h"

@interface FastReplyViewController ()

@property (nonatomic ,strong) QuickReplyView *quickReplyView;

@property (nonatomic ,strong) UIButton *collectionButton;

@property (nonatomic ,assign) BOOL isEdit;

@property (nonatomic ,strong) UIBarButtonItem *rightBarBtn;

@property (nonatomic ,strong) UIView *deleteView;

@property (nonatomic ,strong) UIButton *button;

@end

@implementation FastReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"快捷回复";
    
    [self initUI];
    
    [self initNav];
    
    [self block];
    
}

//即将进入
- (void)viewWillAppear:(BOOL)animated{
    [self request];
}

-(void)initUI{
    
    self.quickReplyView = [QuickReplyView new];
    [self.view addSubview:self.quickReplyView];
    
    self.quickReplyView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 50);
    
    self.collectionButton = [UIButton new];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.collectionButton setTitle:@"添加快捷回复" forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton setBackgroundColor: kMainColor];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectionButton];
    
    self.collectionButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
    self.deleteView = [UIView new];
    self.deleteView.backgroundColor = [UIColor whiteColor];
    self.deleteView.hidden = YES;
    [self.view addSubview:self.deleteView];
    
    self.deleteView.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
    NSArray *titleArray = @[@"全选",@"删除"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIView *view = [UIView new];
        view.backgroundColor = i == 0 ? [UIColor whiteColor] : [UIColor lightGrayColor];
        view.tag = i + 1000;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [view addGestureRecognizer:viewTap];
        [self.deleteView addSubview:view];
        
        view.sd_layout
        .leftSpaceToView(self.deleteView, 0 + i * (ScreenWidth /2))
        .centerYEqualToView(self.deleteView)
        .heightRatioToView(self.deleteView, 1)
        .widthIs(ScreenWidth/2);
        
        UILabel *textLabel = [UILabel new];
        textLabel.text = titleArray[i];
        textLabel.font = [UIFont systemFontOfSize:18];
        textLabel.textColor = i == 0 ? [UIColor blackColor] : [UIColor whiteColor];
        [view addSubview:textLabel];
        
        textLabel.sd_layout
        .centerXEqualToView(view)
        .centerYEqualToView(view)
        .heightIs(18);
        [textLabel setSingleLineAutoResizeWithMaxWidth:100];
        
        if (i == 0) {
            
            self.button = [UIButton new];
            [self.button setImage:[UIImage imageNamed:@"Home_Hollow"] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:@"Login_Correct"] forState:UIControlStateSelected];
            self.button.selected = NO;
            [view addSubview:self.button];
            
            self.button.sd_layout
            .rightSpaceToView(textLabel, 5)
            .centerYEqualToView(textLabel)
            .widthIs(23)
            .heightIs(23);
            
        }

    }
    
}

-(void)initNav{
    
    self.isEdit = NO;
    
    self.rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBar:)];
    self.rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.rightBarBtn;
    
}

-(void)block{
    
    WS(weakSelf)
    self.quickReplyView.inputTextBlock = ^(NSString *inputTextString) {
      
        if (!weakSelf.isEdit) {
            if (weakSelf.inputTextBlock) {
                weakSelf.inputTextBlock(inputTextString);
            }
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    };
    
    self.quickReplyView.operationBlock = ^(NSString *operationString) {
      
        if (weakSelf.quickReplyView.pkids.count == 0) {
            
            UIView *view = [weakSelf.view viewWithTag:1001];
            
            view.backgroundColor = [UIColor lightGrayColor];
            
        }else{
            
            UIView *view = [weakSelf.view viewWithTag:1001];
            
            view.backgroundColor = [UIColor redColor];
            
        }
        
        if (weakSelf.quickReplyView.pkids.count == weakSelf.quickReplyView.dataSource.count) {
            weakSelf.button.selected = YES;
        }else{
            weakSelf.button.selected = NO;
        }
        
    };
    
    self.quickReplyView.selectChangeBlock = ^(NSArray *list) {
        if (weakSelf.isEdit) {
            UIView *del = [weakSelf.deleteView viewWithTag:1001];
            del.backgroundColor = list && list.count > 0 ? KRedColor : [UIColor lightGrayColor];
        }
    };
    
}

-(void)request{
    
    WS(weakSelf)
    [[QuickReplysReuqest new] getQuickReplysComplete:^(HttpGeneralBackModel *genneralBackModel) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in genneralBackModel.data) {
            
            QuickReplyModel *model = [QuickReplyModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        
        [weakSelf.quickReplyView addData:array];
        
    }];
    
}

-(void)rightBar:(UIBarButtonItem *)sender{
    
    if (self.isEdit == YES) {

        self.isEdit = NO;
        
        self.rightBarBtn.title = @"编辑";
        
        self.quickReplyView.typeInteger = 0;
        
        self.deleteView.hidden = YES;
        
    }else{

        self.isEdit = YES;
        
        self.rightBarBtn.title = @"完成";
        
        self.quickReplyView.typeInteger = 1;
        
        self.deleteView.hidden = NO;
        
    }

}

-(void)collection:(UITapGestureRecognizer *)sender{

    AddFasetReplyViewController *addFaseReplyView = [[AddFasetReplyViewController alloc] init];
    [self.navigationController pushViewController:addFaseReplyView animated:YES];
    
}

-(void)viewTap:(UITapGestureRecognizer *)sender{
    if (sender.view.tag - 1000 == 0) {
        
        if (self.button.selected == NO) {
            
            self.button.selected = YES;
            
            [self.quickReplyView allPkids];
            
        }else{
            
            self.button.selected = NO;
            
            [self.quickReplyView removePkids];
            
        }
        
    }else{
        
        if (self.quickReplyView.pkids.count == 0) {
            return;
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除快捷回复？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            WS(weakSelf)
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf commitDelreply];
            }];
            [alert addAction:cancel];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
}

- (void)commitDelreply {
    WS(weakSelf)
    [[QuickReplysReuqest new] postDelQuickReplyPkids:self.quickReplyView.pkids complete:^(HttpGeneralBackModel *genneralBackModel) {
        
        if (genneralBackModel.retcode == 0) {
            
            [weakSelf.quickReplyView removePkids];
            
//            [weakSelf request];
//
//            weakSelf.button.selected = NO;
//            weakSelf.quickReplyView.typeInteger = 0;
//            weakSelf.isEdit = NO;
//            weakSelf.rightBarBtn.title = @"编辑";
//            weakSelf.deleteView.hidden = YES;
            
        }
        
    }];
}

@end
