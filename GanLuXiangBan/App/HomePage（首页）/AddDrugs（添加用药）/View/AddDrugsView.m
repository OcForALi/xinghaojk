//
//  AddDrugsView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddDrugsView.h"

#import "CollectionPickerView.h"
#import "AddDrugsModel.h"

@interface AddDrugsView()
@property (nonatomic, strong) BaseUseInfoItem *infoModel;//用法
@property (nonatomic, strong) BaseUseCycleItem *cycleModel;//用药周期
@property (nonatomic, strong) BaseUseNumItem *numModel;//用量
@property (nonatomic, strong) BaseUnitMinItem *unitModel;//用量单位
@end

@implementation AddDrugsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.use_drugNum = 1;
        
        [self initUI];
        
        [self block];
        
    }
    
    return self;
    
}

-(void)setModel:(DrugDosageModel *)model{
    
    _model = model;
    
//    self.drugNameLabel.text = model.drug_name;
    
//    self.standardLabel.text = model.standard;
    
    if (model.use_num != nil) {
    
        self.use_drugNum = [model.use_num integerValue];
        self.use_drugNumView.addCountString = [NSString stringWithFormat:@"%@", model.use_num];
//        self.use_numView.text = [NSString stringWithFormat:@"%@",@(self.use_numInteger)];
    }
    
    if (model.day_use_num) {

        self.day_useInteger = [model.day_use_num integerValue];
        if (self.day_useInteger <= 0) {
            self.day_useInteger = 1;
        }
        [self.day_useView setAddCountString:[NSString stringWithFormat:@"%@", @(self.day_useInteger)]];

        self.numModel = [BaseUseNumItem new];
        self.numModel.frequency_num = [NSString stringWithFormat:@"%@", model.day_use];
        if (model.use_num_name && ![model.use_num_name isKindOfClass:NSNull.class]) {
            self.numModel.use_num_name = model.use_num_name;
            self.use_numView.text = model.use_num_name;
        }
    }

//    if (model.day_use_num != nil) {
//        self.day_use_numTextField.text = [NSString stringWithFormat:@"%@",model.day_use_num];
//    }
    
    if (model.use_cycle && model.use_cycle.length > 0) {
        self.cycleModel = [BaseUseCycleItem new];
        self.cycleModel.name = model.use_cycle;
        if (model.days) {
            self.cycleModel.days = [NSString stringWithFormat:@"%@", model.days];
        }
        self.use_cycleLabel.text = model.use_cycle;
    }

    if (model.unit_name && model.unit_name.length > 0) {
        self.unit_nameLabel.text = model.unit_name;
        self.unitModel = [BaseUnitMinItem new];
        self.unitModel.minunitname = model.unit_name;
    }

    if (model.use_type && model.use_type.length > 0) {
        self.use_typeLabel.text = model.use_type;
        self.infoModel = [BaseUseInfoItem new];
        self.infoModel.use_name = model.use_type;
    }
    
//    if (model.remark) {
//        self.remarkTextView.text = model.remark;
//    }

}

