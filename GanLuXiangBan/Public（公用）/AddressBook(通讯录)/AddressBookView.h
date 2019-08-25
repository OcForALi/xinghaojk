//
//  AddressBookView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookTableViewCell.h"
#import "PhoneContactModel.h"

typedef void(^SelectPhoneBlock)(NSString *phoneString);

@interface AddressBookView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTable;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@property (nonatomic, strong)AddressBookTableViewCell *cell;

@property (nonatomic, copy) SelectPhoneBlock selectPhoneBlock;

@end
