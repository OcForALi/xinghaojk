//
//  ChatKeyboardView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextField.h"
#import <AVFoundation/AVFoundation.h>

// 0 = 默认 1 = 录音 2 = 更多
typedef void(^KeyboardTypeBlock)(NSInteger type);
//跳转页面
typedef void(^ChatKeyboardPushBlock)(NSString *pushString);

typedef void(^UploadBlock)(NSString *uploadFilePath);
//发送文字信息
typedef void(^InputTextBlock)(NSString *inputTextString);

@interface ChatKeyboardView : UIView<UITextFieldDelegate>

@property (nonatomic ,copy) KeyboardTypeBlock keyboardTypeBlock;

@property (nonatomic ,copy) ChatKeyboardPushBlock pushBlock;

@property (nonatomic ,copy) UploadBlock uploadBlock;

@property (nonatomic ,copy) InputTextBlock inputTextBlock;
/// isPicture = 0 默认 1 = 无图片
@property (nonatomic ,assign) NSInteger isPicture;

///键盘类型 图片按钮
@property (nonatomic ,strong) UIImageView *typeImageView;
///更多 图片按钮
@property (nonatomic ,strong) UIImageView *addImageView;
///输入栏
@property (nonatomic ,strong) BaseTextField *inputTextField;
///发送按钮
@property (nonatomic ,strong) UILabel *sendLabel;
///录音栏
@property (nonatomic ,strong) UILabel *recordLaebl;
///诊疗记录
@property (nonatomic ,strong) UIView *LogView;
///推荐用药
@property (nonatomic ,strong) UIView *recommendView;
///长按手指偏移值
@property (nonatomic ,assign) CGPoint trans;

@property (nonatomic ,copy) NSString *filePath;
@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址

@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器

@end