-(void)setType:(NSInteger)type{
    
    _type = type;
    
    if (type == 1) {
        [self.collectionButton setTitle:@"保存" forState:UIControlStateNormal];
    }else if (type == 2 || type == 3){
        
        [self.collectionButton setTitle:@"保存" forState:UIControlStateNormal];
        
        self.collectionButton.sd_resetLayout.leftSpaceToView(self.deleteButton, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(44);
//        .topSpaceToView(self.use_drugNumView, 15)
//        .widthIs(ScreenWidth/2)
//        .heightIs(50)
//        .leftSpaceToView(self.deleteButton, 0);
        
        self.deleteButton.hidden = NO;
        
    } else{
        [self.collectionButton setTitle:@"添加" forState:UIControlStateNormal];
    }
    
}

-(void)initUI{
    
//    UIView *backView = [UIView new];
//    backView.backgroundColor = RGBA(51, 51, 51, 0.7);
//    backView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
//    [backView addGestureRecognizer:backTap];
//    [self addSubview:backView];
//
//    backView.sd_layout
//    .leftSpaceToView(self, 0)
//    .rightSpaceToView(self, 0)
//    .topSpaceToView(self, 0)
//    .bottomSpaceToView(self, 0);
    
//    UIView *view = [UIView new];
//    view.backgroundColor = RGB(237, 237, 237);
//    [self addSubview:view];
    
//    self.drugNameLabel = [UILabel new];
//    self.drugNameLabel.textColor = [UIColor lightGrayColor];
//    self.drugNameLabel.font = [UIFont systemFontOfSize:16];
//    [view addSubview:self.drugNameLabel];
//
//    self.drugNameLabel.sd_layout
//    .centerXEqualToView(view)
//    .centerYEqualToView(view)
//    .heightIs(16);
//    [self.drugNameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
//    self.scorllView = [UIScrollView new];
//    self.scorllView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.scorllView];
//
//    self.scorllView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
//    .leftSpaceToView(self, 0)
//    .widthIs(ScreenWidth)
//    .heightIs(340)
//    .bottomSpaceToView(self, 0);
    
//    view.sd_layout.bottomSpaceToView(self.scorllView, 0)
//    .leftSpaceToView(self, 0)
//    .rightSpaceToView(self, 0)
//    .heightIs(40);
    
    self.use_numInteger = 1;
    
    self.day_useInteger = 1;
    
    NSArray *titleArray = @[@"用量",@"每次",@"用法",@"用药周期",@"药品数量"];//,@"备注"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UILabel *label = [UILabel new];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self, 15)
        .topSpaceToView(self, 25 + i * 44)
        .heightIs(20);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
//        if (i == 0) {
        
//            self.standardLabel = [UILabel new];
//            self.standardLabel.font = [UIFont systemFontOfSize:14];
//            [self.scorllView addSubview:self.standardLabel];
//
//            self.standardLabel.sd_layout
//            .centerYEqualToView(label)
//            .leftSpaceToView(label, 15)
//            .heightIs(20);
//            [self.standardLabel setSingleLineAutoResizeWithMaxWidth:200];
//
//        }
        
        if (i == 0) {
            UIView *view = [UIView new];
            view.layer.borderWidth = 1;
            view.layer.borderColor = RGB(237, 237, 237).CGColor;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *use_typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerBaseUseNum)];
            [view addGestureRecognizer:use_typeTap];
            [self addSubview:view];
            
            view.sd_layout
            .leftSpaceToView(label, 15)
            .centerYEqualToView(label)
            .rightSpaceToView(self, 15)
            .heightIs(30);
            
            self.use_numView = [UILabel new];
            self.use_numView.text = @"请选择";
            self.use_numView.textAlignment = NSTextAlignmentCenter;
            self.use_numView.font = [UIFont systemFontOfSize:14];
            [view addSubview:self.use_numView];
            
            self.use_numView.sd_layout
            .leftSpaceToView(view, 10)
            .rightSpaceToView(view, 10)
            .centerYEqualToView(view)
            .heightIs(20);
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"SubscriptImg"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:imageView];
            
            imageView.sd_layout
            .rightSpaceToView(view, 5)
            .centerYEqualToView(view)
            .widthIs(12)
            .heightEqualToWidth();
            
        }
        if (i == 1) {
            
            self.day_useView = [AddCountView new];
            self.day_useView.addCountString = @"1";//[NSString stringWithFormat:@"%ld",self.day_useInteger];
            self.day_useView.showEditNum = YES;
            [self addSubview:self.day_useView];
            
            self.day_useView.sd_layout
            .leftSpaceToView(label, 15)
            .centerYEqualToView(label)
            .widthIs(140)
            .heightIs(30);
            
            UIView *view = [UIView new];
            view.layer.borderWidth = 1;
            view.layer.borderColor = RGB(237, 237, 237).CGColor;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *unit_nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerBaseUnitMin)];
            [view addGestureRecognizer:unit_nameTap];
            [self addSubview:view];
            
            view.sd_layout
            .leftSpaceToView(self.day_useView, 15)
            .centerYEqualToView(self.day_useView)
            .widthIs(80)
            .heightIs(30);
            
            self.unit_nameLabel = [UILabel new];
            self.unit_nameLabel.text = @"请选择";
            self.unit_nameLabel.font = [UIFont systemFontOfSize:14];
            [view addSubview:self.unit_nameLabel];
            
            self.unit_nameLabel.sd_layout
            .leftSpaceToView(view, 10)
            .rightSpaceToView(view, 10)
            .centerYEqualToView(view)
            .heightIs(20);
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"SubscriptImg"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:imageView];
            
            imageView.sd_layout
            .rightSpaceToView(view, 5)
            .centerYEqualToView(view)
            .widthIs(12)
            .heightEqualToWidth();
            
        }
        
        if (i == 2) {
            
            UIView *view = [UIView new];
            view.layer.borderWidth = 1;
            view.layer.borderColor = RGB(237, 237, 237).CGColor;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *unit_nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerUseBaseInfo)];
            [view addGestureRecognizer:unit_nameTap];
            [self addSubview:view];
            
            view.sd_layout
            .leftSpaceToView(label, 10)
            .centerYEqualToView(label)
            .rightSpaceToView(self, 10)
            .heightIs(30);
            
            self.use_typeLabel = [UILabel new];
            self.use_typeLabel.text = @"请选择";
            self.use_typeLabel.textAlignment = NSTextAlignmentCenter;
            self.use_typeLabel.font = [UIFont systemFontOfSize:14];
            [view addSubview:self.use_typeLabel];
            
            self.use_typeLabel.sd_layout
            .leftSpaceToView(view, 10)
            .rightSpaceToView(view, 10)
            .centerYEqualToView(view)
            .heightIs(20);
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"SubscriptImg"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:imageView];
            
            imageView.sd_layout
            .rightSpaceToView(view, 5)
            .centerYEqualToView(view)
            .widthIs(12)
            .heightEqualToWidth();
            
        }
        
        if (i == 3) {
            
            UIView *view = [UIView new];
            view.layer.borderWidth = 1;
            view.layer.borderColor = RGB(237, 237, 237).CGColor;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *use_typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerBaseUseCycle)];
            [view addGestureRecognizer:use_typeTap];
            [self addSubview:view];
            
            view.sd_layout
            .leftSpaceToView(label, 15)
            .centerYEqualToView(label)
            .rightSpaceToView(self, 15)
            .heightIs(30);
            
            self.use_cycleLabel = [UILabel new];
            self.use_cycleLabel.text = @"请选择";
            self.use_cycleLabel.textAlignment = NSTextAlignmentCenter;
            self.use_cycleLabel.font = [UIFont systemFontOfSize:14];
            [view addSubview:self.use_cycleLabel];
            
            self.use_cycleLabel.sd_layout
            .leftSpaceToView(view, 10)
            .rightSpaceToView(view, 10)
            .centerYEqualToView(view)
            .heightIs(20);
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"SubscriptImg"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:imageView];
            
            imageView.sd_layout
            .rightSpaceToView(view, 5)
            .centerYEqualToView(view)
            .widthIs(12)
            .heightEqualToWidth();
            
        }
        
        if (i == 4) {
            self.use_drugNumView = [AddCountView new];
            self.use_drugNumView.addCountString = @"1";
            [self addSubview:self.use_drugNumView];
            
            self.use_drugNumView.sd_layout
            .leftSpaceToView(label, 15)
            .centerYEqualToView(label)
            .rightSpaceToView(self, 15)
            .heightIs(30);
        }
        /*
        if (i == 6) {
            
            self.remarkTextView = [CustomTextView new];
            self.remarkTextView.placeholder = @"如有补充内容，请在这里输入";
            self.remarkTextView.placeholderColor = [UIColor lightGrayColor];
            self.remarkTextView.tag = 1000;
            self.remarkTextView.textColor = [UIColor blackColor];
            self.remarkTextView.font = [UIFont systemFontOfSize:13];
            self.remarkTextView.delegate = self;
            self.remarkTextView.layer.borderWidth = 1;
            self.remarkTextView.layer.borderColor = RGB(237, 237, 237).CGColor;
            [self.scorllView addSubview:self.remarkTextView];
            
            self.remarkTextView.sd_layout
            .leftSpaceToView(self.scorllView, 15)
            .topSpaceToView(label, 15)
            .rightSpaceToView(self.scorllView, 15)
            .heightIs(150);
            
            self.residueLabel = [UILabel new];
            self.residueLabel.text = @"0/60";
            self.residueLabel.font = [UIFont systemFontOfSize:12];
            self.residueLabel.textColor = [UIColor lightGrayColor];
            [self.scorllView addSubview:self.residueLabel];
            
            self.residueLabel.sd_layout
            .rightSpaceToView(self.scorllView, 20)
            .topSpaceToView(self.remarkTextView, -18)
            .heightIs(12);
            [self.residueLabel setSingleLineAutoResizeWithMaxWidth:100];
            
        }
        */
    }
    
    self.deleteButton = [UIButton new];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    self.deleteButton.hidden = YES;
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor: RGB(112, 112, 112)];
    [self.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
    
    self.deleteButton.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(44).widthIs(ScreenWidth/2);
    
    self.collectionButton = [UIButton new];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [self.collectionButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionButton setBackgroundColor: [UIColor orangeColor]];
    [self.collectionButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionButton];

    self.collectionButton.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(44);
    
//    self.collectionButton.sd_layout
//    .topSpaceToView(self.use_drugNumView, 20)
//    .widthIs(ScreenWidth)
//    .heightIs(50)
//    .centerXEqualToView(self);
    
//    WS(weakSelf);
//    self.collectionButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
//
//        weakSelf.scorllView.contentSize = CGSizeMake(0, frame.origin.y + 50);
//
//    };
    
}

