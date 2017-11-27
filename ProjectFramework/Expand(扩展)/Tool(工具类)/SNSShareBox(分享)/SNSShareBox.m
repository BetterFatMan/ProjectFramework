//
//  SNSShareBox.m
//  loginAndshare
//
//  Created by user on 14-8-14.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "SNSShareBox.h"
#import "GTMBase64.h"

#import "QQShareResp.h"
#import "STUUserDefaultControl.h"

@implementation ShareEntity

- (id)initWithDict:(NSDictionary *)dict
{
    if (!dict)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        self.shareUrl       = [dict safeBindStringValue:@"shareUrl"];
        self.shareTitle     = [dict safeBindStringValue:@"title"];
        self.shareContent   = [dict safeBindStringValue:@"content"];
        self.shareImg       = nil;
        self.shareType      = [[dict safeBindStringValue:@"shareType"]intValue];
        self.shareImgUrl    = [dict safeBindStringValue:@"shareImage"];
        
        if (self.shareUrl && !([self.shareUrl hasPrefix:@"http://"] || [self.shareUrl hasPrefix:@"https://"]))
        {
            self.shareUrl = [NSString stringWithFormat:@"http://%@", self.shareUrl];
        }
        
        self.shareUrl       = self.shareUrl?:@"";
        self.shareContent   = self.shareContent?:@"";
        self.shareTitle     = self.shareTitle?:@"";
        self.shareImgUrl    = self.shareImgUrl?:@"";
        
        if (self.shareImgUrl.length)
        {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.shareImgUrl]];
            
            __weak typeof(self) _wself = self;
            NSOperationQueue *queue = [NSOperationQueue currentQueue];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    _wself.shareImg = [UIImage imageWithData:data];
                    if (data.length > 60*1024)
                    {
                        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
                        [_wself.shareImg drawInRect:CGRectMake(0, 0, 300, 300)];
                        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        NSData *adata = UIImageJPEGRepresentation(img, 0.5);
                        if (adata.length > 28 * 1024)
                        {
                            adata = UIImageJPEGRepresentation(img, 0.3);
                        }
                        
                        if (!adata)
                        {
                            adata = UIImagePNGRepresentation(_wself.shareImg);
                        }
                        
                        _wself.shareImg = [UIImage imageWithData:adata];
                    }
                }
            }];
        }
    }
    return self;
}

- (NSArray *)serializeProperties
{
    return @[@"shareUrl",@"shareTitle", @"shareContent", @"shareImg", @"shareType", @"shareImgUrl"];
}

@end




@interface SNSShareBox()<QQShareRespDelegate>
@property(nonatomic, strong) TencentOAuth       *tencentOAuth;

@property(nonatomic, strong) QQShareResp        *shareResp;

@end

@implementation SNSShareBox
{
        /// 存放登录后的用户的OpenID、Token以及过期时间
    NSString                        *_accessToken;
        /// 请求参数
    NSDictionary                    *_params;
        /// 新浪微博认证时间
    long long int                   _sinaExpiresIn;
        ///新浪微博userID
    NSString                        *_sinaUserID;
        ///新浪微博access_token
    NSString                        *_sinaAccessToken;
        /// 微信认证时间
    long long int                   _wxExpiresIn;
        /// 微信openid
    NSString                        *_wxOpenID;
        ///微信access_token
    NSString                        *_wxAccessToken;
        ///第三方用户信息
    NSMutableArray                  *_userInfoArr;
}


