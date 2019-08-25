//
//  AddCountView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddCountView.h"

@implementation AddCountView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)initUI{
    
    self.layer.borderColor = RGB(237, 237, 237).CGColor;
    self.layer.borderWidth = 1;
    
    UIButton *subtractButton = [UIButton new];
    [subtractButton setTitle:@"-" forState:UIControlStateNormal];
    [subtractButton setBackgroundColor:RGB(237, 237, 237)];
    [subtractButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subtractButton addTarget:self action:@selector(subtract:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subtractButton];
    
    subtractButton.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .widthIs(40)
    .heightIs(30);
    
    self.addLabel = [UILabel new];
    self.addLabel.font = [UIFont systemFontOfSize:14];
    self.addLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.addLabel];
    
    UIButton *addButton = [UIButton new];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setBackgroundColor:RGB(237, 237, 237)];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    
    addButton.sd_layout
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .widthIs(40)
    .heightIs(30);
    
    self.addLabel.sd_layout
    .leftSpaceToView(subtractButton, 0)
    .rightSpaceToView(addButton, 0)
    .centerYEqualToView(subtractButton)
    .heightIs(20);
    
    self.numBox = [[UITextField alloc] init];
    self.numBox.textAlignment = NSTextAlignmentCenter;
    self.numBox.font = kFontRegular(14);
    self.numBox.textColor = [UIColor blackColor];
    self.numBox.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.numBox];
    self.numBox.sd_layout.leftSpaceToView(subtractButton, 0).rightSpaceToView(addButton, 0).centerYEqualToView(subtractButton).heightIs(30);
}

- (void)setShowEditNum:(BOOL)showEditNum {
    _showEditNum = showEditNum;
    self.addLabel.hidden = showEditNum;
    if (showEditNum) {
        self.numBox.text = self.addLabel.text;
        self.numBox.hidden = !showEditNum;
    }
}

-(void)setAddCountString:(NSString *)addCountString{
    
    _addCountString = addCountString;
    
    self.addLabel.text = addCountString;
    if (self.numBox) {
        self.numBox.text = addCountString;
    }
}

-(void)add:(UIButton *)sender{
    
    if (self.addBlock) {
        self.addBlock(self.addLabel.text);
    }
    
}

-(void)subtract:(UIButton *)sender{
    
    if (self.subtractBlock) {
        self.subtractBlock(self.addLabel.text);
    }
    
}

@end
