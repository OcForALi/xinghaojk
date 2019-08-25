//
//  DrInfoModel.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/31.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrInfoModel.h"

@implementation DrInfoModel

-(void)setName:(NSString *)Name{
    
    _Name = Name;
    SetUserDefault(UserName, Name);
    
}

-(void)setPkid:(NSString *)Pkid{
    
    _Pkid = Pkid;
    SetUserDefault(UserID, Pkid);
    
}

-(void)setGender:(NSString *)Gender{
    
    _Gender = Gender;
    SetUserDefault(UserGender, Gender);
    
}

-(void)setHospitalName:(NSString *)HospitalName{
    
    _HospitalName = HospitalName;
    SetUserDefault(UserHospital, HospitalName);
    
}

-(void)setIntroduction:(NSString *)Introduction{
    
    _Introduction = Introduction;
    SetUserDefault(UserIntroduction, Introduction);
    
}

-(void)setRemark:(NSString *)Remark{
    
    _Remark = Remark;
    SetUserDefault(UserRemark, Remark);
    
}

-(void)setHead:(NSString *)Head{
    
    _Head = Head;
    
    if ([Head isEqualToString:@"<null>"]) {
        
    }else if(Head != nil){
        SetUserDefault(UserHead, Head);
    }

}

@end
