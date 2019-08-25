//
//  SignViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SignViewController.h"
#import "SignRequest.h"
#import "SignModel.h"

@interface SignViewController ()

@property (nonatomic ,strong) UIView *BGView;

@property (nonatomic ,retain) SignModel *model;

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"签到拿积分";

    [self request];
    
}

-(void)initUI{
    
    self.BGView = [UIView new];
    self.BGView.backgroundColor = kMainColor;
    [self.view addSubview:self.BGView];
    
    self.BGView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(200);
    
    UIImageView *logoImageView = [UIImageView new];
    logoImageView.image = [UIImage imageNamed:@"Public_Logo"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.layer.cornerRadius = 35;
    logoImageView.layer.masksToBounds = YES;
    [self.BGView addSubview:logoImageView];
    
    logoImageView.sd_layout
    .centerXEqualToView(self.BGView)
    .topSpaceToView(self.BGView, 20)
    .widthIs(70)
    .heightEqualToWidth();
    
    UILabel *rulesLabel = [UILabel new];
    rulesLabel.text = @"签到规则";
    rulesLabel.textColor = [UIColor whiteColor];
    rulesLabel.backgroundColor = [UIColor lightGrayColor];
    rulesLabel.font = [UIFont systemFontOfSize:14];
    rulesLabel.textAlignment = NSTextAlignmentCenter;
    rulesLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *rulesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rules:)];
    [rulesLabel addGestureRecognizer:rulesTap];
    [self.BGView addSubview:rulesLabel];
    
    rulesLabel.sd_layout
    .rightSpaceToView(self.BGView, 0)
    .topSpaceToView(self.BGView, 30)
    .widthIs(80)
    .heightIs(30);

    UILabel *titleView = [UILabel new];
    titleView.text = @"记得明天再来领取积分~";
    titleView.font = [UIFont systemFontOfSize:16];
    titleView.textColor = [UIColor whiteColor];
    [self.BGView addSubview:titleView];
    
    titleView.sd_layout
    .centerXEqualToView(self.BGView)
    .topSpaceToView(logoImageView, 20)
    .heightIs(16);
    [titleView setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *subTitleView = [UILabel new];
    subTitleView.text = [NSString stringWithFormat:@"已连续签到%@天",self.model.continuity_sign_days];
    subTitleView.textColor = [UIColor whiteColor];
    subTitleView.font = [UIFont systemFontOfSize:14];
    [self.BGView addSubview:subTitleView];
    
    subTitleView.sd_layout
    .centerXEqualToView(self.BGView)
    .topSpaceToView(titleView, 15)
    .heightIs(14);
    [subTitleView setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *remarkLabel = [UILabel new];
    remarkLabel.text = self.model.remark;
    remarkLabel.textColor = [UIColor orangeColor];
    remarkLabel.font = [UIFont systemFontOfSize:14];
    [self.BGView addSubview:remarkLabel];
    
    remarkLabel.sd_layout
    .centerXEqualToView(self.BGView)
    .topSpaceToView(subTitleView, 15)
    .heightIs(14);
    [remarkLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    NSString *string = [NSString stringWithFormat:@"%@年%@月%@日",@(currentYear),@(currentMonth),@(currentDay)];
    
    UILabel *dateLabel = [UILabel new];
    dateLabel.text = string;
    dateLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:dateLabel];
    
    dateLabel.sd_layout
    .leftSpaceToView(self.view, 15)
    .topSpaceToView(self.BGView, 10)
    .heightIs(16);
    [dateLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(93, 171, 255);
    [self.view addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(dateLabel, 15)
    .heightIs(1);
    
    NSArray *weekdayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    for (int i = 0; i < weekdayArray.count; i++) {
        
        UILabel *label = [UILabel new];
        label.text = weekdayArray[i];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self.view, 0 + i * (ScreenWidth/7))
        .topSpaceToView(lineView, 15)
        .widthIs(ScreenWidth/7)
        .heightIs(16);
        
    }
    
    UIView *line1View = [UIView new];
    line1View.backgroundColor = RGB(157, 157, 157);
    [self.view addSubview:line1View];
    
    line1View.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(lineView, 47)
    .heightIs(1);
    
    NSInteger dateInteger = [self getNumberOfDaysInMonth];
    
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *string1 = [NSString stringWithFormat:@"%@-%@-1 08:00:40",@(currentYear),@(currentMonth)];

    NSDate *currentTime = [formatter dateFromString:string1];
    
    NSString *location = [self getweekDayWithDate:currentTime];
    
    NSInteger integer = 0;
    NSInteger countInteger = [location integerValue] - 1;
    
    NSInteger dayInteger = 0;
    
    for (int i = [location intValue] - 1; i < dateInteger + [location intValue] - 1; i++) {
        
        countInteger = i%7;
        
        dayInteger++;
        
        CGSize size = CGSizeMake(ScreenWidth/7, ScreenWidth/7);
        
        UIView *calendarView = [UIView new];
        calendarView.layer.borderWidth = 0.5;
        calendarView.layer.borderColor = RGB(157, 157, 157).CGColor;
        [self.view addSubview:calendarView];
        
        calendarView.sd_layout
        .leftSpaceToView(self.view, 0 + countInteger * size.width)
        .topSpaceToView(line1View, 0 + integer * size.height)
        .widthIs(size.width)
        .heightEqualToWidth();
        
        UILabel *label = [UILabel new];
        
        for (NSString *string in self.model.sign_his) {
            
            if ([string integerValue] == dayInteger) {
                
                label.text = @"签";
                label.layer.cornerRadius = ScreenWidth/8/2;
                label.layer.masksToBounds = YES;
                label.layer.borderWidth = 1;
                label.layer.borderColor = [UIColor orangeColor].CGColor;
                label.textColor = [UIColor orangeColor];
                
            }
            
        }

        if (currentDay == dayInteger) {
            
            label.text = @"签";
            label.layer.cornerRadius = ScreenWidth/8/2;
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 1;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = kMainColor;
            label.layer.borderColor = kMainColor.CGColor;
            
        }
        
        if (label.text == nil) {
            
            label.text = [NSString stringWithFormat:@"%@",@(dayInteger)];
            
        }
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [calendarView addSubview:label];
        
        label.sd_layout
        .centerXEqualToView(calendarView)
        .centerYEqualToView(calendarView)
        .widthIs(ScreenWidth/8)
        .heightEqualToWidth();
        
        if (countInteger == 6) {
            integer++;
        }
        
    }
    
}

- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDate * currentDate = [NSDate date];
    // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:currentDate];
    return range.length;
}

- (id) getweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    return @([comps weekday]);
    
}

-(void)request{
    
    WS(weakSelf)
    [[SignRequest new] postSign:^(HttpGeneralBackModel *model) {
        [weakSelf getSignData];
    }];
}

- (void)getSignData {
    WS(weakSelf)
    [[SignRequest new] getSignDetail:^(HttpGeneralBackModel *model) {
        
        weakSelf.model = [SignModel new];
        [weakSelf.model setValuesForKeysWithDictionary:model.data];
        
        [weakSelf initUI];
        
    }];
}

-(void)rules:(UITapGestureRecognizer *)sender{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.sign_rules dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    UILabel *label = [UILabel new];
    [label setAttributedText:attrStr];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:label.text preferredStyle:UIAlertControllerStyleAlert];
    
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];

    [alert addAction:ok];//添加确认按钮
    
    //以modal的形式
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
