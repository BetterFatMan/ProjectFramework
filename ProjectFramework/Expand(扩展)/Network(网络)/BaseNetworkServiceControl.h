//
//  BaseNetworkServiceControl.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MKNetworkKit.h"

NS_ASSUME_NONNULL_BEGIN

    /// 用户信息相关错误码
    /// 内部异常
#define kErrorRequestCode                   (1)
    /// 无效会话
#define kLoginExpWrong                      (101)
    /// 登录过期
#define kLoginExp                           (501)
    /// 账号长时间未登录（需要重新登录）
#define kErrorACCOUNT_LONG_NOLOGIN          (430)
    /// 账号异常（需要重新登录）
#define kErrorACCOUNT_EXCEPTION             (431)
    /// 接口的未知错误
#define kUnknownApiErrCode                  (-10000)
    /// 接口返回的response字段数据错误
#define kApiResponseDataErrCode             (-101)
    /// 用户名或密码错误
#define kErrorAccountPassword               (1751)
    /// 不支持老师登录
#define kNOT_SUPPORT_TEACHER                (1752)
    /// 账号被禁用
#define kErrorACCOUNT_FORBIDDEN             (1753)
    /// 用户名已经存在
#define kErrorACCOUNT_NAME_EXIST            (1754)
    /// 班级码错误
#define kError_CLASSCODE_WRONG              (1851)

    //接口响应中status正确值(即未出错时)
#define kApiResponseOk                      (0)
#define kRequestTimeOut                     (60)

@interface NSError(Ext)
    /// 扩展属性
@property(nonatomic, strong, nullable) NSString *errMsg;

@end

@interface BaseNetworkServiceControl : NSObject

@property (nonatomic, copy, nullable) NSString *requestId;

@property (nonatomic, strong, nullable) NSString       *headerToken;

    // 判断请求是否为payload方式，以此上传数据
@property (nonatomic, strong, nullable) NSString       *payloadString;

/**
 是不是使用ssl证书请求
 */
@property (nonatomic, assign) BOOL      isHttpsRequest;

+ (MKNetworkEngine *)shareEngine;

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg;

    ///如果子类也要使用, 则子类必须实现该方法, 默认返回nil
+ (instancetype)shareDataControl;

- (void)getApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

    /// 上传图片
- (void)postImgApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

+ (void)cancelOperationsContainingURLString:(NSString *)url;

/**
 取消app内部所有的请求线程
 */
+ (void)cancelAllRequest;

/**
 cancel当前serviceControl的所有请求线程
 */
- (void)cancelOperation;

/**
 请求success之后所调用函数
 */
- (void)handelRequestSuccessedAction;

/**
 由于登录token失效至请求Fail之后所调用函数
 */
- (void)handelRequestFailedWithResultLoginFailed;

@end

NS_ASSUME_NONNULL_END
