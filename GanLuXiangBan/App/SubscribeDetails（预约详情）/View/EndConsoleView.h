//
//  EndConsoleView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/6.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EndConsoleViewBlock)(BOOL confirm);

@interface EndConsoleView : UIView

+ (void)show:(EndConsoleViewBlock)block;

@end
