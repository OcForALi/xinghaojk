//
//  LHPickerDateView.h
//  Seabuy
//
//  Created by Bruthlee on 2019/7/14.
//  Copyright © 2019 Brother Co.,Ltd. All rights reserved. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerDateViewBlock)(BOOL cancel, NSString *date);

@interface LHPickerDateView : UIView

+ (void)showIn:(UIView *)parentView action:(PickerDateViewBlock)action;

@end