-(id)init
{
    self = [super init];
    if (nil != self)
    {
    
//        [WeiboSDK enableDebugMode:YES];
//        [WeiboSDK registerApp:kSinaWeiboAppKey];
        [WXApi registerApp:kWXAppID];
        _userInfoArr = [NSMutableArray array];
        
        _shareResp = [[QQShareResp alloc] init];
        _shareResp.delegate = self;
    }
    return self;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    BOOL weiboRet = NO;
    if ([url.absoluteString hasPrefix:@"wb"])
    {
//        weiboRet = [WeiboSDK handleOpenURL:url delegate:self];
    }
    else if([url.absoluteString hasPrefix:@"tencent"])
    {
        weiboRet = [TencentOAuth HandleOpenURL:url] || [QQApiInterface handleOpenURL:url delegate:_shareResp];
    }
    else if ([url.absoluteString hasPrefix:@"wx"])
    {
        weiboRet = [WXApi handleOpenURL:url delegate:self];
    }
        /// 响应手Q支付回送的支付结果消息
//    else if([url.absoluteString hasPrefix:kQQPayAppName])
//    {
//        NSMutableDictionary *queryDict = [[NSMutableDictionary alloc] initWithCapacity:10];
//        NSArray *queryArray = [[url query] componentsSeparatedByString:@"&" ];
//        for( NSString *paramItem in queryArray)
//        {
//            NSArray *pairArray = [paramItem componentsSeparatedByString:@"=" ];
//            if( [pairArray count] == 2 )
//            {
//                [queryDict setObject:pairArray[1] forKey:pairArray[0]];
//            }
//        }
//        
//        if([[url host] isEqualToString:@"response_from_qq"] &&
//           [[queryDict safeBindStringValue:@"version"] isEqualToString:@"1"] &&
//           [[queryDict safeBindStringValue:@"source"] isEqualToString:@"qq"] &&
//           [[queryDict safeBindStringValue:@"source_scheme"] isEqualToString:@"mqqapi"]
//           )
//        {
//            NSString *errorNo = [queryDict safeBindStringValue:@"error"];
//            if([errorNo isEqualToString:@"0"] )
//            {
//                NSLog(@"支付成功");
//                [kNotificationCenter postNotificationName:kQQPaySucceed object:nil];
//            }
//            else
//            {
//                    /// 支付出错处理 具体内容需要base64解码
//                NSString *errMsg = [[NSString alloc] initWithData:[GTMBase64 decodeString:[queryDict safeBindStringValue:@"error_description"]] encoding:NSUTF8StringEncoding];
//                NSLog(@"支付出错:%@", errMsg);
//                [kNotificationCenter postNotificationName:kQQPayFailed object:nil];
//            }
//        }
//        else
//        {
//                //返回的基本参数不匹配，这种有可能是版本不匹配或冒充的QQ,建议记录下来或者提示用户反馈处理
//            NSLog(@"错误格式的手机QQ支付通知返回");
//            [kNotificationCenter postNotificationName:kQQPayFailed object:nil];
//        }
//        return YES;
//    }
    return weiboRet;
}


- (void)loginWithType:(SNSSharePlatformType)OtherLoginType
{
    if (SNSSharePlatformTypeQQ == OtherLoginType)
    {
        if (!_tencentOAuth) {
            _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
        }
        NSArray* permissions = [NSArray arrayWithObjects:
                                kOPEN_PERMISSION_GET_USER_INFO,
                                kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                kOPEN_PERMISSION_ADD_ALBUM,
                                kOPEN_PERMISSION_ADD_ONE_BLOG,
                                kOPEN_PERMISSION_ADD_SHARE,
                                kOPEN_PERMISSION_ADD_TOPIC,
                                kOPEN_PERMISSION_CHECK_PAGE_FANS,
                                kOPEN_PERMISSION_GET_INFO,
                                kOPEN_PERMISSION_GET_OTHER_INFO,
                                kOPEN_PERMISSION_LIST_ALBUM,
                                kOPEN_PERMISSION_UPLOAD_PIC,
                                kOPEN_PERMISSION_GET_VIP_INFO,
                                kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                                nil];
            //判断用户是否安装QQ客户端以及客户端是否支持sso登录
        [self.tencentOAuth authorize:permissions inSafari:NO];        
    }
    else if (SNSSharePlatformTypeSina == OtherLoginType)
    {
            ///微博登录
//        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//        request.redirectURI = kSinaWeiboRedicrctURI;
//        request.scope = @"all";
//        request.userInfo = nil;
//        [WeiboSDK sendRequest:request];
    }
    else if (SNSSharePlatformTypeWeiXin == OtherLoginType)
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                ///微信登录
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"123";
            [WXApi sendReq:req];
        } else {
            [InternetErrorMsgView showInternetErrorMsgView:@"您还没有安装微信" hideAfterDuration:1.2];
        }
    }
}

