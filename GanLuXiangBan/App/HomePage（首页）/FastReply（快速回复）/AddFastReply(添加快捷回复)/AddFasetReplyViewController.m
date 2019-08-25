//
//  AddFasetReplyViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddFasetReplyViewController.h"
#import "CustomTextView.h"
#import "QuickReplysReuqest.h"

@interface AddFasetReplyViewController ()<UITextViewDelegate>

@property (nonatomic ,strong) CustomTextView *remarkTextView;
@property (nonatomic ,strong) UILabel *residueLabel;// 输入文本时剩余字数

@end

@implementation AddFasetReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加内容";
    
    [self initUI];
    
    [self initNav];
    
}

-(void)initUI{
    
    self.remarkTextView = [CustomTextView new];
    self.remarkTextView.placeholder = @"请输入快捷回复内容";
    self.remarkTextView.placeholderColor = [UIColor lightGrayColor];
    self.remarkTextView.tag = 1000;
    self.remarkTextView.textColor = [UIColor blackColor];
    self.remarkTextView.font = [UIFont systemFontOfSize:13];
    self.remarkTextView.delegate = self;
    self.remarkTextView.layer.borderWidth = 1;
    self.remarkTextView.layer.borderColor = RGB(237, 237, 237).CGColor;
    [self.view addSubview:self.remarkTextView];
    
    self.remarkTextView.sd_layout
    .leftSpaceToView(self.view, 15)
    .topSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(150);
    
    self.residueLabel = [UILabel new];
    self.residueLabel.text = @"0/100";
    self.residueLabel.font = [UIFont systemFontOfSize:12];
    self.residueLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.residueLabel];
    
    self.residueLabel.sd_layout
    .rightSpaceToView(self.view, 20)
    .topSpaceToView(self.remarkTextView, -18)
    .heightIs(12);
    [self.residueLabel setSingleLineAutoResizeWithMaxWidth:100];
    
}

-(void)initNav{
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(rightBar:)];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

-(void)rightBar:(UIBarButtonItem *)sender{
    
    WS(weakSelf);
    if (self.remarkTextView.text.length != 0) {
        
        [[QuickReplysReuqest new] postSaveQuickReplyContent:self.remarkTextView.text pkid:@"0" complete:^(HttpGeneralBackModel *genneralBackModel) {
            
            if (genneralBackModel.retcode == 0) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
            
        }];
        
    }
    
}

-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    
    if (range.location >= 100){
        
        return NO;
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self.residueLabel setText:[NSString stringWithFormat:@"%ld/100",self.remarkTextView.text.length]];
    
}

@end
