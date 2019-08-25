//
//  ChatKeyboardView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatKeyboardView.h"
#import "lame.h"
#import "VoiceConvert.h"
#import "BBVoiceRecordController.h"

@interface ChatKeyboardView()
@property (nonatomic, strong) BBVoiceRecordController *recordCtrl;
@property (nonatomic, strong) NSTimer *recordTimer;
@end

@implementation ChatKeyboardView

- (BBVoiceRecordController *)recordCtrl {
    if (_recordCtrl == nil) {
        _recordCtrl = [BBVoiceRecordController new];
    }
    return _recordCtrl;
}

- (void)startRecordTimer {
    [self destoryRecordTimer];
    self.recordTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(recordTimerRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.recordTimer forMode:NSRunLoopCommonModes];
}

- (void)recordTimerRun {
    [self.recorder updateMeters];
    float voice = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    [self.recordCtrl updatePower:voice];
}

- (void)destoryRecordTimer {
    if (self.recordTimer) {
        [self.recordTimer invalidate];
        self.recordTimer = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}

-(void)setIsPicture:(NSInteger)isPicture{
    
    _isPicture = isPicture;
    
    [self initUI];
    
}

-(void)initUI{
    
    self.typeImageView = [UIImageView new];
    self.typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.typeImageView.image = [UIImage imageNamed:@"Keyboard_Record"];
    self.typeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(type:)];
    [self.typeImageView addGestureRecognizer:typeTap];
    [self addSubview:self.typeImageView];
    
    self.typeImageView.sd_layout
    .leftSpaceToView(self,10)
    .topSpaceToView(self, 10)
    .widthIs(30)
    .heightEqualToWidth();
    
    self.addImageView = [UIImageView new];
    self.addImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.addImageView.image = [UIImage imageNamed:@"Keyboard_Add"];
    self.addImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(add:)];
    [self.addImageView addGestureRecognizer:addTap];
    [self addSubview:self.addImageView];
    
    self.addImageView.sd_layout
    .rightSpaceToView(self, 10)
    .topSpaceToView(self, 10)
    .widthIs(30)
    .heightEqualToWidth();

    self.inputTextField = [BaseTextField textFieldWithPlaceHolder:nil headerViewText:nil];
    self.inputTextField.returnKeyType = UIReturnKeySend;
    self.inputTextField.delegate = self;
    [self addSubview:self.inputTextField];
    
    self.inputTextField.sd_layout
    .leftSpaceToView(self.typeImageView, 15)
    .centerYEqualToView(self.typeImageView)
    .rightSpaceToView(self.addImageView, 15)
    .heightIs(40);
    
    self.sendLabel = [UILabel new];
    self.sendLabel.text = @"发送";
    self.sendLabel.font = [UIFont systemFontOfSize:14];
    self.sendLabel.textColor = [UIColor whiteColor];
    self.sendLabel.backgroundColor = kMainColor;
    self.sendLabel.textAlignment = NSTextAlignmentCenter;
    self.sendLabel.layer.cornerRadius = 5;
    self.sendLabel.layer.masksToBounds = YES;
    self.sendLabel.hidden = YES;
    self.sendLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send:)];
    [self.sendLabel addGestureRecognizer:sendTap];
    [self addSubview:self.sendLabel];
    
    self.sendLabel.sd_layout
    .rightSpaceToView(self, 10)
    .leftSpaceToView(self.inputTextField, 5)
    .heightIs(40)
    .centerYEqualToView(self.inputTextField);
    
    self.recordLaebl = [UILabel new];
    self.recordLaebl.font = [UIFont systemFontOfSize:18];
    self.recordLaebl.layer.borderWidth = 1;
    self.recordLaebl.layer.borderColor = RGB(237, 237, 237).CGColor;
    self.recordLaebl.text = @"按住说话";
    self.recordLaebl.textAlignment = NSTextAlignmentCenter;
    self.recordLaebl.hidden = YES;
    self.recordLaebl.userInteractionEnabled = YES;
    //初始化一个长按手势
    UILongPressGestureRecognizer *recordLong = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(record:)];
    
    //长按等待时间
    //recordLong.minimumPressDuration = 1;
    
    //长按时候,手指头可以移动的距离
    recordLong.allowableMovement = 400;
    
    [self.recordLaebl addGestureRecognizer:recordLong];;
    [self addSubview:self.recordLaebl];
    
    self.recordLaebl.sd_layout
    .topSpaceToView(self, 8)
    .leftSpaceToView(self.typeImageView, 15)
    .rightSpaceToView(self.addImageView, 15)
    .bottomSpaceToView(self, 8);
    
    self.LogView = [UIView new];
    self.LogView.userInteractionEnabled = YES;
    UITapGestureRecognizer *logTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(log:)];
    [self.LogView addGestureRecognizer:logTap];
    [self addSubview:self.LogView];
    
    self.LogView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self.inputTextField, 10)
    .widthIs(ScreenWidth/2-10)
    .heightIs(60);
    
    UIImageView *logImageView = [UIImageView new];
    logImageView.image = [UIImage imageNamed:@"Keyboard_Log"];
    logImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.LogView addSubview:logImageView];
    
    logImageView.sd_layout
    .centerXEqualToView(self.LogView)
    .topSpaceToView(self.LogView, 5)
    .widthIs(30)
    .heightEqualToWidth();
    
    UILabel *logLabel = [UILabel new];
    logLabel.text = @"诊疗记录";
    logLabel.font = [UIFont systemFontOfSize:12];
    [self.LogView addSubview:logLabel];
    
    logLabel.sd_layout
    .centerXEqualToView(self.LogView)
    .topSpaceToView(logImageView, 5)
    .heightIs(12);
    [logLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.recommendView = [UIView new];
    self.recommendView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recommendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recommend:)];
    [self.recommendView addGestureRecognizer:recommendTap];
    [self addSubview:self.recommendView];
    
    self.recommendView.sd_layout
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.inputTextField, 10)
    .widthIs(ScreenWidth/2-10)
    .heightIs(60);
    
    UIImageView *recommendImageView = [UIImageView new];
    recommendImageView.image = [UIImage imageNamed:@"Keyboard_Recommend"];
    recommendImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.recommendView addSubview:recommendImageView];
    
    recommendImageView.sd_layout
    .centerXEqualToView(self.recommendView)
    .topSpaceToView(self.recommendView, 5)
    .widthIs(30)
    .heightEqualToWidth();
    
    UILabel *recommendLabel = [UILabel new];
    recommendLabel.text = @"推荐用药";
    recommendLabel.font = [UIFont systemFontOfSize:12];
    [self.recommendView addSubview:recommendLabel];
    
    recommendLabel.sd_layout
    .centerXEqualToView(self.recommendView)
    .topSpaceToView(recommendImageView, 5)
    .heightIs(12);
    [recommendLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(237, 237, 237);
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.recommendView, 1)
    .heightIs(1);
    
    UIView *view = [UIView new];
    view.backgroundColor = RGB(237, 237, 237);
    [self addSubview:view];
    
    view.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self.inputTextField, 15)
    .bottomSpaceToView(lineView, 10)
    .widthIs(1);
    
    NSArray *titleArray;
    NSArray *imageArray;
    
    if (self.isPicture == 1) {
        
        self.typeImageView.hidden = YES;
        
        titleArray = @[@"出诊时间",@"快捷回复"];
        imageArray = @[@"Keyboard_Time",@"Keyboard_Tag"];
        
    }else{
        
        titleArray = @[@"图片",@"出诊时间",@"快捷回复"];
        imageArray = @[@"Keyboard_Image",@"Keyboard_Time",@"Keyboard_Tag"];
        
    }
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIView *addView = [UIView new];
        addView.tag = i + 1000;
        addView.userInteractionEnabled = YES;
        UITapGestureRecognizer *addActionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAction:)];
        [addView addGestureRecognizer:addActionTap];
        [self addSubview:addView];
        
        addView.sd_layout
        .leftSpaceToView(self, 15 + i * 70)
        .topSpaceToView(lineView, 10)
        .widthIs(60)
        .heightIs(80);
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [addView addSubview:imageView];
        
        imageView.sd_layout
        .centerXEqualToView(addView)
        .topSpaceToView(addView, 0)
        .widthIs(50)
        .heightEqualToWidth();
        
        UILabel *label = [UILabel new];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:12];
        [addView addSubview:label];
        
        label.sd_layout
        .centerXEqualToView(addView)
        .topSpaceToView(imageView, 10)
        .heightIs(12);
        [label setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    
    
}

