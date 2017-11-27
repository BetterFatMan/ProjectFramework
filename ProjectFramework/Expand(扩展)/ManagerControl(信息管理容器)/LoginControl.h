//
//  LoginControl.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/9.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "UserEntity.h"
#import "SNSShareBox.h"


@interface LoginControl : NSObject
{
    
}

@property(nonatomic, assign) EnumLoginType       loginType;
//@property(nonatomic, strong) UserEntity         *loginUser;
@property(nonatomic, assign) NSInteger           textbookIndex;
@property(nonatomic, strong) NSString           *stageStr;//阶段－高中，初中

@property(nonatomic, strong) NSString           *XGDeviceToken;

@property(nonatomic, strong) SNSShareBox        *shareBox;

+ (instancetype)shareInstance;

- (void)loginSuccessGoRegisterXGToken;
    /// 用户退出登录
- (void)userLogout;

@end
