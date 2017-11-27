//
//  LoginControl.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/9.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "LoginControl.h"
#import "FileCacheControl.h"

#import "XGPush.h"

#define kSTUSelectTextBook          (@"kSTUSelectTextBook")
#define kSTUSelectStage             (@"kSTUSelectStage")

@implementation LoginControl

static LoginControl *_loginControl = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _loginControl = [[LoginControl alloc] init];
    });
    return _loginControl;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginType = EnumLoginTypeNomal;
    }
    return self;
}

    /// 用户退出登录
- (void)userLogout
{
//    self.loginUser = nil;
    self.loginType = EnumLoginTypeNomal;
    
    
//    [XGPush unRegisterDevice];
    [kUserDefaults setObject:@"" forKey:kUserToken];
    [kUserDefaults setObject:@"" forKey:kUserLoginTypeIsSuccess];
    
    [kUserDefaults synchronize];
    
    [self.shareBox logOutWithType];
}

#pragma mark - Getter
//- (void)setTextbookIndex:(NSInteger)textbookIndex
//{
//    [kUserDefaults setInteger:textbookIndex forKey:kSTUSelectTextBook];
//    [kUserDefaults synchronize];
//}
//
//- (NSInteger)textbookIndex
//{
//    return [kUserDefaults integerForKey:kSTUChooseTextbook];
//}

- (void)setStageStr:(NSString *)stageStr
{
    [kUserDefaults setObject:stageStr forKey:kSTUSelectStage];
    [kUserDefaults synchronize];
}

- (NSString *)stageStr
{
    return [kUserDefaults stringForKey:kSTUSelectStage];
}

//- (void)setLoginUser:(UserEntity *)loginUser
//{
//    [FileCacheControl shareInstance].cacheUserEntity = loginUser;
//}
//
//- (UserEntity *)loginUser
//{
//    return [FileCacheControl shareInstance].cacheUserEntity;
//}

- (void)setLoginType:(EnumLoginType)loginType
{
    [kUserDefaults setInteger:loginType forKey:@"kUserLoginType"];
    [kUserDefaults synchronize];
}

- (EnumLoginType)loginType
{
    return [kUserDefaults integerForKey:@"kUserLoginType"];
}

- (NSString *)XGDeviceToken
{
    return [kUserDefaults stringForKey:@"XGDeviceTokenString"];
}

- (void)setXGDeviceToken:(NSString *)XGDeviceToken
{
    [kUserDefaults setObject:XGDeviceToken forKey:@"XGDeviceTokenString"];
    [kUserDefaults synchronize];
}

- (void)loginSuccessGoRegisterXGToken
{
    
}

- (SNSShareBox *)shareBox
{
    if (_shareBox == nil) {
        _shareBox = [SNSShareBox new];
    }
    return _shareBox;
}

@end
