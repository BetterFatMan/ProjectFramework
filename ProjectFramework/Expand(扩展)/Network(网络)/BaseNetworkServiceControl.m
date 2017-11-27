//
//  BaseNetworkServiceControl.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "BaseNetworkServiceControl.h"

@implementation NSError(Ext)

- (void)setErrMsg:(NSString *)msg
{
    objc_setAssociatedObject(self, "errMsg", msg, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)errMsg
{
    return objc_getAssociatedObject(self, "errMsg");
}

- (NSString *)localizedDescription
{
#ifdef DEBUG
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld, 原始错误信息:\n%@\n", (long)self.code, [self.userInfo objectForKey:NSLocalizedDescriptionKey]];
#endif
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld", (long)self.code];
}

@end

@interface BaseNetworkServiceControl ()
@end

@implementation BaseNetworkServiceControl
static MKNetworkEngine *_shareInstanceEngine = nil;
static MKNetworkEngine *_shareImgPostEngine = nil;

+ (MKNetworkEngine *)shareEngine
{
    if (!_shareInstanceEngine) {
        NSString *baseUrl = kMainWebsite;
        _shareInstanceEngine = [[MKNetworkEngine alloc] initWithHostName:baseUrl];
        [UIImageView setDefaultEngine:_shareInstanceEngine];
        [_shareInstanceEngine useCache];
    }
    return _shareInstanceEngine;
}

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg
{
    if (errCode == -1003) {
        NSLog(@"11");
    }
        //这里最好是读取一个配置文件(json格式{"404":"服务错误"}), 根据errCode找对应的错误提示信息
    switch (errCode)
    {
        case kLoginExp:
        errMsg = @"登录状态已失效，请重新登录";
        break;
        case kLoginExpWrong:
        errMsg = @"登录状态已失效，请重新登录";
        break;
        case 504:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"网络连接失败, 服务器出问题了(504)";
        break;
        case 306:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"网络连接失败, 服务器出问题了(306)";
        break;
        case -1009:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"网络连接失败, 请检查您的网络. 如是否设置了代理等";
        break;
        case -1001:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"网络请求超时(-1001)";
        break;
        case -1004:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"未能连接到服务器(-1004)";
        break;
        case 400:
        case 404:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"http错误";
        break;
        case 500:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"服务器出现错误(http status code 500)";
        break;
        case 502:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"服务器正在重启，请稍后再试";
        break;
        case kUnknownApiErrCode:
        errMsg = @"您的网络连接异常，请稍后再试！";//@"请求出现未知错误";
        break;
            //        case kNullUsernamePassword:
            //            errMsg = @"用户名或密码为空";
            //            break;
            //        case kErrorAccountPassword:
            //            errMsg = @"用户名或密码错误";
            //            break;
            //        case kError_CLASSCODE_WRONG:
            //            errMsg = @"班级码错误";
            //            break;
            //        case kErrorRequestCode:
            //            errMsg = @"内部异常";
            //            break;
            //        case kNOT_SUPPORT_TEACHER:
            //            errMsg = @"不支持老师登录";
            //            break;
            //        case kErrorACCOUNT_FORBIDDEN:
            //            errMsg = @"账号被禁用";
            //            break;
            //        case kErrorACCOUNT_NAME_EXIST:
            //            errMsg = @"用户名已经存在";
            //            break;
        default:
        break;
    }
    
    NSError *err = [NSError errorWithDomain:@"com.yooMath.err" code:errCode userInfo:nil];
    if (errMsg.length == 0)
        {
        errMsg = @"您的网络连接异常，请稍后再试！";
        }
    err.errMsg = errMsg;
    return err;
}


    ///如果子类也要使用, 则子类必须实现该方法
+ (instancetype)shareDataControl
{
    return nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isHttpsRequest = NO;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"cancelOperation by dealloc %@", [NSString stringWithFormat:@"%@", self]);
    [self cancelOperation];
}

- (void)cancelOperation
{
    NSLog(@"cancelOperation %@", [NSString stringWithFormat:@"%@", self]);
    if (self.requestId && self.requestId.length > 0) {
        [MKNetworkEngine cancelOperationsContainingURLString:self.requestId];
    }else {
        [MKNetworkEngine cancelOperationsContainingURLString:[NSString stringWithFormat:@"%@", self]];
    }
}

- (void)getApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:nil httpMethod:@"GET" networkEngine:nil completeBlock:completeBlock];
}


- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:nil httpMethod:@"POST" networkEngine:nil completeBlock:completeBlock];
}


- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:files httpMethod:@"POST" networkEngine:nil completeBlock:completeBlock];
}

    /// 上传图片
- (void)postImgApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:files httpMethod:@"POST" networkEngine:[[self class] shareEngine] completeBlock:completeBlock];
}

