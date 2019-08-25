//
//  AddCountView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddBlock)(NSString *add);
typedef void(^SubtractBlock)(NSString *subtract);

@interface AddCountView : UIView

@property (nonatomic ,copy) NSString *addCountString;

@property (nonatomic ,strong) UILabel *addLabel;

@property (nonatomic, strong) UITextField *numBox;

@property (nonatomic, assign) BOOL showEditNum;

@property (nonatomic ,copy) AddBlock addBlock;

@property (nonatomic ,copy) SubtractBlock subtractBlock;

@end