-(void)block{
    WS(weakSelf)
    self.use_drugNumView.addBlock = ^(NSString *add) {

        weakSelf.use_drugNum++;
        weakSelf.use_drugNumView.addCountString = [NSString stringWithFormat:@"%@",@(weakSelf.use_drugNum)];

    };

    self.use_drugNumView.subtractBlock = ^(NSString *subtract) {
        if (weakSelf.use_drugNum > 1) {
            weakSelf.use_drugNum--;
            weakSelf.use_drugNumView.addCountString = [NSString stringWithFormat:@"%@",@(weakSelf.use_drugNum)];
        }

    };
    
    self.day_useView.addBlock = ^(NSString *add) {
        
        weakSelf.day_useInteger++;
        weakSelf.day_useView.addCountString = [NSString stringWithFormat:@"%@",@(weakSelf.day_useInteger)];
        
    };
    
    self.day_useView.subtractBlock = ^(NSString *subtract) {
        if (weakSelf.day_useInteger > 1) {
            weakSelf.day_useInteger--;
            weakSelf.day_useView.addCountString = [NSString stringWithFormat:@"%@",@(weakSelf.day_useInteger)];
        }
    };
    
}

/**
 用量
 */
- (void)pickerBaseUseNum {
    WS(weakSelf)
    [CollectionPickerView show:PickerTypeNum lastModel:nil complete:^(PickerAction action, id model) {
        if (action == PickerActionConfirm && model) {
            BaseUseNumItem *item = (BaseUseNumItem *)model;
            weakSelf.use_numView.text = item.use_num_name;
            weakSelf.numModel = item;
        }
        else if (action == PickerActionCustom && weakSelf.pushBlock) {
            weakSelf.pushBlock(PickerTypeNum);
        }
    }];
}