-(void)type:(UITapGestureRecognizer *)sender{
    
    UIImage *image = [UIImage imageNamed:@"Keyboard_Record"];
    NSData *data1 = UIImagePNGRepresentation(image);
    NSData *data = UIImagePNGRepresentation(self.typeImageView.image);
    
    if ([data isEqual:data1]) {
        
        self.inputTextField.hidden = YES;
        self.recordLaebl.hidden = NO;
        
        self.typeImageView.image = [UIImage imageNamed:@"Keyboard"];
        
        if (self.keyboardTypeBlock) {
            self.keyboardTypeBlock(1);
        }
        
    }else{
        
        self.inputTextField.hidden = NO;
        self.recordLaebl.hidden = YES;
        
        self.typeImageView.image = image;
        
        if (self.keyboardTypeBlock) {
            self.keyboardTypeBlock(0);
        }
        
    }
    
}

-(void)add:(UITapGestureRecognizer *)sender{
    
    if (self.keyboardTypeBlock) {
        self.keyboardTypeBlock(2);
    }
    
}

-(void)log:(UITapGestureRecognizer *)sender{
    
    if (self.pushBlock) {
        self.pushBlock(@"诊疗记录");
    }
    
}

-(void)recommend:(UITapGestureRecognizer *)sender{
    
    if (self.pushBlock) {
        self.pushBlock(@"推荐用药");
    }
    
}

