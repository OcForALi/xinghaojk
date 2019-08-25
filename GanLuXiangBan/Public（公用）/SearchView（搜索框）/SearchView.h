//
//  SearchView.h
//  AFNetworking
//
//  Created by M on 2018/5/5.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) void (^searchBlock)(NSString *searchTextString);
@property (nonatomic, strong) void (^searchConfirm)(NSString *key);

- (void)setupSearchWord:(NSString *)word;

@end
