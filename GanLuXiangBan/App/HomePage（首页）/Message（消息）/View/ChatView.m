//
//  ChatView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ChatView.h"
#import "ChatTableViewCell.h"
#import "ChatImageTableViewCell.h"
#import "ChatMp3TableViewCell.h"
#import "ChatDrugTableViewCell.h"
#import "ChatRemindTableViewCell.h"

@implementation ChatView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    NSMutableArray *nsArray = [NSMutableArray array];
    
    [nsArray addObjectsFromArray:array];
    
    [nsArray addObjectsFromArray:self.dataSource];
    
    self.dataSource = nsArray;
    
    [self.myTable reloadData];
    
}

-(void)addUnderData:(NSArray *)array{
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.myTable reloadData];
    
    if (self.dataSource.count > 0) {
        
//        [self.myTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataSource.count-1]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        [self scrollViewToBottom:NO];
    }
    
}

- (void)scrollViewToBottom:(BOOL)animated

{
    if (self.myTable.contentSize.height > self.myTable.frame.size.height)
        
    {
        
//        CGPoint offset = CGPointMake(0, self.myTable.contentSize.height - self.myTable.frame.size.height);
//
//        [self.myTable setContentOffset:offset animated:animated];
        
        CGPoint offset = CGPointMake(0, self.myTable.contentSize.height - self.myTable.frame.size.height/10);
        [self.myTable setContentOffset:offset animated:animated];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorColor = [UIColor clearColor];
    self.myTable.backgroundColor = [UIColor clearColor];
    [self addSubview:self.myTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MessageModel *messageModel = self.dataSource[section];
    
    return messageModel.items.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (CGFloat)cellContentViewWith{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGB(207, 207, 207);
    [view addSubview:bgView];
    
    bgView.sd_layout
    .centerYEqualToView(view)
    .centerXEqualToView(view)
    .heightIs(25)
    .widthIs(100);
    
    MessageModel *messageModel = self.dataSource[section];
 
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = messageModel.minute;
    [view addSubview:label];
    
    label.sd_layout
    .centerXEqualToView(view)
    .centerYEqualToView(view)
    .heightIs(12);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    label.didFinishAutoLayoutBlock = ^(CGRect frame) {
        
        bgView.sd_resetLayout
        .xIs(frame.origin.x - 5)
        .yIs(frame.origin.y-4)
        .widthIs(frame.size.width + 10)
        .heightIs(20);
        
    };
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MessageModel *messageModel = self.dataSource[indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[indexPath.row]];
    
    if ([model.msg_type integerValue] == 1) {
        
        return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatImageTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
        
    }else if ([model.msg_type integerValue] == 2){
        
        if ([model.user_type integerValue] == 0) {
            
            return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatRemindTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
            
        }else{
            
           return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatDrugTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
            
        }

    }else if ([model.msg_type integerValue] == 3){
        
        return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatRemindTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
        
    }else if ([model.msg_type integerValue] == 4) {
        
        return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatMp3TableViewCell class]  contentViewWidth:[self cellContentViewWith]];
        
    } else{
        
        return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChatTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"ChatTableViewCell";

    ChatTableViewCell *chatCell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!chatCell)
    {
        chatCell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    static NSString *chatImageIdentifier = @"ChatImageTableViewCell";
    
    ChatImageTableViewCell *chatImageCell = [tableView dequeueReusableCellWithIdentifier:chatImageIdentifier];
    
    if (!chatImageCell)
    {
        chatImageCell = [[ChatImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatImageIdentifier];
    }
    
    static NSString *chatMp3Identifier = @"ChatMp3TableViewCell";
    
    ChatMp3TableViewCell *chatMp3Cell = [tableView dequeueReusableCellWithIdentifier:chatMp3Identifier];
    
    if (!chatMp3Cell)
    {
        chatMp3Cell = [[ChatMp3TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatMp3Identifier];
    }
    
    static NSString *chatDrugIdentifier = @"ChatDrugTableViewCell";
    
    ChatDrugTableViewCell *chatDrugCell = [tableView dequeueReusableCellWithIdentifier:chatDrugIdentifier];
    
    if (!chatDrugCell)
    {
        chatDrugCell = [[ChatDrugTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatDrugIdentifier];
    }
    
    static NSString *chatRemindIdentifier = @"ChatRemindTableViewCell";
    
    ChatRemindTableViewCell *chatRemindCell = [tableView dequeueReusableCellWithIdentifier:chatRemindIdentifier];
    
    if (!chatRemindCell)
    {
        chatRemindCell = [[ChatRemindTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatRemindIdentifier];
    }
    
    MessageModel *messageModel = self.dataSource[indexPath.section];
    
    NSLog(@"对话数据 %@",messageModel.items[indexPath.row]);
    
    NSLog(@"--- %@",[messageModel.items[indexPath.row] objectForKey:@"rcd_contents"]);
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[indexPath.row]];
    
    NSLog(@"对话类型 %@",model.msg_type);
    
    if ([model.msg_type integerValue] == 1) {
        
        chatImageCell.model = model;
        
        chatImageCell.iconImageView.userInteractionEnabled = YES;
        chatImageCell.iconImageView.sd_indexPath = indexPath;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
        [chatImageCell.iconImageView addGestureRecognizer:headTap];
        
        return chatImageCell;
        
    }else if ([model.msg_type integerValue] == 2){
        
        if ([model.user_type integerValue] == 0) {
            
            chatRemindCell.model = model;
            chatRemindCell.detailsButton.sd_indexPath = indexPath;
            [chatRemindCell.detailsButton addTarget:self action:@selector(showDrugsDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            chatRemindCell.iconImageView.userInteractionEnabled = YES;
            chatRemindCell.iconImageView.sd_indexPath = indexPath;
            
            UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
            [chatRemindCell.iconImageView addGestureRecognizer:headTap];
            
            return chatRemindCell;
            
        }else{
            
            chatDrugCell.model = model;
            chatDrugCell.continueButton.sd_indexPath = indexPath;
            [chatDrugCell.continueButton addTarget:self action:@selector(continueButton:) forControlEvents:UIControlEventTouchUpInside];
            
            chatDrugCell.detailsButton.sd_indexPath = indexPath;
            [chatDrugCell.detailsButton addTarget:self action:@selector(showDrugRecommend:) forControlEvents:UIControlEventTouchUpInside];
            
            chatDrugCell.iconImageView.userInteractionEnabled = YES;
            chatDrugCell.iconImageView.sd_indexPath = indexPath;
            
            UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
            [chatDrugCell.iconImageView addGestureRecognizer:headTap];
            
            return chatDrugCell;
            
        }

    }else if ([model.msg_type integerValue] == 3){
        
        chatRemindCell.model = model;
        chatRemindCell.detailsButton.sd_indexPath = indexPath;
        [chatRemindCell.detailsButton addTarget:self action:@selector(showDrugsDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        chatRemindCell.iconImageView.userInteractionEnabled = YES;
        chatRemindCell.iconImageView.sd_indexPath = indexPath;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
        [chatRemindCell.iconImageView addGestureRecognizer:headTap];
        
        return chatRemindCell;
        
    }
    else if ([model.msg_type integerValue] == 4){
        
        chatMp3Cell.model = model;
        
        chatMp3Cell.iconImageView.userInteractionEnabled = YES;
        chatMp3Cell.iconImageView.sd_indexPath = indexPath;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
        [chatMp3Cell.iconImageView addGestureRecognizer:headTap];
        
        return chatMp3Cell;
        
    }
    
    else{
        
        chatCell.model = model;
        
        chatCell.iconImageView.userInteractionEnabled = YES;
        chatCell.iconImageView.sd_indexPath = indexPath;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
        [chatCell.iconImageView addGestureRecognizer:headTap];
        
        return chatCell;
        
    }
    
}

-(void)continueButton:(UIButton *)sender{
    
    MessageModel *messageModel = self.dataSource[sender.sd_indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[sender.sd_indexPath.row]];
    
    InitialRecipeInfoModel *initialRecipeInfoModel = [InitialRecipeInfoModel new];
    
    initialRecipeInfoModel.mid = self.mid;
    
    initialRecipeInfoModel.medical_id = model.medical_id;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in model.druguse) {
        
        [array addObject:@{@"drug_code":[NSString stringWithFormat:@"%@",dict[@"drug_code"]],@"qty":[NSString stringWithFormat:@"%@",dict[@"qty"]]}];
        
    }
    
    initialRecipeInfoModel.drugs = array;
    
    if (self.drugPushBlock) {
        self.drugPushBlock(initialRecipeInfoModel);
    }

}

-(void)showDrugsDetail:(UIButton *)sender{
    
    MessageModel *messageModel = self.dataSource[sender.sd_indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[sender.sd_indexPath.row]];
    
    if (self.detailsPushBlock) {
        self.detailsPushBlock(model);
    }
    
}

-(void)showDrugRecommend:(UIButton *)sender{
    
    MessageModel *messageModel = self.dataSource[sender.sd_indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[sender.sd_indexPath.row]];
    
    
    if (self.drugDetailsBlock) {
        self.drugDetailsBlock(model);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel *messageModel = self.dataSource[indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[indexPath.row]];
    
    if ([model.msg_type integerValue] == 1) {
        
        self.imageString = model.rcd_contents;
        
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = 0;
        photoBrowser.imageCount = 1;
        photoBrowser.sourceImagesContainerView = self;
        
        [photoBrowser show];
        
    }else if ([model.msg_type integerValue] == 4){
        
        [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        
        self.player = [[AVPlayer alloc]init];
        
        [self.playItem removeObserver:self forKeyPath:@"status"];
        
        self.playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.rcd_contents]];
        
        [self.player replaceCurrentItemWithPlayerItem:self.playItem];
        
        [self.playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
}

-(void)headTap:(UITapGestureRecognizer *)sender{

    MessageModel *messageModel = self.dataSource[sender.view.sd_indexPath.section];
    
    ChatModel *model = [ChatModel new];
    [model setValuesForKeysWithDictionary:messageModel.items[sender.view.sd_indexPath.row]];
    
    if ([model.user_type integerValue] == 0) {
        
        if (self.patientsDetailPushBlock) {
            self.patientsDetailPushBlock(model.createuser);
        }
        
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{

    //判断链接状态
    if ([keyPath isEqualToString:@"status"]) {
        if (self.playItem.status == AVPlayerItemStatusFailed) {
            NSLog(@"连接失败");

        }else if (self.playItem.status == AVPlayerItemStatusUnknown){
            NSLog(@"未知的错误");
            
        }else{
            NSLog(@"准备播放");
            
            [self.player play];
            
        }
    }
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}
// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.imageString];
}

@end