#pragma mark TencentLoginDelegate
- (void)tencentDidLogin
{
        // 登录成功
    if (self.tencentOAuth.accessToken
        && 0 != [self.tencentOAuth.accessToken length])
    {
        [STUUserDefaultControl shareInstance].cacheTencentOpenID = [NSString stringWithFormat:@"%@",self.tencentOAuth.openId];
        [STUUserDefaultControl shareInstance].cacheTencentAccessToken = [NSString stringWithFormat:@"%@",self.tencentOAuth.accessToken];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
        {
            __weak typeof(self) _wself = self;
            [self userInfo:SNSSharePlatformTypeQQ completeBlock:^(NSMutableArray *userInfoArr) {
                
                [_wself.delegate LoginSuccess:SNSSharePlatformTypeQQ andOpenid:@"QQ" userInfo:userInfoArr];
            }];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onlyLoginSuccess:expireInStr:)]) {
            
            double timeDouble = self.tencentOAuth.expirationDate.timeIntervalSince1970*1000;
            NSString *expireInStr1 = [NSString stringWithFormat:@"%.0f", timeDouble];
            [self.delegate onlyLoginSuccess:SNSSharePlatformTypeQQ expireInStr:expireInStr1];
        }
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
    {
//        [self.delegate LoginFail:@"用户取消"];
    }
}

-(void)tencentDidNotNetWork
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
    {
        [self.delegate LoginFail:@"网络连接失败"];
    }
}


#pragma mark WeiboSDKDelegate

//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
//    {
//            ///判断用户是否分享成功
//        if ((int)response.statusCode == WeiboSDKResponseStatusCodeSuccess)
//        {
//            [self SendSuccess:0];
//        }
//        else
//        {
//            [self SendFail:0];
//        }
//    }
//    else if ([response isKindOfClass:WBAuthorizeResponse.class])
//    {
//            ///判断用户是否登录成功
//        if ((int)response.statusCode == WeiboSDKResponseStatusCodeSuccess)
//        {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
//            {
//                _sinaUserID = [(WBAuthorizeResponse *)response userID];
////                [UserDefaultControl shareInstance].cacheSinaUserID = [NSString stringWithFormat:@"%@",_sinaUserID];
//                _sinaAccessToken = [(WBAuthorizeResponse *)response accessToken];
////                [UserDefaultControl shareInstance].cacheSinaAccessToken = [NSString stringWithFormat:@"%@",_sinaAccessToken];
//                
//                __weak typeof(self) _wself = self;
//                [self userInfo:SNSSharePlatformTypeSina completeBlock:^(NSMutableArray *userInfoArr) {
//                    
////                    [_wself.delegate LoginSuccess:SNSSharePlatformTypeSina andOpenid:[UserDefaultControl shareInstance].cacheSinaUserID userInfo:userInfoArr];
//                }];
//            }
//        }
//        else
//        {
//            if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
//            {
//                [self.delegate LoginFail:@"授权失败"];
//            }
//        }
//    }
//}