/**
 用量单位
 */
- (void)pickerBaseUnitMin {
    WS(weakSelf)
    [CollectionPickerView show:PickerTypeUnit lastModel:nil complete:^(PickerAction action, id model) {
        if (action == PickerActionConfirm && model) {
            BaseUnitMinItem *item = (BaseUnitMinItem *)model;
            weakSelf.unit_nameLabel.text = item.minunitname;
            weakSelf.unitModel = item;
        }
        else if (action == PickerActionCustom && weakSelf.pushBlock) {
            weakSelf.pushBlock(PickerTypeUnit);
        }
    }];
}

/**
 用法
 */
- (void)pickerUseBaseInfo {
    WS(weakSelf)
    [CollectionPickerView show:PickerTypeInfo lastModel:nil complete:^(PickerAction action, id model) {
        if (action == PickerActionConfirm && model) {
            BaseUseInfoItem *item = (BaseUseInfoItem *)model;
            weakSelf.use_typeLabel.text = item.use_name;
            weakSelf.infoModel = item;
        }
        else if (action == PickerActionCustom && weakSelf.pushBlock) {
            weakSelf.pushBlock(PickerTypeInfo);
        }
    }];
}

/**
 用药周期
 */
- (void)pickerBaseUseCycle {
    WS(weakSelf)
    [CollectionPickerView show:PickerTypeCycle lastModel:nil complete:^(PickerAction action, id model) {
        if (action == PickerActionConfirm && model) {
            BaseUseCycleItem *item = (BaseUseCycleItem *)model;
            weakSelf.use_cycleLabel.text = item.name;
            weakSelf.cycleModel = item;
        }
        else if (action == PickerActionCustom && weakSelf.pushBlock) {
            weakSelf.pushBlock(PickerTypeCycle);
        }
    }];
}

