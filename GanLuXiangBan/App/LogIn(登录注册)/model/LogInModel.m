//
//  LogInModel.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "LogInModel.h"

@implementation LogInModel

-(void)setName:(NSString *)name{
    
    _name = name;
    SetUserDefault(UserName, name);
    
}

-(void)setPkid:(NSString *)pkid{
    
    _pkid = pkid;
    SetUserDefault(UserID, pkid);
    
}

-(void)setMobileno:(NSString *)mobileno{
    
    _mobileno = mobileno;
    SetUserDefault(UserPhone, mobileno);
    
}

-(void)setCheck_status:(NSInteger)check_status{
    
    _check_status = check_status;
    
    NSString *string = [NSString stringWithFormat:@"%ld",check_status];
    
    SetUserDefault(UserCheck_status, string);
    
}

@end
