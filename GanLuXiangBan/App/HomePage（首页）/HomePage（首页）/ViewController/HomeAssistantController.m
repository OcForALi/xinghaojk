//
//  HomeAssistantController.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/18.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "HomeAssistantController.h"

#import "HomeRequest.h"

#import "MessageViewController.h"

@interface HomeAssistantController ()

@end

@implementation HomeAssistantController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"药师助理接待";
    if (self.model) {
        [self setupUI];
    }
}

- (void)touchBottomToComu {
//    WS(weakSelf)
//    NSString *msgType = [NSString stringWithFormat:@"%@", @(self.model.msgType)];
//    [HomeRequest transferDoctor:self.model.clerkId receiveId:self.model.receiveId msgType:msgType patientDescribe:self.model.patientDescribe clerkMemo:self.model.clerkMemo type:self.model.type complete:^(HttpGeneralBackModel *generalBackModel) {
//        if (generalBackModel.retcode == 0) {
//            MessageViewController *msg = [MessageViewController new];
//            msg.mid = weakSelf.model.clerkId;
//            if ([msg.mid rangeOfString:@"_clerk"].location != NSNotFound) {
//                msg.mid = [msg.mid stringByReplacingOccurrencesOfString:@"_clerk" withString:@""];
//            }
//            msg.patientName = weakSelf.model.clerkName;
//            msg.patientAge = weakSelf.model.memberAge;
//            msg.patientGender = weakSelf.model.memberSex;
//            msg.title = weakSelf.model.clerkName;
//            [weakSelf.navigationController pushViewController:msg animated:YES];
//        }
//        else if (generalBackModel.retmsg) {
//            [weakSelf.view makeToast:generalBackModel.retmsg];
//        }
//    }];
}

- (void)setupUI {
    CGFloat space = 14;
    CGFloat width = (ScreenWidth - 4*space)/3;
    UILabel *name = [self setupLabel:[NSString stringWithFormat:@"姓名：%@", self.model.clerkName]];
    name.sd_layout.topSpaceToView(self.view, 20).leftSpaceToView(self.view, space).heightIs(30).widthIs(width);
    UILabel *age = [self setupLabel:[NSString stringWithFormat:@"年龄：%@", self.model.memberAge]];
    age.textAlignment = NSTextAlignmentCenter;
    age.sd_layout.topEqualToView(name).leftSpaceToView(name, 0).heightRatioToView(name, 1).widthRatioToView(name, 1);
    UILabel *sex = [self setupLabel:[NSString stringWithFormat:@"性别：%@", self.model.memberSex]];
    sex.textAlignment = NSTextAlignmentRight;
    sex.sd_layout.topEqualToView(name).rightSpaceToView(self.view, space);
    
    UILabel *huan = [self setupLabel:@"患者主述："];
    huan.sd_layout.topSpaceToView(name, 24).leftSpaceToView(self.view, space).heightIs(30).widthIs(140);
    
    UILabel *huanDes = [self setupLabel:self.model.patientDescribe];
    huanDes.sd_layout.topSpaceToView(huan, 14).leftSpaceToView(self.view, space).rightSpaceToView(self.view, space).autoHeightRatio(0);
    
    UILabel *remark = [self setupLabel:@"助理备注："];
    remark.sd_layout.topSpaceToView(huanDes, 24).leftSpaceToView(self.view, space).heightIs(30).widthIs(140);
    UILabel *remarkDes = [self setupLabel:self.model.clerkMemo];
    remarkDes.sd_layout.topSpaceToView(remark, 14).leftSpaceToView(self.view, space).rightSpaceToView(self.view, space).autoHeightRatio(0);
    
    UIButton *bottom = [self setupBottomButton:@"与患者沟通"];
    [bottom addTarget:self action:@selector(touchBottomToComu) forControlEvents:UIControlEventTouchUpInside];
}

- (UILabel *)setupLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kMainTextColor;
    label.font = kFontRegular(14);
    label.text = text;
    [self.view addSubview:label];
    return label;
}

@end