-(void)unit_name:(UITapGestureRecognizer *)sender{
    
    WS(weakSelf);
    
    self.unit_nameListView = [[PickerListView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.unit_nameListView.dataSource = self.unitsArray;
    [self addSubview:self.unit_nameListView];
    
    [self.unit_nameListView setDidTextStringBlock:^(NSString *textString) {
        
        weakSelf.unit_nameLabel.text = textString;
        
    }];
    
}

-(void)use_type:(UITapGestureRecognizer *)sender{
    
    WS(weakSelf);
    
    self.use_typeListView = [[PickerListView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.use_typeListView.dataSource = self.use_typeArray;
    [self addSubview:self.use_typeListView];
    
    [self.use_typeListView setDidTextStringBlock:^(NSString *textString) {
        
        weakSelf.use_typeLabel.text = textString;
        
    }];
    
}

-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    
    if (range.location >= 60){
        
        return NO;
        
    }
    
    return YES;
}
/*
- (void)textViewDidChange:(UITextView *)textView{
    [self.residueLabel setText:[NSString stringWithFormat:@"%ld/60",self.remarkTextView.text.length]];
}
*/
-(void)collection:(UIButton *)sender{
    if (!self.numModel || !self.numModel.use_num_name || self.numModel.use_num_name.length <= 0) {
        [self makeToast:@"请选择用量"];
        return;
    }
    if (!self.unitModel || !self.unitModel.minunitname || self.unitModel.minunitname.length <= 0) {
        [self makeToast:@"请选择用量单位"];
        return;
    }
    if (!self.infoModel || !self.infoModel.use_name || self.infoModel.use_name.length <= 0) {
        [self makeToast:@"请选择用法"];
        return;
    }
    if (!self.cycleModel || !self.cycleModel.name || self.cycleModel.name.length <= 0) {
        [self makeToast:@"请选择用药周期"];
        return;
    }
    
    self.model.buy_num = [NSString stringWithFormat:@"%@", @(self.use_drugNum)];
    self.model.use_num_name = self.numModel.use_num_name;
    self.model.day_use = self.numModel.use_num_name;
//    self.model.use
    self.model.day_use_num = [NSString stringWithFormat:@"%@", @(self.day_useInteger)];
    self.model.unit_name = self.unitModel.minunitname;
    self.model.use_type = self.infoModel.use_name;
    self.model.use_cycle = self.cycleModel.name;
//    self.model.remark = nil;
    self.model.days = self.cycleModel.days;
    self.model.dosage = [NSString stringWithFormat:@"%@,每次%@%@,%@,%@", self.model.use_num_name, @(self.day_useInteger), self.model.unit_name, self.model.use_type, self.model.use_cycle];
    if (self.type == 1 || self.type == 2 || self.type == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ModifyDurgDosage" object:self.model];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddDurgDosage" object:self.model];
    }

    if (self.addDurgDosageBlock) {
        self.addDurgDosageBlock(self.model);
    }
    
}

-(void)delete:(UIButton *)sender{
    
    self.model.buy_num = [NSString stringWithFormat:@"%@",@(self.use_numInteger)];
    self.model.day_use = [NSString stringWithFormat:@"%@",@(self.day_useInteger)];
//    self.model.day_use_num = self.day_use_numTextField.text;
    self.model.unit_name = self.unit_nameLabel.text;
    self.model.use_type = self.use_typeLabel.text;
//    self.model.remark = self.remarkTextView.text;
    self.model.days = @"1";
    if (self.type == 1 || self.type == 2 || self.type == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteDurgDosage" object:self.model];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddDurgDosage" object:self.model];
    }
    
    if (self.addDurgDosageBlock) {
        self.addDurgDosageBlock(self.model);
    }
    
}

-(void)back:(UITapGestureRecognizer *)sender{
    
    if (self.backBlock) {
        self.backBlock(@"关闭添加页面");
    }
    
}

@end