#pragma mark WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        if (resp.errCode == 0)
        {
            SendAuthResp *aresp = (SendAuthResp *)resp;
            [self getAccessTokenWithCode:aresp.code];
        }
        else if (resp.errCode == -4 && nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
        {
            [self.delegate LoginFail:@"用户拒绝"];
        }
        else if (resp.errCode == -2 && nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
        {
            [self.delegate LoginFail:@"用户取消"];
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (0 == resp.errCode)
        {
            [self SendSuccess:1];
        }
        else
        {
            [self SendFail:1];
        }
    }
    else if ([resp isKindOfClass:[PayResp class]])
    {
    
        /**
         微信支付结果

         @param resultDic msg：支付结果msg；result：支付结果，3为支付取消
         @return resultDic
         */
        PayResp *response = (PayResp *)resp;
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
        [resultDic setObject:@"1" forKey:@"payType"];
        if (response.returnKey.length) {
            [resultDic setObject:response.returnKey forKey:@"msg"];
        }
        if (response.errCode == WXSuccess)
        {
            [resultDic setObject:@(1) forKey:@"result"];
//            [kNotificationCenter postNotificationName:kMemberShipOrderResultString object:resultDic];
//            [kNotificationCenter postNotificationName:kWeixinPaySuccessNotification object:resp];
            //mAlertView(@"微信提示", @"支付成功");
        }
        else if (response.errCode == WXErrCodeCommon)
        {
            [resultDic setObject:@(2) forKey:@"result"];
//            [kNotificationCenter postNotificationName:kMemberShipOrderResultString object:resultDic];
//            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
            //mAlertView(@"微信提示", @"签名错误，支付失败");
        }
        else if (response.errCode == WXErrCodeUserCancel)
        {
            [resultDic setObject:@(3) forKey:@"result"];
//            [kNotificationCenter postNotificationName:kMemberShipOrderResultString object:resultDic];
//                ///取消操作
//            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
        }
        else
        {
            [resultDic setObject:@(4) forKey:@"result"];
            NSLog(@"errCode:%d",response.errCode);
//            [kNotificationCenter postNotificationName:kMemberShipOrderResultString object:resultDic];
//            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
            //mAlertView(@"微信提示", response.errStr);
        }
    }
}

- (void)getAccessTokenWithCode:(NSString *)code
{
        ///使用code获取access token
    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAppID,kWXAppSecret,code];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onlyLoginSuccess:expireInStr:)]) {
        
        if (_wxAccessToken && _wxAccessToken.length) {
            [self.delegate onlyLoginSuccess:SNSSharePlatformTypeWeiXin expireInStr:[self getWXExpiresIn]];
        } else {
            
            __weak typeof(self) _wself = self;
            [GetUserInfo sendRequest:[NSURL URLWithString:urlString] completeBlock:^(NSDictionary *resultDict)
             {
                 if (resultDict)
                 {
                     _wxAccessToken = [resultDict safeBindValue:@"access_token"];
                     [STUUserDefaultControl shareInstance].cacheWXAccessToken = _wxAccessToken;
                     _wxOpenID = [resultDict safeBindValue:@"openid"];
                     [STUUserDefaultControl shareInstance].cacheWXOpenID = _wxOpenID;
                     _wxExpiresIn = [[resultDict safeBindStringValue:@"expires_in"] longLongValue];
                     
                     [_wself.delegate onlyLoginSuccess:SNSSharePlatformTypeWeiXin expireInStr:[_wself getWXExpiresIn]];
                 }
             }];
            
        }
        
    } else if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)]) {
        __weak typeof(self) _wself = self;
        [GetUserInfo sendRequest:[NSURL URLWithString:urlString] completeBlock:^(NSDictionary *resultDict)
         {
             if (resultDict)
             {
                 if (_wself.delegate && [_wself.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
                 {
                     _wxAccessToken = [resultDict safeBindValue:@"access_token"];
                     [STUUserDefaultControl shareInstance].cacheWXAccessToken = _wxAccessToken;
                     _wxOpenID = [resultDict safeBindValue:@"openid"];
                     [STUUserDefaultControl shareInstance].cacheWXOpenID = _wxOpenID;
                     _wxExpiresIn = [[resultDict safeBindStringValue:@"expires_in"] longLongValue];
                     
                     [_wself userInfo:SNSSharePlatformTypeWeiXin completeBlock:^(NSMutableArray *userInfoArr) {
                         
                         [_wself.delegate LoginSuccess:SNSSharePlatformTypeWeiXin andOpenid:@"WEIXIN" userInfo:userInfoArr];
                     }];
                 }
             }
         }];
    }
}


- (void)userInfo:(SNSSharePlatformType)otherType completeBlock:(void (^)(NSMutableArray *userInfoArr))completeBlock
{
        ///获取第三方的用户信息
    NSString *urlString = nil;
    switch (otherType)
    {
        case SNSSharePlatformTypeQQ:
        {
            
            double timeDouble = self.tencentOAuth.expirationDate.timeIntervalSince1970*1000;
            NSString *expireInStr = [NSString stringWithFormat:@"%.0f", timeDouble];
            
                // 验证是否绑定用户
            [GetUserInfo sendUserInfoGetBindThings:@{ @"openId":[STUUserDefaultControl shareInstance].cacheTencentOpenID, @"accessToken":[STUUserDefaultControl shareInstance].cacheTencentAccessToken, @"expireIn":expireInStr, @"type":@"QQ" } completeBlock:^(NSDictionary *resultDict) {
                if (resultDict)
                {
                    NSMutableArray *array = [NSMutableArray arrayWithObject:resultDict];
                    if (completeBlock) {
                        completeBlock(array);
                    }
                }
            }];
            
        }
            break;
        case SNSSharePlatformTypeSina:
        {
//            urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",[UserDefaultControl shareInstance].cacheSinaAccessToken,[UserDefaultControl shareInstance].cacheSinaUserID];
            
            [GetUserInfo userInfo:urlString andType:@"weibo" completeBlock:^(NSMutableArray *arr) {
                
                if (completeBlock)
                {
                    completeBlock(arr);
                }
            }];
        }
            break;
        case SNSSharePlatformTypeWeiXin:
        {
            
            double timeDouble = _wxExpiresIn*1000;
            NSString *expireInStr = [NSString stringWithFormat:@"%.0f", timeDouble];
            
                // 验证是否绑定用户
            [GetUserInfo sendUserInfoGetBindThings:@{ @"openId":[STUUserDefaultControl shareInstance].cacheWXOpenID, @"accessToken":[STUUserDefaultControl shareInstance].cacheWXAccessToken, @"expireIn":expireInStr, @"type":@"WEIXIN" } completeBlock:^(NSDictionary *resultDict) {
                if (resultDict)
                {
                    NSMutableArray *array = [NSMutableArray arrayWithObject:resultDict];
                    if (completeBlock) {
                        completeBlock(array);
                    }
                }
            }];
            
        }
            break;
    }
}

- (NSString *)getQQExpiresIn
{
    double timeDouble = self.tencentOAuth.expirationDate.timeIntervalSince1970*1000;
    NSString *expireInStr = [NSString stringWithFormat:@"%.0f", timeDouble];
    return expireInStr;
}

- (NSString *)getWXExpiresIn
{
    double timeDouble = _wxExpiresIn*1000;
    NSString *expireInStr = [NSString stringWithFormat:@"%.0f", timeDouble];
    return expireInStr;
}

- (BOOL)isInstallSNSQQ
{
    return [QQApiInterface isQQInstalled];
}

- (BOOL)isInstallSNSWX
{
    return [WXApi isWXAppInstalled];
}

- (void)logOutWithType
{
    [self.tencentOAuth logout:self];
    
    self.tencentOAuth = nil;
//    [WeiboSDK logOutWithToken:_sinaAccessToken delegate:self withTag:nil];
    _wxAccessToken = nil;
    _wxOpenID = nil;
}

#pragma mark tencentLoginOutDelegate
- (void)tencentDidLogout
{
    self.tencentOAuth.accessToken = @"";
}


#pragma mark - 分享内容
/**
 QQ分享
 type:分享图片的方式，1是为分享网络图片（http）；2是为本地图片（uiimage）
 */
- (void)qqShare:(NSDictionary *)params withType:(NSInteger)type
{
    NSString *shareMessage = [params objectForKey:@"shareMessage"];
    NSString *shareURL     = [params objectForKey:@"shareURL"];
    
    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
    
    if ([TencentOAuth iphoneQQInstalled])
    {
        if (!_tencentOAuth) {
            _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
        }
        if (type == 1)
        {
            NSString  *shareImage   = [params objectForKey:@"shareImage"];
            
            NSURL *previewURL = [NSURL URLWithString:shareImage];
            NSURL* url = [NSURL URLWithString:shareURL];
            
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:shareTitle description:shareMessage previewImageURL:previewURL];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        }
        else if (type == 2)
        {
            UIImage *shareImage   = [params objectForKey:@"shareImage"];

            NSData* data = UIImagePNGRepresentation(shareImage);
            NSURL* url = [NSURL URLWithString:shareURL];
            
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:shareTitle description:shareMessage previewImageData:data];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        }
    }
    else
    {
        mAlertView(@"QQ提示",@"您还没有安装手机QQ，请先安装。");
    }
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            mAlertView(@"Error", @"App未注册");
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            mAlertView(@"Error", @"发送参数错误");
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            mAlertView(@"Error", @"未安装手Q");
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            mAlertView(@"Error", @"API接口不支持");
            break;
        }
        case EQQAPISENDFAILD:
        {
            mAlertView(@"Error", @"发送失败");
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - QQShareRespDelegate
- (void)showQQShareResult:(NSInteger)tyepe
{
    if (tyepe == 1) {
        [self SendSuccess:3];
    } else {
        [self SendFail:3];
    }
}

//----------------------------------------------------------------------------//

/**
 QQ Zone分享
 */
- (void)qqZoneShare:(NSDictionary *)params
{
    NSString *shareMessage = [params objectForKey:@"shareMessage"];
    NSString *shareURL     = [params objectForKey:@"shareURL"];
//    UIImage *shareImage   = [params objectForKey:@"shareImage"];
    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
    
    if (!_tencentOAuth) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
    }
    
    if ([TencentOAuth iphoneQQInstalled])
    {
        UIImage *shareImage   = [params objectForKey:@"shareImage"];
        
        NSData* data = UIImagePNGRepresentation(shareImage);
        NSURL* url = [NSURL URLWithString:shareURL];
        
        QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:url title:shareTitle description:shareMessage previewImageData:data];
        [imgObj setTitle:shareTitle ? : @""];
        [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
        
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
        
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        
        [self handleSendResult:sent];
    }
    else
    {
        if ([TencentOAuth iphoneQZoneInstalled])
        {
            UIImage *shareImage   = [params objectForKey:@"shareImage"];
            
            NSData* data = UIImagePNGRepresentation(shareImage);
            NSURL* url = [NSURL URLWithString:shareURL];
            
            QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:url title:shareTitle description:shareMessage previewImageData:data];
            [imgObj setTitle:shareTitle ? : @""];
            [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
            
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            [self handleSendResult:sent];
        }
        else
        {
            mAlertView(@"QQ提示",@"您还没有安装手机QQ或者QQ空间，请先安装。");
        }
    }
}

    ///微信分享
