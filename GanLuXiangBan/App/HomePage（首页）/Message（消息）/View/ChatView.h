//
//  ChatView.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseView.h"
#import "ChatModel.h"
#import "MessageModel.h"
#import <AVFoundation/AVFoundation.h>
#import "SDPhotoBrowser.h"
#import "InitialRecipeInfoModel.h"
//跳转页面
typedef void(^DrugPushBlock)(InitialRecipeInfoModel *initialRecipeInfoModel);

typedef void(^DetailsPushBlock)(ChatModel *model);

typedef void(^ShowDrugDetailsPushBlock)(ChatModel *model);

typedef void(^PatientsDetailPushBlock)(NSString *idString);

@interface ChatView : BaseView<UITableViewDelegate,UITableViewDataSource,SDPhotoBrowserDelegate>

@property (nonatomic ,strong) UITableView *myTable;

@property (nonatomic ,retain) NSMutableArray *dataSource;

@property (nonatomic ,copy) NSString *mid;

-(void)addData:(NSArray *)array;

-(void)addUnderData:(NSArray *)array;

@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVPlayer *player; //播放器
@property (nonatomic, strong) AVPlayerItem *playItem;

@property (nonatomic ,copy) NSString *imageString;

@property (nonatomic ,copy) DrugPushBlock drugPushBlock;

@property (nonatomic ,copy) DetailsPushBlock detailsPushBlock;

@property (nonatomic ,copy) PatientsDetailPushBlock patientsDetailPushBlock;

@property (nonatomic, copy) ShowDrugDetailsPushBlock drugDetailsBlock;

@end
