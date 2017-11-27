//
//  SNSShareBox.h
//  loginAndshare
//
//  Created by user on 14-8-14.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import "WeiboSDK.h"
#import "WXApi.h"
//#import "UserDefaultControl.h"
#import "WXPayEntryActivity.h"
#import "GetUserInfo.h"
//#import "BlockAlertView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "ProjectBaseModel.h"

@interface ShareEntity : ProjectBaseModel

@property(nonatomic, strong) NSString *shareUrl;
@property(nonatomic, strong) NSString *shareTitle;
@property(nonatomic, strong) NSString *shareContent;
@property(nonatomic, strong) UIImage  *shareImg;
@property(nonatomic, assign) int       shareType;
@property(nonatomic, strong) NSString *shareImgUrl;

@end




typedef enum
{
    SNSSharePlatformTypeSina,
    SNSSharePlatformTypeQQ,
    SNSSharePlatformTypeWeiXin
}SNSSharePlatformType;

//WeiboSDKDelegate  WBHttpRequestDelegate
@protocol SNSShareBoxDelegate;
@interface SNSShareBox : NSObject<TencentSessionDelegate,WXApiDelegate,UIAlertViewDelegate, QQApiInterfaceDelegate>

@property (nonatomic, weak) id<SNSShareBoxDelegate> delegate;


- (BOOL)handleOpenURL:(NSURL *)url;

    ///**
    // *@description 第三方登录
    // *@param weibotype:第三方登录类型
    // */
- (void)loginWithType:(SNSSharePlatformType)OtherLoginType;

/**
 *@description 退出登录
 *@param weibotype:第三方登录类型
 */- (void)logOutWithType;

- (NSString *)getQQExpiresIn;
- (NSString *)getWXExpiresIn;

    /* 判断是否有安装QQ或者微信 */
- (BOOL)isInstallSNSQQ;
- (BOOL)isInstallSNSWX;

/**
 QQ分享
 */
- (void)qqShare:(NSDictionary *)params withType:(NSInteger)type;

/**
 QQ Zone分享
 */
- (void)qqZoneShare:(NSDictionary *)params;

/**
 微信分享
 */
- (void)sendAppContentWithMessage:(NSDictionary *)params WithScene:(int)scene;

/**
 微博分享
 */
//- (void)weiboShare:(NSDictionary *)params;

/**
 分享布置作业成功图片

 @param shareImage 图片
 @param shareType  1:QQ 2:WX
 */
- (void)arrangeHomeworkToShareImage:(UIImage *)shareImage type:(NSInteger)shareType;

@end




@protocol SNSShareBoxDelegate <NSObject>
@optional

    ///仅仅用于QQ获取第三方权限成功之后
- (void)onlyLoginSuccess:(SNSSharePlatformType)type expireInStr:(NSString *)expireInStr;

- (void)LoginSuccess:(SNSSharePlatformType) otherLoginType andOpenid:(NSString *) openId userInfo:(NSMutableArray *)userInfoArr;

- (void)LoginFail:(NSString *)errStr;

- (void)shareEngineSendSuccess:(int)shareType;

- (void)shareEngineSendFail:(int)shareType;
@end