- (void)sendAppContentWithMessage:(NSDictionary *)params WithScene:(int)scene
{
    NSString *shareMessage = [params objectForKey:@"shareMessage"];
    NSString *shareURL     = [params objectForKey:@"shareURL"];
    UIImage  *shareImage   = [params objectForKey:@"shareImage"];
    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
        // 发送内容给微信
    BOOL isWXAppInstall = [WXApi isWXAppInstalled];
    if (isWXAppInstall)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        if (WXSceneTimeline == scene)
        {
            message.title = shareMessage;
        }
        else
        {
            message.title = shareTitle;
        }
        message.description = shareMessage;
        [message setThumbImage:shareImage];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = shareURL;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
        
        [WXApi sendReq:req];
    }
    else
    {
        mAlertView(@"微信提示",@"您还没有安装微信，请先安装。");
    }
}

- (void)arrangeHomeworkToShareImage:(UIImage *)shareImage type:(NSInteger)shareType
{
    if (shareType==1 || shareType==4) {
            /* 1 分享到QQ; 4  分享到QQ空间 */
        if (!_tencentOAuth) {
            _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
        }
        
        if ([TencentOAuth iphoneQQInstalled]) {
            
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:UIImagePNGRepresentation(shareImage) previewImageData:nil title:@"" description:@"" imageDataArray:nil];
            if (shareType==4) {
                [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
            }
            
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            [self handleSendResult:sent];
        } else {
            if (shareType==4 && [TencentOAuth iphoneQZoneInstalled]) {
                QQApiImageObject *imgObj = [QQApiImageObject objectWithData:UIImagePNGRepresentation(shareImage) previewImageData:nil title:@"" description:@"" imageDataArray:nil];
                [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
                
                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
                
                QQApiSendResultCode sent = [QQApiInterface sendReq:req];
                
                [self handleSendResult:sent];
            } else {
                if (shareType==1) {
                    mAlertView(@"QQ提示",@"您还没有安装手机QQ，请先安装。");
                } else {
                    mAlertView(@"QQ提示",@"您还没有安装手机QQ或者QQ空间，请先安装。");
                }
            }
            
        }
        
    } else if (shareType == 2 || shareType == 3) {
            /* 2 分享到微信; 3分享到微信朋友圈 */
        
        BOOL isWXAppInstall = [WXApi isWXAppInstalled];
        if (isWXAppInstall) {
            
            WXImageObject *imgOb = [WXImageObject object];
            imgOb.imageData = UIImagePNGRepresentation(shareImage);
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.mediaObject = imgOb;
            
            message.title = @"悠数学-教师端";
            NSData *data = UIImageJPEGRepresentation(shareImage, 0.2);
            if (data.length > 32*1024) {
                data = UIImageJPEGRepresentation(shareImage, 0.1);
                if (data.length > 32*1024) {
                    
                    UIImage *tempImage = [UIImage imageWithData:data];
                    
                    UIImage *drawImage = [self imageWithImage:tempImage scaledToSize:CGSizeMake(tempImage.size.width*0.7, tempImage.size.height*0.7)];
                    data = UIImageJPEGRepresentation(drawImage, 0.1);
                    if (data.length > 32*1024) {
                        UIImage *drawImg = [self imageWithImage:tempImage scaledToSize:CGSizeMake(tempImage.size.width*0.2, tempImage.size.height*0.2)];
                        data = UIImageJPEGRepresentation(drawImg, 0.1);
                        if (data.length > 32*1024) {
                            UIImage *drImg = [self imageWithImage:drawImg scaledToSize:CGSizeMake(drawImg.size.width*0.2, drawImg.size.height*0.2)];
                            data = UIImageJPEGRepresentation(drImg, 0.1);
                            if (data.length > 32*1024) {
                                data = UIImagePNGRepresentation([UIImage imageNamed:@"app_share_logo"]);
                            }
                        }
                    }
                }
            }
            [message setThumbData:data];
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = shareType==2?WXSceneSession:WXSceneTimeline;
            
            [WXApi sendReq:req];
            
        } else {
            mAlertView(@"微信提示",@"您还没有安装微信，请先安装。");
        }
    }
}

-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

    ///微博分享
//- (void)weiboShare:(NSDictionary *)params
//{
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:params]];
//    [WeiboSDK sendRequest:request];
//}
//
//- (WBMessageObject *)messageToShare:(NSDictionary *)params
//{
//    NSString *shareMessage = [params objectForKey:@"shareMessage"];
//    NSString *shareURL     = [params objectForKey:@"shareURL"];
//    UIImage  *shareImage   = [params objectForKey:@"shareImage"];
//    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
//    WBMessageObject *message = [WBMessageObject message];
//    WBWebpageObject *webpage = [WBWebpageObject object];
//    webpage.objectID = @"identifier1";
//    webpage.title = shareTitle;
//    webpage.description = shareMessage;
//    webpage.thumbnailData = UIImagePNGRepresentation(shareImage);
//    webpage.webpageUrl = shareURL;
//    message.mediaObject = webpage;
//    return message;
//}

#pragma mark - 分享结果
    ///分享成功
/*
 * shareType : 0(wb); 1(wx); 2(QQZone); 3(QQ);
 */
- (void)SendSuccess:(int)shareType
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendSuccess:)])
    {
        [self.delegate shareEngineSendSuccess:shareType];
    }
}

    ///分享失败
- (void)SendFail:(int)shareType
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendFail:)])
    {
        [self.delegate shareEngineSendFail:shareType];
    }
}

@end
