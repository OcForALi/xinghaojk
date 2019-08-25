//
//  InvitationNewPhoneViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "InvitationNewPhoneViewController.h"
#import "CustomTextView.h"
#import <MessageUI/MessageUI.h>
#import "HttpRequest.h"

@interface InvitationNewPhoneViewController ()<UITextViewDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic ,strong) CustomTextView *phoneTextView;

@property (nonatomic ,strong) UILabel *residueLabel;// 输入文本时剩余字数

@property (nonatomic ,strong) UIButton *invitationButton;

@end

@implementation InvitationNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新号码";
    
    [self initUI];
    
}

-(void)initUI{
    
    self.phoneTextView = [CustomTextView new];
    self.phoneTextView.placeholder = @"请输入号码";
    self.phoneTextView.placeholderColor = [UIColor lightGrayColor];
    self.phoneTextView.textColor = [UIColor blackColor];
    self.phoneTextView.font = [UIFont systemFontOfSize:13];
    self.phoneTextView.delegate = self;
    self.phoneTextView.layer.borderWidth = 1;
    self.phoneTextView.layer.borderColor = RGB(237, 237, 237).CGColor;
    [self.view addSubview:self.phoneTextView];
    
    self.phoneTextView.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(250);
    
    self.residueLabel = [UILabel new];
    self.residueLabel.text = @"0/250";
    self.residueLabel.font = [UIFont systemFontOfSize:12];
    self.residueLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.residueLabel];
    
    self.residueLabel.sd_layout
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.phoneTextView, -18)
    .heightIs(12);
    [self.residueLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.phoneTextView, 1)
    .rightSpaceToView(self.view, 0)
    .heightIs(100);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"温馨提示：";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:titleLabel];
    
    titleLabel.sd_layout
    .leftSpaceToView(view, 20)
    .topSpaceToView(view, 15)
    .heightIs(16);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"1、请按照规范（满足11位数且为正规的号码）进行手机号码的填写，手机号之间用英文分号进行分割，以免影响短信的发送。";
    contentLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:contentLabel];
    
    contentLabel.sd_layout
    .leftSpaceToView(view, 20)
    .rightSpaceToView(view, 20)
    .topSpaceToView(titleLabel, 10)
    .autoHeightRatio(0);
    
    self.invitationButton = [UIButton new];
    self.invitationButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.invitationButton setTitle:@"邀请" forState:UIControlStateNormal];
    [self.invitationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.invitationButton setBackgroundColor: kMainColor];
    [self.invitationButton addTarget:self action:@selector(invitationButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.invitationButton];
    
    self.invitationButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
}

-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    
    if (range.location >= 250){
        
        return NO;
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self.residueLabel setText:[NSString stringWithFormat:@"%lu/250",(unsigned long)self.phoneTextView.text.length]];
    
}

-(void)invitationButton:(UIButton *)sender {
    NSString *str = self.phoneTextView.text;
    if (!str || str.length == 0) {
        [self.view makeToast:@"请输入号码"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"http://nkwx.6ewei.com/yy/views/scan.html#/?drid=%@&type=0",GetUserDefault(UserID)];
    WS(weakSelf)
    [[HttpRequest new] shortUrl:url complete:^(NSString *shortUrl) {
        if (shortUrl && shortUrl.length > 0) {
            [weakSelf openMessage:shortUrl];
        }
        else {
            [weakSelf openMessage:url];
        }
    }];
}

- (void)openMessage:(NSString *)url {
    NSString *str = self.phoneTextView.text;
    NSArray *array = [str componentsSeparatedByString:@";"];
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    vc.body = [NSString stringWithFormat:@"邀请患者：我是%@医院的%@医生，我在幸好健康上开通了云端诊所，让我成为您的私人医生可好？关注请点击链接：%@",GetUserDefault(UserHospital),GetUserDefault(UserName),url];
    // 设置收件人列表
    vc.recipients = array;  // 号码数组
    // 设置代理
    vc.messageComposeDelegate = self;
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

@end