- (void)makeRequestOperation:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files httpMethod:(NSString *)method networkEngine:(MKNetworkEngine *)netEngine completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    method = method ? method : @"GET";
    MKNetworkEngine *networkEngine = netEngine ? netEngine : [[self class] shareEngine];
    NSMutableDictionary *conbinePars = [NSMutableDictionary dictionary];
    if ([params count]) {
        if ([method isEqualToString:@"POST"] && ![files count]) {
            [conbinePars addEntriesFromDictionary:params];
        } else {
            [conbinePars addEntriesFromDictionary:params];
        }
    }
    
    MKNetworkOperation *operation = [networkEngine operationWithPath:path params:conbinePars httpMethod:method ssl:_isHttpsRequest];
    if (_isHttpsRequest) {
        /* 在请求中添加证书 */
        operation.clientCertificate = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"client.p12"];
        operation.clientCertificatePassword = @"test";
        
        /* 当服务器端证书不合法时是否继续访问 */
        operation.shouldContinueWithInvalidCertificate=YES;
    }
    ((NSMutableURLRequest *)operation.readonlyRequest).timeoutInterval = kRequestTimeOut;
    
        // qq登录之后设置token值
    if (self.headerToken && self.headerToken.length) {
        [(NSMutableURLRequest *)operation.readonlyRequest setValue:self.headerToken forHTTPHeaderField:@"S_T"];
    }
    
    if (self.requestId && self.requestId.length > 0) {
        operation.operationIdentifier = self.requestId;
    }else {
        operation.operationIdentifier = [NSString stringWithFormat:@"%@_%lf", self, [[NSDate date] timeIntervalSince1970]];
    }
    
    if ([files count]) {
        method = @"POST";
        for (NSString *key in files.allKeys) {
            if (params && [params count]) {
                NSString *ext = [[files[key] pathExtension] lowercaseString];
                NSString *mimeType = @"multipart/form-data";
                if ([ext isEqualToString:@"jpg"]) {
                    mimeType = @"image/jpg";
                } else if ([ext isEqualToString:@"jpeg"]) {
                    mimeType = @"image/jpeg";
                } else if ([ext isEqualToString:@"png"]) {
                    mimeType = @"image/png";
                } else if ([ext isEqualToString:@"m4a"]) {
                    mimeType = @"audio/m4a";
                } else if ([ext isEqualToString:@"mp4"]) {
                    mimeType = @"video/mp4";
                }
                [operation addFile:files[key] forKey:key mimeType:mimeType];
            } else {
                [operation addFile:files[key] forKey:key];
                    // setFreezable uploads your images after connection is restored!
                [operation setFreezable:YES];
            }
        }
    }
    
    if([method isEqualToString:@"POST"] && ![files count]) {
//        operation.postDataEncoding = MKNKPostDataEncodingTypeURL;
    }
    
    /*
     * 修改数据方式preload，上传data
     */
    if (_payloadString && _payloadString.length) {
        [operation addPostBodyData:_payloadString forType:@"application/text"];
    }
    
    __weak typeof(self) _weakSelf = self;
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"REQUEST SUCCESS %@", completedOperation);
            //所有接口返回的错误都将会在这里被处理, 转化成相应的NSError并返回给调用方, 以便提示
        NSError *err = nil;
        BOOL isSuccess = YES;
        NSDictionary *respDict = completedOperation.responseJSON;
        if (completedOperation.HTTPStatusCode != 200) {
            err = [BaseNetworkServiceControl errorWithApiErrorCode:completedOperation.HTTPStatusCode errMsg:[NSString stringWithFormat:@"http请求错误, 错误码%ld", (long)completedOperation.HTTPStatusCode]];
            isSuccess = NO;
        } else if (![respDict isKindOfClass:[NSDictionary class]]) {
                //ERROR CODE :-10000未知错误
            err = [BaseNetworkServiceControl errorWithApiErrorCode:kUnknownApiErrCode errMsg:@""];
            isSuccess = NO;
        } else {
            NSDictionary *responseDict = [respDict safeBindValue:@"ret"];
            if (!responseDict) {
                responseDict = respDict;
            }
            if (![responseDict isKindOfClass:[NSDictionary class]] && ![responseDict isKindOfClass:[NSArray class]]) {
                    //ERROR CODE :-101未知错误
                err = [BaseNetworkServiceControl errorWithApiErrorCode:kApiResponseDataErrCode errMsg:@"返回response数据格式错误"];
                isSuccess = NO;
            } else {
                NSInteger errCode = [[respDict safeBindValue:@"ret_code"] integerValue];
                NSString *errMsg = [respDict safeBindValue:@"ret_msg"];
                if (errCode != kApiResponseOk) {
                    err = [BaseNetworkServiceControl errorWithApiErrorCode:errCode errMsg:errMsg];
                    isSuccess = NO;
                }
            }
        }
            /// 如果登录失效 弹出登录框
        if (err.code == kLoginExp || err.code == kLoginExpWrong || err.code == kErrorACCOUNT_LONG_NOLOGIN || err.code == kErrorACCOUNT_EXCEPTION) {
            
            [_weakSelf handelRequestFailedWithResultLoginFailed];
        } else {
            
            [_weakSelf handelRequestSuccessedAction];
            
            if (completeBlock) {
                completeBlock(isSuccess, completedOperation, err);
            }
        }
    }
                       errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                           
                           NSError *err = [BaseNetworkServiceControl errorWithApiErrorCode:error.code errMsg:@""];
                           if (completeBlock) {
                               completeBlock(NO, completedOperation, err);
                            }
                       }];
    [networkEngine enqueueOperation:operation];
}


+ (void)cancelOperationsContainingURLString:(NSString *)url
{
    [MKNetworkEngine cancelOperationsContainingURLString:url];
}

+ (void)cancelAllRequest
{
    NSString *baseUrl = kMainWebsite;
    [MKNetworkEngine cancelOperationsContainingURLString:baseUrl];
}

/**
 请求success之后所调用函数
 */
- (void)handelRequestSuccessedAction {
}

/**
 请求Fail之后所调用函数
 */
- (void)handelRequestFailedWithResultLoginFailed {
}

@end