-(void)addAction:(UITapGestureRecognizer *)sender{
    
    if (self.isPicture == 1){
        
        if (sender.view.tag - 1000 == 0) {
            
            if (self.pushBlock) {
                self.pushBlock(@"出诊时间");
            }
            
        }else if (sender.view.tag - 1000 == 1){
            
            if (self.pushBlock) {
                self.pushBlock(@"快捷回复");
            }
            
        }
        
    }else{
        
        if (sender.view.tag - 1000 == 0) {
            if (self.pushBlock) {
                self.pushBlock(@"图片");
            }
        }else if (sender.view.tag - 1000 == 1){
            if (self.pushBlock) {
                self.pushBlock(@"出诊时间");
            }
        }else{
            if (self.pushBlock) {
                self.pushBlock(@"快捷回复");
            }
        }
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (self.inputTextField.text.length == 0) {
        
        [self.inputTextField resignFirstResponder];
        
    }else{

        if (self.inputTextBlock) {
            self.inputTextBlock(self.inputTextField.text);
        }
        
        self.inputTextField.text = nil;
        
        [self.inputTextField resignFirstResponder];
        
    }
    
    return YES;
}

-(void)textFieldTextChange:(NSNotification *)sender{
    
    if (self.inputTextField.text.length != 0) {
        self.sendLabel.hidden = NO;
    }else{
        self.sendLabel.hidden = YES;
    }
    
}

-(void)send:(UITapGestureRecognizer *)sender{
    
    self.sendLabel.hidden = YES;
    
    if (self.inputTextBlock) {
        self.inputTextBlock(self.inputTextField.text);
    }
    
}

-(void)record:(UILongPressGestureRecognizer *)longPressGest {
    
    KLog(@"longPressGest.state: %@", @(longPressGest.state));

    if (longPressGest.state == UIGestureRecognizerStateBegan) {
        
        KLog(@"长按手势开启");
        self.recordLaebl.backgroundColor = [UIColor lightGrayColor];
        
        [self.recordCtrl updateUIWithRecordState:BBVoiceRecordState_Recording];
        [self StartRecording];
        
    }else if (longPressGest.state == UIGestureRecognizerStateChanged){
        
        self.trans = [longPressGest locationInView:longPressGest.view];
        KLog(@"position: %@",NSStringFromCGPoint(self.trans));
        
        if (self.trans.y > 0) {
            [self.recordCtrl updateUIWithRecordState:BBVoiceRecordState_Recording];
        }else{
            [self.recordCtrl updateUIWithRecordState:BBVoiceRecordState_ReleaseToCancel];
        }
    }
//    else if (longPressGest.state == UIGestureRecognizerStateEnded || longPressGest.state)
    else {
        KLog(@"长按手势结束");
        [self.recordCtrl updateUIWithRecordState:BBVoiceRecordState_Normal];
        self.recordLaebl.backgroundColor = [UIColor whiteColor];
        
        if (self.trans.y < 0) {
            [self stopRecording:0];
        }else{
            [self stopRecording:1];
        }
        
    }

}

/**
 *  开始录音
 */
-(void)StartRecording{

    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [session setActive:YES error:nil];
        
    }
    
    self.session = session;
    
    
    //1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:self.filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
 
        [self startRecordTimer];
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        
    }
    
}

// 0 = 停止录音 1= 停止录音并上传
-(void)stopRecording:(NSInteger)stopType{

    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    [self destoryRecordTimer];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self.filePath]){
        
        NSLog(@"%@",self.filePath);

    }else{
        
    }
    
    if (stopType == 1) {

        NSString *amrPath = [self GetPathByFileName:@"voice" ofType:@"amr"];
        
        if ([VoiceConvert ConvertWavToAmr:self.filePath amrSavePath:amrPath]) {
            
            if (self.uploadBlock) {
                self.uploadBlock(amrPath);
            }
            
        }else{
            NSLog(@"amr转wav 转换失败");
        }
        
//        NSString *mp3Path = [self changeWavToMp3WithOriginalPath:self.filePath];
//
//        if (self.uploadBlock) {
//            self.uploadBlock(mp3Path);
//        }

    }

}

-(NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type{
    
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}

-(NSString *)changeWavToMp3WithOriginalPath:(NSString*)originalPath{
    
    NSString * mp3Path = [[originalPath stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"sentenceRecoder.mp3"];
    
    @try {
        
        int read, write;
        
        FILE *pcm = fopen([originalPath cStringUsingEncoding:1], "rb");//source 被转换的音频文件位置
        
        fseek(pcm, 4*1024, SEEK_CUR);//skip file header
        
        FILE *mp3 = fopen([mp3Path cStringUsingEncoding:1], "wb");//output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        
        const int MP3_SIZE = 8192;
        
        short int pcm_buffer[PCM_SIZE*2];
        
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        
        lame_set_in_samplerate(lame,8000);
        
        lame_set_VBR(lame, vbr_default);
        
        lame_init_params(lame);
        
        lame_set_brate (lame, 128 );
        
        lame_set_quality(lame,2);
        
        do {
            
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            
            if (read == 0)
                
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            
            else
                
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        
        fclose(mp3);
        
        fclose(pcm);
        
    }
    
    @catch (NSException *exception) {
        
        NSLog(@"%@",[exception description]);
        
    }
    
    @finally {
        
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:originalPath error:NULL];
    
    return mp3Path;
    
}



@end
