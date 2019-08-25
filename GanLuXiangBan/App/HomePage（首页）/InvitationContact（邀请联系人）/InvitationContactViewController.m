//
//  InvitationContactViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "InvitationContactViewController.h"
#import <Contacts/Contacts.h>
#import <MessageUI/MessageUI.h>
#import "PhoneContactModel.h"
#import "AddressBookView.h"
#import "SearchView.h"
#import "InvitationNewPhoneViewController.h"
#import "HttpRequest.h"

@interface InvitationContactViewController ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic ,retain) NSMutableArray *allArray;

@property (nonatomic ,retain) NSMutableArray *dataArray;

@property (nonatomic,retain) NSMutableArray *sectionArray;

@property (nonatomic, retain) NSMutableArray *sectionTitlesArray;

@property (nonatomic, strong) AddressBookView *addressBookView;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic ,strong) UIButton *invitationButton;

@property (nonatomic ,retain) NSMutableArray *selectPhoneArray;

@end

@implementation InvitationContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请联系人";
    
    [self requestContactAuthorAfterSystemVersion9];

    [self setUpTableSection];
    
    [self initUI];
    
    [self block];
    
}

#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
            if (error) {
                NSLog(@"授权失败");
            }else {
                
                NSLog(@"成功授权");
                
                [self openContact];
                [self setUpTableSection];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.addressBookView.sectionArray = self.sectionArray;
                    self.addressBookView.sectionTitlesArray = self.sectionTitlesArray;
                    
                });

            }
        }];
    }
    else if(status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusDenied)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusAuthorized)//已经授权
    {
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    
    self.dataArray = [NSMutableArray array];
    
    self.allArray = [NSMutableArray array];
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    WS(weakSelf)
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        PhoneContactModel *model = [PhoneContactModel new];
        
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"%@ %@", lastname, firstname);
        
        model.name = [NSString stringWithFormat:@"%@%@",firstname,lastname];

        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        for (CNLabeledValue *labeledValue in phoneNums) {
            // 2.1.获取电话号码的KEY
            NSString *phoneLabel = labeledValue.label;
            
            // 2.2.获取电话号码
            CNPhoneNumber *phoneNumer = labeledValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            
            //去掉电话中的特殊字符
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@"(" withString:@""];
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@")" withString:@""];
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@" " withString:@""];
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            model.phoneString = phoneValue;
            
            NSLog(@"%@ %@", phoneLabel, phoneValue);
            
        }
        
        [weakSelf.dataArray addObject:model];
        
        [weakSelf.allArray addObject:model];
        
    }];
    
}

//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许幸好健康医生版访问您的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void) setUpTableSection {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //create a temp sectionArray 创建一个临时sectionArray
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    // insert Persons info into newSectionArray 人信息插入newSectionArray
    for (PhoneContactModel *model in self.dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    //sort the person of each section 每个部分的人
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    self.sectionArray = newSectionArray;
    
}

-(void)initUI{
    
    UILabel *titleLaebl = [UILabel new];
    titleLaebl.text = @"   输入手机号码";
    titleLaebl.font = [UIFont systemFontOfSize:17];
    titleLaebl.textColor = [UIColor lightGrayColor];
    titleLaebl.backgroundColor = [UIColor whiteColor];
    titleLaebl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabel:)];
    [titleLaebl addGestureRecognizer:tap];
    [self.view addSubview:titleLaebl];
    
    titleLaebl.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(40);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(241, 241, 241);
    [self.view addSubview:lineView];
    
    lineView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(titleLaebl, 0)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    self.searchView = [SearchView new];
    [self.view addSubview:self.searchView];
    
    self.searchView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(lineView, 0)
    .heightIs(50);
    
    
    self.invitationButton = [UIButton new];
    self.invitationButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.invitationButton setTitle:@"邀请" forState:UIControlStateNormal];
    [self.invitationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.invitationButton setBackgroundColor: [UIColor grayColor]];
    [self.invitationButton addTarget:self action:@selector(invitationButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.invitationButton];
    
    self.invitationButton.sd_layout
    .centerYEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50)
    .bottomSpaceToView(self.view, 0);
    
    self.addressBookView = [AddressBookView new];
    self.addressBookView.sectionArray = self.sectionArray;
    self.addressBookView.sectionTitlesArray = self.sectionTitlesArray;
    [self.view addSubview:self.addressBookView];
    
    self.addressBookView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.searchView, 0)
    .bottomSpaceToView(self.invitationButton, 0);
    
}

-(void)block{
    
    self.selectPhoneArray = [NSMutableArray new];
    
    WS(weakSelf)
    
    [self.searchView setSearchBlock:^(NSString *searchTextString) {
        [weakSelf search:searchTextString];
    }];
    
    [self.addressBookView setSelectPhoneBlock:^(NSString *phoneString) {
        
        if ([weakSelf.selectPhoneArray containsObject:phoneString]) {
            [weakSelf.selectPhoneArray removeObjectAtIndex:[weakSelf.selectPhoneArray indexOfObject:phoneString]];
        }else{
            [weakSelf.selectPhoneArray addObject:phoneString];
        }
        
        if (weakSelf.selectPhoneArray.count == 0) {
            [weakSelf.invitationButton setBackgroundColor: [UIColor grayColor]];
        }else{
            [weakSelf.invitationButton setBackgroundColor: kMainColor];
        }
        
    }];
    
}

-(void)search:(NSString *)string{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (PhoneContactModel *model in self.allArray) {
        
        if ([model.name containsString:string] || [model.phoneString containsString:string]) {
            
            [array addObject:model];
            
        }
 
    }
    
    if (string.length == 0) {
        self.dataArray = self.allArray;
    }else{
        self.dataArray = array;
    }

    [self setUpTableSection];
    
    self.addressBookView.sectionArray = self.sectionArray;
    self.addressBookView.sectionTitlesArray = self.sectionTitlesArray;
    
}

-(void)invitationButton:(UIButton *)sender{
    
    NSString *url = [NSString stringWithFormat:@"http://nkwx.6ewei.com/yy/views/scan.html#/?type=0&drid=%@",GetUserDefault(UserID)];
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
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    vc.body = [NSString stringWithFormat:@"邀请患者：我是%@医院的%@医生，我在幸好健康上开通了云端诊所，让我成为您的私人医生可好？关注请点击链接：%@",GetUserDefault(UserHospital),GetUserDefault(UserName),url];
    
    // 设置收件人列表
    vc.recipients = self.selectPhoneArray;  // 号码数组
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
 
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        NSLog(@"发送失败");
    }
}

-(void)titleLabel:(UITapGestureRecognizer *)sender{
    
    InvitationNewPhoneViewController *newPhoneView = [[InvitationNewPhoneViewController alloc] init];
    [self.navigationController pushViewController:newPhoneView animated:YES];
    
}

@end
