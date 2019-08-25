//
//  FastReplyViewController.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^InputTextBlock)(NSString *inputTextString);

@interface FastReplyViewController : BaseViewController

@property (nonatomic ,copy) InputTextBlock inputTextBlock;

@end
